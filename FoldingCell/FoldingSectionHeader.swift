//
//  FoldingSectionHeader.swift
//  FoldingCell
//
//  Created by yang on 2017/12/26.
//  Copyright © 2017年 yang. All rights reserved.
//

import UIKit

protocol FoldingSectionHeaderDelegate: class {
	func clickSectionHeader(section: Int,isShow: Bool)

}

class FoldingSectionHeader: UIView {

	weak var delegate: FoldingSectionHeaderDelegate!
	var titleBtn: UIButton!
	var arrowBtn: UIButton!
	var section: Int!
	var isShow = false {
		didSet {
			if isShow {
				arrowBtn.transform = CGAffineTransform(rotationAngle: .pi / 2)
			}else {
				arrowBtn.transform = CGAffineTransform(rotationAngle: 0)
			}
		}
	}

	var title: String! {
		didSet {
			titleBtn.setTitle(title, for: .normal)
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		arrowBtn = UIButton()
		//	arrowBtn.backgroundColor = UIColor.white
		let image = UIImage(named: "箭头")
		arrowBtn.setImage(image , for: .normal)
		arrowBtn.addTarget(self, action: #selector(clickSectionHeader), for: .touchUpInside)
		arrowBtn.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(arrowBtn)

		let centerY = NSLayoutConstraint(item: arrowBtn, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)

		let height = NSLayoutConstraint(item: arrowBtn, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 0)

		let trailing = NSLayoutConstraint(item: arrowBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)

		let leading = NSLayoutConstraint(item: arrowBtn, attribute: .width, relatedBy: .equal, toItem: arrowBtn, attribute: .height, multiplier: 1.0, constant: 0)

		NSLayoutConstraint.activate([leading,trailing,centerY,height])

		titleBtn = UIButton()
		titleBtn.translatesAutoresizingMaskIntoConstraints = false
		titleBtn.setTitleColor(UIColor.black, for: .normal)
		titleBtn.contentHorizontalAlignment = .left
		titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		self.addSubview(titleBtn)
		titleBtn.addTarget(self, action: #selector(clickSectionHeader), for: .touchUpInside)
		//titleBtn.backgroundColor = UIColor.white

		let leadingContrians = NSLayoutConstraint(item: titleBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 15)

		let topConstrains = NSLayoutConstraint(item: titleBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)

		let bottomConstrains = NSLayoutConstraint(item: titleBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)

		let trailingConstrains = NSLayoutConstraint(item: titleBtn, attribute: .trailing, relatedBy: .equal, toItem: arrowBtn, attribute: .leading, multiplier: 1, constant: 0)
		NSLayoutConstraint.activate([leadingContrians,trailingConstrains,topConstrains,bottomConstrains])

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func clickSectionHeader(_ sender: UIButton) {
		//print(section)

		if isShow {
			arrowBtn.transform = CGAffineTransform(rotationAngle: 0)
			isShow = false
		}else {
			arrowBtn.transform = CGAffineTransform(rotationAngle: .pi / 2)
			isShow = true
		}

		if self.delegate != nil {
			self.delegate.clickSectionHeader(section: self.section, isShow: isShow)
		}


	}


	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/

}

