//
//  ViewController.swift
//  FoldingCell
//
//  Created by yang on 2017/12/26.
//  Copyright © 2017年 yang. All rights reserved.
//

import UIKit

class FoldViewController: UIViewController {

	var sectionHeader: FoldingSectionHeader!
	var select: [Bool] = []
	var sectionArr: [CourseModel] = []
	var secArray: [CourseModel] = []


	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()

	    let lecture = Lecture(name: "课程", time: 120)

		let model = CourseModel(courseId: 1, id: 2, lectures: [lecture,lecture,lecture,lecture], name: "我旁边", weight: 2)
		let model1 = CourseModel(courseId: 1, id: 2, lectures: [lecture,lecture,lecture,lecture], name: "你旁边", weight: 2)
		let model2 = CourseModel(courseId: 1, id: 2, lectures: [lecture,lecture,lecture,lecture], name: "他旁边", weight: 2)
		let model3 = CourseModel(courseId: 1, id: 2, lectures: [lecture,lecture,lecture,lecture], name: "她旁边", weight: 2)
		sectionArr = [model,model1,model2,model3]
		secArray = sectionArr
		select = Array(repeating: true, count: secArray.count)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension FoldViewController: UITableViewDelegate {

}

extension FoldViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionArr.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sectionArr[section].lectures.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "foldCell", for: indexPath)
		cell.textLabel?.text = "\(indexPath.section * 10 + indexPath.row)"
		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = FoldingSectionHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
		view.backgroundColor = UIColor.groupTableViewBackground
		view.isShow = select[section]
		view.delegate = self
		view.section = section
		view.title = sectionArr[section].name
		return view
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
}

extension FoldViewController: FoldingSectionHeaderDelegate {
	func clickSectionHeader(section: Int, isShow: Bool) {
		select[section] = isShow
		if !isShow {
			sectionArr[section].lectures = []
		}else {
			sectionArr[section].lectures = secArray[section].lectures
		}
		tableView.reloadSections(IndexSet(integer: section), with: .automatic)
	}
}






