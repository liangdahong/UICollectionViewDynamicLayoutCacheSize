#!/bin/sh
echo "准备 pod trunk push"
echo "请确保已打 Tag"
echo "start..."
pod trunk push UICollectionViewDynamicLayoutCacheSize.podspec --allow-warnings
echo "完成"

