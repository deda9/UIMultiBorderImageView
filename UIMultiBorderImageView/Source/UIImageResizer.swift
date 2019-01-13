import UIKit.UIImage

class UIImageResizer {
    
    class func resize(_ image: UIImage,
                      contentMode: UIView.ContentMode,
                      forRect rect: CGRect) -> UIImage {
        switch contentMode {
        case .scaleAspectFit, .scaleAspectFill:
            return handleAspectFit_AspectFill(image, contentMode: contentMode, forRect: rect)
            
        case .center, .top, .bottom:
            return handleCenterContent(image, contentMode: contentMode, forRect: rect)
            
        case .left, .bottomLeft, .topLeft:
            return handleLeftContent(image, contentMode: contentMode, forRect: rect)
            
        case .right, .bottomRight, .topRight:
            return handleRightContent(image, contentMode: contentMode, forRect: rect)
            
        case .scaleToFill, .redraw:
            return image
        }
    }
}

private extension UIImageResizer {
    class func handleAspectFit_AspectFill(_ image: UIImage,
                                          contentMode: UIView.ContentMode,
                                          forRect rect: CGRect) -> UIImage {
        
        let heightRatio = image.height / rect.height
        let widthRatio = image.width / rect.width
        let minRatio = min(heightRatio, widthRatio)
        let imageRect = CGRect(x: 0, y: 0, width: image.width / minRatio, height: image.height / minRatio)
        return drawImage(image, rect: rect, imageRect: imageRect)
    }
    
    class func handleCenterContent(_ image: UIImage,
                                   contentMode: UIView.ContentMode,
                                   forRect rect: CGRect) -> UIImage {
        
        var imageRect = CGRect(origin: .zero, size: image.size)
    
        switch contentMode {
        case .top:
            imageRect.origin.y = 0
            imageRect.origin.x = (rect.width - imageRect.width) / 2
        
        case .center:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = (rect.width - imageRect.width) / 2
            imageRect.origin.y = fullHeight / 2
        
        case .bottom:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = (rect.width - imageRect.width) / 2
            imageRect.origin.y = fullHeight
        default:
            break
        }
        
        return drawImage(image, rect: rect, imageRect: imageRect)
    }
    
    class func handleLeftContent(_ image: UIImage,
                                 contentMode: UIView.ContentMode,
                                 forRect rect: CGRect) -> UIImage {
        var imageRect = CGRect(origin: .zero, size: image.size)
        
        switch contentMode {
        case .topLeft:
            imageRect.origin.y = 0
            imageRect.origin.x = 0
            
        case .left:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = 0
            imageRect.origin.y = fullHeight / 2
            
        case .bottomLeft:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = 0
            imageRect.origin.y = fullHeight
        default:
            break
        }
        
        return drawImage(image, rect: rect, imageRect: imageRect)
    }
    
    class func handleRightContent(_ image: UIImage,
                                  contentMode: UIView.ContentMode,
                                  forRect rect: CGRect) -> UIImage {
        var imageRect = CGRect(origin: .zero, size: image.size)
        
        switch contentMode {
        case .topRight:
            imageRect.origin.y = 0
            imageRect.origin.x = (rect.width - imageRect.width)
            
        case .right:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = (rect.width - imageRect.width)
            imageRect.origin.y = fullHeight / 2
            
        case .bottomRight:
            let fullHeight = rect.height - imageRect.height
            imageRect.origin.x = (rect.width - imageRect.width)
            imageRect.origin.y = fullHeight
        default:
            break
        }
        
        return drawImage(image, rect: rect, imageRect: imageRect)
    }
    
    class func drawImage(_ image: UIImage, rect: CGRect, imageRect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        image.draw(in: imageRect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? image
    }
}


extension CGRect {
    var height: CGFloat {
        return self.size.height
    }
    
    var width: CGFloat {
        return self.size.width
    }
}

extension UIImage {
    var height: CGFloat {
        return self.size.height
    }
    
    var width: CGFloat {
        return self.size.width
    }
}
