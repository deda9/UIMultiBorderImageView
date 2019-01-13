import UIKit

extension UIImageView {
    func apply(borders: [Border]) {
        if self.layer.cornerRadius == 0.0 || self.clipsToBounds == false {
            applyWithoutRound(borders)
        } else {
            applyWithRound(borders)
        }
        resizeImage(borders)
    }
}

private extension UIImageView {
    
    func applyWithoutRound(_ borders: [Border]) {
        var frame = self.layer.frame
        var x: CGFloat = 0
        var y:  CGFloat = 0
        
        borders.forEach { border in
            let layer = Init(CAShapeLayer()) {
                $0.borderColor = border.lineColor.cgColor
                $0.borderWidth = border.lineWidth
                $0.fillColor = UIColor.clear.cgColor
            }
            frame.origin.x = x
            frame.origin.y = y
            
            x += border.lineWidth
            y += border.lineWidth
            
            layer.frame = frame
            frame.size.width -= border.lineWidth * 2
            frame.size.height -= border.lineWidth * 2
            self.layer.addSublayer(layer)
        }
    }
    
    func applyWithRound(_ borders: [Border]) {
        
        var frame = self.layer.frame
        var totalBorderWidth:CGFloat = 0.0
        
        borders.forEach { border in
            
            let layer = Init(CAShapeLayer()) { [unowned self] in
                $0.strokeColor = border.lineColor.cgColor
                $0.lineWidth = border.lineWidth
                $0.fillColor = UIColor.clear.cgColor
                $0.cornerRadius = self.layer.cornerRadius
            }
            
            frame.origin.x = 0
            frame.origin.y = 0
            layer.frame = frame
            totalBorderWidth += border.lineWidth
            let halfSize = min( frame.size.width / 2, frame.size.height / 2)
            let centerPoint = CGPoint(x: halfSize, y: halfSize)
            let raduis = CGFloat(halfSize - totalBorderWidth + border.lineWidth / 2)
            
            
            let circlePath = UIBezierPath(
                arcCenter: centerPoint,
                radius: raduis,
                startAngle: CGFloat(0),
                endAngle: CGFloat.pi * 2,
                clockwise: true)
            
            layer.path = circlePath.cgPath
            
            self.layer.addSublayer(layer)
        }
    }
    
    func resizeImage(_ borders: [Border]) {
        guard let image = self.image else {
            return
        }
        let inset: CGFloat = borders.reduce(0.0) { return $0 + $1.lineWidth }
        let imageRect = self.frame.insetBy(dx: inset, dy: inset)
        let resizedUIImage = UIImageResizer.resize(image, contentMode: self.contentMode, forRect: imageRect)
        self.image = resizedUIImage
    }
}

struct Border {
    var lineWidth: CGFloat
    var lineColor: UIColor
    
    init(width: CGFloat, color: UIColor) {
        self.lineWidth = width
        self.lineColor = color
    }
}

func Init<Type>(_ object: Type, block: (Type) -> ()) -> Type {
    block(object)
    return object
}
