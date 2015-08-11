//
//  CoverFlowCollectionViewFlowLayoutDelegate.swift
//  CoverFlowCollectionView
//
//  Created by Rusty Zarse on 8/11/15.
//  Copyright (c) 2015 com.levous. All rights reserved.
//

import UIKit

public class CoverFlowCollectionViewFlowLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
	public func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAtIndex section: Int) -> UIEdgeInsets {
			let elementsCount: CGFloat = 10.0
			let edgeInsets = collectionView.bounds.size.width / 2
			return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
	}
}
