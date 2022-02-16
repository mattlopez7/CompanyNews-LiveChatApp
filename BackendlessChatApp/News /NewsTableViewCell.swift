//
//  NewsTableViewCell.swift
//  Lordstown Motors News
//
//  Created by Matthew Lopez on 8/9/21.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let publishedAt: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        publishedAt: String,
        imageURL: URL?
        ) {
        self.title = title
        self.subtitle = subtitle
        self.publishedAt = publishedAt
        self.imageURL = imageURL
    }
    
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(publishedAtLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 170,
                                      height: 70
        )
        subtitleLabel.frame = CGRect(x: 10,
                                      y: 60,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2
        )
        publishedAtLabel.frame = CGRect(x: 10,
                                      y: 100,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2
        )
        newsImageView.frame = CGRect(x: contentView.frame.size.width-150,
                                      y: 10,
                                      width: 140,
                                      height: contentView.frame.size.height - 20
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        publishedAtLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        publishedAtLabel.text = viewModel.publishedAt
        
        // Image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL{
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
        }
    }

}
