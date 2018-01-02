//
//  EncryptUtils.swift
//  alot
//
//  Created by yang on 2017/10/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class EncryptUtils {
    
    public static func encrypt(data: String,key: String) -> String {
        let md5String = key.MD5
        //print(md5String!)
        var x = 0
        let keyLen = md5String?.count
        var ch = ""
        var strc = ""
        let keyArr = md5String!.map({
            String($0)
        })
     //print(keyArr)
        for _ in 0..<data.count {
            if(x == keyLen) {
                x = 0
            }
            ch += keyArr[x]
            x += 1
        }
     //print(ch)
        for i in 0..<data.count {
            
            let temp = data.map({
                String($0)
            })[i].ord() + ch.map({
                String($0)
            })[i].ord() % 256
            strc += String(Character(UnicodeScalar(temp)!))
            
        }
     //print(strc)
        let data = strc.data(using: String.Encoding.utf8)!
        let encryString = data.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithCarriageReturn)
     //print(ssss!)
        return encryString
        
    }

	public static func decrypt(data: String,key: String) -> String {

		let md5String = key.MD5
		let da = String.base64Decoding(encodedString: data)
		var x = 0
		let keyLen = md5String?.count
		let dataLen = da.count
		var ch = ""
		var strc = ""
		let keyArr = md5String!.map({
			String($0)
		})

		let dataArr = da.map { (d)  in
			return String(d)
		}

		for _ in 0..<dataLen {
			if x == keyLen {
				x = 0
			}
			ch += keyArr[x]
			x += 1
		}

		let chArr = ch.map { (c) in
			return String(c)
		}

		for i in 0..<dataLen {
			if dataArr[i].ord() < chArr[i].ord() {
				let ord1 = dataArr[i].ord() + 256
				let ord2 = chArr[i].ord()
				strc += String(Character(UnicodeScalar(ord1 - ord2)!))
			}else {
				let ord1 = dataArr[i].ord()
				let ord2 = chArr[i].ord()
				strc += String(Character(UnicodeScalar(ord1 - ord2)!))
			}
		}

		return strc
	}

}

extension String {
    var MD5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return hash as String
    }

    public func stringSubCharacter(index: Int = 1) -> String {
        
        let index = self.index(self.startIndex, offsetBy: index)
        let first = self[..<index]
        return String(first)
    }
    
    
    // 自定义的行间距下的高度
    func textHeightHavelineSpaceing
        (width: CGFloat,font: UIFont,lineSpaceing: CGFloat) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let paraphStyle = NSMutableParagraphStyle()
        paraphStyle.lineSpacing = lineSpaceing
        
        let rect = self.boundingRect(   with: size,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [NSAttributedStringKey.font: font,
                                                     NSAttributedStringKey.paragraphStyle: paraphStyle],
                                        context: nil)
        return rect.height
        
    }
    
    // 首字符转换为ascii 码
    func ord() -> Int {
        var numberFromC = 0
        for scalar in self.unicodeScalars
        {
            numberFromC = Int(scalar.value)
        }
        //print(numberFromC)
        return numberFromC
    }


	/**

	*   编码

	*/

	static func base64Encoding(plainString: String)->String {

		let plainData = plainString.data(using: String.Encoding.utf8)

		let base64String = plainData?.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithCarriageReturn)

		return base64String!

	}



	/**

	*   解码

	*/

	static func base64Decoding(encodedString: String)->String {

	//	let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))

		print(encodedString)
		let data = Data(base64Encoded: encodedString)
		print(data)
		let string = String(data: data!, encoding: String.Encoding.utf8)
		print(string)
		return string!

	}
   
}

func randomString() -> String {
    var randomStr = ""
    let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var c = charSet.map { String($0) }
    for _ in (1...130) {
        randomStr.append(c[Int(arc4random_uniform(UInt32(61)))])
    }
    //print(randomStr)
    let firstIndex = Int(arc4random() % 99)
    //print(firstIndex)
    let index = randomStr.index(randomStr.startIndex, offsetBy: firstIndex)
    let indexx = randomStr.index(index, offsetBy: 31)
    return String(randomStr[index...indexx])
}


