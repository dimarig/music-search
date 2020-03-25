import UIKit
import PinLayout
import AlamofireImage
import AwaitKit

class MusicTableViewCell: UITableViewCell {
    
    static let identifier = "musicCell"
    
    let artworkImageView = UIImageView()
    let artistLabel = UILabel()
    let songNameLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(artworkImageView)
        
        artistLabel.numberOfLines = 1
        artistLabel.font = UIFont.systemFont(ofSize: 14)
        artistLabel.textColor = .black
        addSubview(artistLabel)
        
        songNameLabel.numberOfLines = 1
        songNameLabel.font = UIFont.systemFont(ofSize: 15)
        songNameLabel.textColor = .black
        addSubview(songNameLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        artworkImageView.pin
            .left(10)
            .vCenter()
            .height(40)
            .width(40)
        
        songNameLabel.pin
            .after(of: artworkImageView)
            .marginLeft(10)
            .top(10)
            .right(10)
            .sizeToFit(.width)
        
        artistLabel.pin
            .left(to: songNameLabel.edge.left)
            .below(of: songNameLabel)
            .marginTop(8)
            .right(10)
            .sizeToFit(.width)
    }
    
    func setup(musicItem: MusicItemDTO){
        artistLabel.text = musicItem.artistName
        songNameLabel.text = musicItem.trackName
        if let songLogo = musicItem.artworkUrl100, let songImageUrl = URL(string: songLogo) {
            async {
                self.artworkImageView.af.setImage(withURL: songImageUrl, placeholderImage: UIImage(named: "ImagePlaceholder"))
            }
        }
    }
    
    override func prepareForReuse() {
        artworkImageView.image = UIImage(named: "ImagePlaceholder")
    }
}
