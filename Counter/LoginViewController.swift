//
//  LoginViewController.swift
//  Counter
//
//  Created by MacOSMini on 05.11.2024.
//

import UIKit


final class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberUsernameSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isRemembered = UserDefaults.standard.bool(forKey: "rememberUsername")
        rememberUsernameSwitch.isOn = isRemembered
        
        if isRemembered, let savedUsername = UserDefaults.standard.string(forKey: "username") {
            usernameTextField.text = savedUsername
        }
        
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        guard presentedViewController == nil else { return }

        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Пожалуйста, введите имя пользователя и пароль.")
            return
        }
        
        if rememberUsernameSwitch.isOn {
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(true, forKey: "rememberUsername")
        } else {
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.set(false, forKey: "rememberUsername")
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let counterVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                window.rootViewController = counterVC
                window.makeKeyAndVisible()
                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка входа", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
