//
//  GenericCollectionViewController.swift
//  CoverFlowCollectionView
//
//  Created by Rusty Zarse on 8/11/15.
//  Copyright (c) 2015 com.levous. All rights reserved.
//

import UIKit
import CoverFlowCollectionView

class GenericCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	//MARK: <UICollectionViewDataSource>
	
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	
	override func  collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
		return cell
	}
	
	func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAtIndex section: Int) -> UIEdgeInsets {
			
			let elementsCount: CGFloat = 10.0
			let edgeInsets = self.view.bounds.size.width / 2
		return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
	}
	
		

}