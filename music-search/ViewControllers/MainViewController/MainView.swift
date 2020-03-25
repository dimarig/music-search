import Foundation
import UIKit
import PinLayout

class MainView: UIView {
    
    let musicTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        musicTableView.backgroundColor = .white
        musicTableView.allowsSelection = false
        addSubview(musicTableView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        musicTableView.pin.all()
    }
}
