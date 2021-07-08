//
//  UIIntroductionView.swift
//  Core Graphics
//
//  Created by Harbros47 on 14.01.21.
//

import UIKit

private enum Constants {
    static let radiusCircle: CGFloat = 90
    static let sizeStar: CGFloat = 200
    static let sizeSmallStar: CGFloat = 50
    static let numberOfStarEnds: CGFloat = 5
    static let numberOfTriangleEnds: CGFloat = 3
    static let sizeTriangle: CGFloat = 50
    static let angleSmallStar: CGFloat = 10
    static let starircleRadius: CGFloat = 30
    static let angleSmallTriangle: CGFloat = 60
    static let angleMiddleTriangle: CGFloat = 80
    static let angleBigTriangle: CGFloat = 100
    static let trunkWidth: CGFloat = 40
    static let trunkHeight: CGFloat = 100
}

class UIIntroductionView: UIView {
    
    override func draw(_ rect: CGRect) {
        let point = CGPoint(x: rect.width / 2, y: rect.height / 4)
        creatingStar(
            rect: CGRect(
                x: point.x,
                y: point.y,
                width: Constants.sizeStar,
                height: Constants.sizeStar
            ),
            angle: Constants.radiusCircle,
            color: .blue
        )
        
        circles(
            point: point,
            startAngle: 0.6,
            endAngle: 0.01
        )
        
        circles(
            point: point,
            startAngle: 1.87,
            endAngle: 1.29
        )
        
        circles(
            point: point,
            startAngle: 3.13,
            endAngle: 2.54
        )
        
        circles(
            point: point,
            startAngle: 4.38,
            endAngle: 3.78
        )
        
        circles(
            point: point,
            startAngle: 5.65,
            endAngle: 5.06
        )
        
        creatingShapes(
            rect: CGRect(
                x: point.x,
                y: rect.height / 2,
                width: Constants.sizeStar,
                height: Constants.sizeStar
            ),
            angle: Constants.angleSmallTriangle
        )
        
        creatingShapes(
            rect: CGRect(
                x: point.x,
                y: rect.height / 1.8,
                width: Constants.sizeStar,
                height: Constants.sizeStar
            ),
            angle: Constants.angleMiddleTriangle
        )
        
        let pathRect = CGRect(
            x: point.x - 20,
            y: rect.height / 1.6,
            width: Constants.trunkWidth,
            height: Constants.trunkHeight
        )
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 12)
        UIColor.brown.setFill()
        path.fill()
        
        creatingShapes(
            rect: CGRect(
                x: point.x,
                y: rect.height / 1.6,
                width: Constants.sizeStar,
                height: Constants.sizeStar
            ),
            angle: Constants.angleBigTriangle
        )
        randomSmallStar(rect: rect)
    }  
    
    private func circles(
        point: CGPoint,
        radius: CGFloat = Constants.radiusCircle,
        startAngle: CGFloat,
        endAngle: CGFloat,
        clockwise: Bool = false,
        color: UIColor = .green
    ) {
        let circle = UIBezierPath(
            arcCenter: point,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        color.setStroke()
        circle.stroke()
    }
    
    private func generalMethodForShapes(
        ctx: UIBezierPath,
        x: CGFloat,
        y: CGFloat,
        angle: CGFloat,
        endsOfFigure: CGFloat,
        createCircle: ((CGFloat, CGFloat) -> Void)?
    ) {
        var rot = CGFloat.pi / 2 * 3
        for _ in 0...Int(Constants.numberOfStarEnds) {
            let pointX = x + cos(rot) * angle
            let pointY = y + sin(rot) * angle
            ctx.addLine(to: CGPoint(x: pointX, y: pointY))
            createCircle?(pointX, pointY)
            rot += endsOfFigure
            let pointX1 = x + cos(rot) * (angle / 2)
            let pointY1 = y + sin(rot) * (angle / 2)
            ctx.addLine(to: CGPoint(x: pointX1, y: pointY1))
            rot += endsOfFigure
        }
    }
    
    private func creatingStar(
        rect: CGRect,
        angle: CGFloat,
        color: UIColor,
        numberOfСorners: CGFloat = Constants.numberOfStarEnds
    ) {
        let x = rect.origin.x
        let y = rect.origin.y
        let endsOfStar = CGFloat.pi / numberOfСorners
        let ctx = UIBezierPath()
        ctx.move(to: CGPoint(x: x, y: y - angle))
        generalMethodForShapes(
            ctx: ctx,
            x: x,
            y: y,
            angle: angle,
            endsOfFigure: endsOfStar,
            createCircle: { (pointX, pointY) in
                if angle == Constants.radiusCircle {
                    let circle = UIBezierPath(
                        arcCenter: CGPoint(x: pointX, y: pointY),
                        radius: Constants.starircleRadius,
                        startAngle: 7,
                        endAngle: 0,
                        clockwise: false
                    )
                    UIColor.red.setStroke()
                    circle.stroke()
                }
            }
        )
        color.setFill()
        ctx.fill()
    }
    
    private func creatingShapes(
        rect: CGRect,
        angle: CGFloat,
        color: UIColor = .green,
        numberOfСorners: CGFloat = Constants.numberOfTriangleEnds
    ) {
        let x = rect.origin.x
        let y = rect.origin.y
        let endsOfFigure = CGFloat.pi / numberOfСorners
        let ctx = UIBezierPath()
        ctx.move(to: CGPoint(x: x, y: y - angle))
        generalMethodForShapes(
            ctx: ctx,
            x: x,
            y: y,
            angle: angle,
            endsOfFigure: endsOfFigure,
            createCircle: nil
        )
        color.setFill()
        ctx.fill()
    }
    
    private func randomSmallStar(rect: CGRect) {
        for _ in 0..<5 {
            let randomX = CGFloat.random(in: 20.0...rect.width)
            let randomY = CGFloat.random(in: 20.0...rect.height)
            creatingStar(
                rect: CGRect(
                    x: randomX,
                    y: randomY,
                    width: Constants.sizeStar,
                    height: Constants.sizeStar
                ),
                angle: Constants.angleSmallStar,
                color: .red
            )
        }
    }
}
