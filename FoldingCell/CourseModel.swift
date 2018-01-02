//
//  CourseModel.swift
//  FoldingCell
//
//  Created by yang on 2018/1/2.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

struct CourseModel {
	var courseId : Int!
	var id : Int!
	var lectures : [Lecture]!
	var name : String!
	var weight : Int!
}


struct Lecture {
	var name: String!
	var time: Int!
}
