# Reachability305
This is built on top of Apple's Reachability class. It handles all changes in network connectivity and displays a message to the user accordingly. The Reachability feature also supports custom views so you can display to the user any information you like. 

# Implementation

Import the Reachability305 framework
```
import Reachability305
```

## Notification Example
The Reachability feature calls the "flagsChanged" notification when there is a change from either 'No Internet', 'WWAN', 'WIFI'. Complete the following steps to receive a callback when there is a change in connectivity.

Conform to the Reachable protocol to get notified when there is a change in the device connectivity. To comply with the protocol, you must add the connectionDidChange function.
```
extension ViewController: Reachable {
    func connectionDidChange(message: String) {
        //do something when there is a change in connectivity
    }
}
```

To receive notifications, you must call the subscribeToReachableNotifications function inside your viewDidLoad. You can also use UnsubscribeToReachableNotifications() inside your deinit.
```
override func viewDidLoad() {
    super.viewDidLoad()
    subscribeToReachableNotifications()
}

deinit {
    unsubscribeToReachableNotifications()
}
```
 
## Custom View Example
ReachabilityDefaultView is the default view used by the ReachabilityManager. But you can create a custom UIView that can be used to display a message to the user.

Create a UIView, and extend the view to the Reachability protocol.
```
extension ReachabilityDefaultView: ReachabilityView {
    
}
```

Create a ReachabilityViewDelegate property inside your ReachabilityView to communicate with the ReachabilityManager. The ReachabilityManager conforms to the ReachabilityViewDelegate in order to listen to your ReachabilityView.
```
var delegate: ReachabilityViewDelegate?
```

Conform to the protocol's required functions. The ReachabilityManager will tell your view to do several actions such as loadMessage, showView, and hideView. You will need to inform the delegate when your view has shown and when it has appeared by calling the delegate?.reachabilityViewDidShow() and delegate?.reachabilityViewDidHide() functions.
```
extension ReachabilityDefaultView: ReachabilityView {
    
    func loadMessage(message: String?) {
        //populate your view with this new message
    }
    
    func showView() {
        //example animation of the view appearing into user's screen
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
           self.frame.origin.y = UIScreen.main.bounds.maxY - self.frame.size.height
        }, completion: { (true) in
            
            self.delegate?.reachabilityViewDidShow()
        })
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.frame.origin.y = UIScreen.main.bounds.maxY
        }, completion: { (true) in
            self.delegate?.reachabilityViewDidHide()
        })
    }
}
```

To setup the ReachabilityManager with your custom view, create an instance of the ReachabilityManager in your appDelegate.

```
let reachabilityManager = ReachabilityManager.shared
```

Inside the didFinishLaunchingWithOptions function, create an instance of your custom view and attach it to the reachabilityManager. Your app will now run the detect any changes in connectivity and display your custom view upon action.

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    //Reachability
    let customReachabilityView: CustomReachabilityView = {
        let height: CGFloat = UIScreen.main.bounds.size.height / 14
        let view = CustomReachabilityView(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.size.width, height: height))
        return view
    }()
    reachabilityManager.setupWith(view: customReachabilityView)

    return true
}
```
