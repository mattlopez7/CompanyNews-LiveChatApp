
import UIKit

class TextMessageCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 10
        self.textView.translatesAutoresizingMaskIntoConstraints = false
    }
}
