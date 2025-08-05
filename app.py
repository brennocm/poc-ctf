from flask import Flask, render_template, request, redirect, url_for, session
import subprocess

app = Flask(__name__)
app.secret_key = 'supersecretkey'  # Não seguro em produção!

# Usuário fixo para CTF
USER = "admin"
PASS = "ctf123"

@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['username'] == USER and request.form['password'] == PASS:
            session['logged_in'] = True
            return redirect(url_for('panel'))
        else:
            return render_template('login.html', error="Credenciais inválidas.")
    return render_template('login.html')

@app.route('/panel', methods=['GET', 'POST'])
def panel():
    if not session.get('logged_in'):
        return redirect(url_for('login'))

    output = ''
    if request.method == 'POST':
        ip = request.form['ip']
        try:
            # ⚠️ Vulnerabilidade proposital!
            cmd = f"ping -c 1 {ip}"
            output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT, text=True)
        except subprocess.CalledProcessError as e:
            output = e.output
    return render_template('panel.html', output=output)

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
