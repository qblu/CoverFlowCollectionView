//
//  CoverFlowLayout.swift
//  CoverFlowCollectionView
//
//  Created by Rusty Zarse on 8/11/15.
//  Copyright (c) 2015 com.levous. All rights reserved.
//

import Foundation

public class CoverFlowLayout : UICollectionViewFlowLayout {
	let zoomFactor: CGFloat = 0.75
	let focusedItemContainerWidthRatio: CGFloat = 0.75
	
	override public func prepareLayout() {
		
		self.minimumInteritemSpacing = 20.0
		self.minimumLineSpacing = 20.0
		
		self.scrollDirection = UICollectionViewScrollDirection.Horizontal
		let size = self.collectionView!.frame.size
		let itemWidth = size.width * focusedItemContainerWidthRatio
		self.itemSize = CGSizeMake(itemWidth, itemWidth * 0.75)
		self.sectionInset = UIEdgeInsetsMake(size.height * 0.15, size.height * 0.1, size.height * 0.15, size.height * 0.1)
	}
	
	override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
		return true
	}
	
	override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		
		var elementsAttributesInRect = super.layoutAttributesForElementsInRect(rect)!
		var visibleRect:CGRect = CGRectZero
		visibleRect.origin = self.collectionView!.contentOffset
		visibleRect.size = self.collectionView!.bounds.size
	
		let collectionViewHalfFrame = self.collectionView!.frame.size.width / 2.0
	
		for index in 0..<elementsAttributesInRect.count {
			let layoutAttributes = elementsAttributesInRect[index] 
			
			if (CGRectIntersectsRect(layoutAttributes.frame, rect)) {
				let distanceFromCenter = CGRectGetMidX(visibleRect) - layoutAttributes.center.x
				let normalizedDistance = distanceFromCenter / collectionViewHalfFrame
	
				if (abs(distanceFromCenter) < collectionViewHalfFrame) {
					let zoom = 1.0 + zoomFactor * (1.0 - abs(normalizedDistance))
					var rotationTransform = CATransform3DIdentity
					rotationTransform = CATransform3DMakeRotation(CGFloat(normalizedDistance * CGFloat(M_PI_2) * 0.8), 0.0, 1.0, 0.0)
					let zoomTransform = CATransform3DMakeScale(zoom, zoom, 1.0)
					layoutAttributes.transform3D = CATransform3DConcat(zoomTransform, rotationTransform)
					layoutAttributes.zIndex = Int(abs(normalizedDistance) * 10.0)
					var alpha = (1  - abs(normalizedDistance)) + 0.1
					if (alpha > 1.0) { alpha = 1.0 }
					layoutAttributes.alpha = alpha
				} else {
					layoutAttributes.alpha = 0.0
				}
			}
		}
	
		return elementsAttributesInRect
	}
	
	override public func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		var newOffset = proposedContentOffset
		if (newOffset.x > self.collectionView!.contentOffset.x) {
			newOffset.x = self.collectionView!.contentOffset.x + self.collectionView!.bounds.size.width / 2
		} else if (newOffset.x < self.collectionView!.contentOffset.x) {
			newOffset.x = self.collectionView!.contentOffset.x - self.collectionView!.bounds.size.width / 2
		}
		
		var offsetAdjustment: CGFloat = CGFloat(MAXFLOAT)
		let horizontalCenter = newOffset.x + self.collectionView!.bounds.size.width / 2
		let targetRect = CGRectMake(newOffset.x, 0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height)
		
		let attributes = super.layoutAttributesForElementsInRect(targetRect)!
		for a in attributes {
			let itemHorizontalCenter = a.center.x
			if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
				offsetAdjustment = itemHorizontalCenter - horizontalCenter
			}
		}
		
		return CGPointMake(newOffset.x + offsetAdjustment, newOffset.y);
	}
	
	

	

}