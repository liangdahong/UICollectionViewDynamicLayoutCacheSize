Pod::Spec.new do |s|
s.name         = 'UICollectionViewDynamicLayoutCacheSize'
s.version      = '3.1.6'
s.summary      = '🖖 Template auto layout cell for automatically UICollectionViewCell calculating and cache size framework, Only applicable to cells created by xib.'
s.homepage     = 'https://github.com/liangdahong/UICollectionViewDynamicLayoutCacheSize'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'ios@liangdahong.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/liangdahong/UICollectionViewDynamicLayoutCacheSize.git', :tag => s.version}
s.source_files = 'UICollectionViewDynamicLayoutCacheSize/**/*.{h,m}'
s.requires_arc = true
end

