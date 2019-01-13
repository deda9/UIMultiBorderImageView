# UIMultiBorderImageView

You can add more than one border for UIImageView

```swift
topImageView.layer.cornerRadius = topImageView.frame.size.width/2
topImageView.clipsToBounds = true
topImageView.apply(borders: [Border(width: 5, color: UIColor.green),
                             Border(width: 5, color: UIColor.blue)])
```
<img src="https://github.com/deda9/UIMultiBorderImageView/blob/master/image1.png" height="280" width="380">


```swift
bottomImageView.apply(borders: [Border(width: 5, color: UIColor.red),
                                Border(width: 5, color: UIColor.yellow),
                                Border(width: 5, color: UIColor.green),
                                Border(width: 5, color: UIColor.blue)])
```
<img src="https://github.com/deda9/UIMultiBorderImageView/blob/master/image2.png" height="280" width="380">
