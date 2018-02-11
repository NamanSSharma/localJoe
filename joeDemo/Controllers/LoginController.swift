import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController {
   
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    var ref: DatabaseReference!
    let reachability = Reachability()!
    
    @IBAction func segmentClick(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 //Login User
        {   name.isHidden = true;
        }else{
        name.isHidden = false;
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if user.text != "" && pass.text != ""
        {
            if segmentControl.selectedSegmentIndex == 0 //Login User
            {
                Auth.auth().signIn(withEmail: user.text!, password: pass.text!, completion: {
                    (user, error) in
                    
                    if user != nil
                    {
                        //Successful
                        print("SUCCESS")
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    else
                    {
                        // create the alert
                        let alert = UIAlertController(title: "Invalid Login", message: "Sorry, the Email/Password do not match our records", preferredStyle: UIAlertControllerStyle.alert)
                        // add the actions (buttons)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                            print("ERROR")
                        }
                    }
                })
                
            }
            else
            {
                Auth.auth().createUser(withEmail: user.text!, password: pass.text!, completion: { (newUser, error) in
                    if newUser != nil
                    {
                        //Successful
                        print("SUCCESS")
                        let values = ["name": self.name.text!, "email": self.user.text!, "joeType": "none", "numPhotos": "0"]
                        let userID : String = (Auth.auth().currentUser?.uid)!
                        let usersRef = self.ref.child("users").child(userID);
                        usersRef.updateChildValues(values, withCompletionBlock: {(err,ref) in
                            if err != nil{
                                print(err as Any)
                                return
                            }
                            print("Saved user successfully into Firebase DB")
                        })
                        
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    else
                    {
                        // create the alert
                        let alert = UIAlertController(title: "Invalid Sign Up", message: "\(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                        // add the actions (buttons)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        if let myError = error?.localizedDescription
                        {
                            print(myError)
                        }
                        else
                        {
                            print("ERROR")
                        }
                    }
                })
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        ref = Database.database().reference()
        if segmentControl.selectedSegmentIndex == 0 //Login User
        {   name.isHidden = true;
        }
       
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                // create the alert
                let alert = UIAlertController(title: "No Internet Connection", message: "Sorry, this app will not work without any internet connection", preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)

        
        //no internet connection start
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async{
                // create the alert
                let alert = UIAlertController(title: "No Internet", message: "Sorry, the app can't function without the internet.", preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
            
        }catch{
            print("could not start notifier")
        }
    }
    
    @objc func internetChanged(note: Notification){
        let reachability = note.object as! Reachability
        if reachability.isReachable {
        }else{
            let alert = UIAlertController(title: "No Internet", message: "Sorry, the app can't function without the internet.", preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    //no internet connection end
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        user.resignFirstResponder()
        pass.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

