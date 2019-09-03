
  Pod::Spec.new do |s|
    s.name = 'CapacitorBraintree'
    s.version = '1.0.1'
    s.summary = 'Capacitor plugin for Braintree Payments'
    s.license = 'MIT'
    s.homepage = 'https://github.com/petemacko/capacitor-braintree'
    s.author = 'Pete Macko'
    s.source = { :git => 'https://github.com/petemacko/capacitor-pm-braintree', :tag => s.version.to_s }
    s.source_files = 'ios/BraintreePlugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'BraintreeDropIn'
    s.dependency 'Braintree/Apple-Pay'
    s.dependency 'Braintree/Venmo'
    s.dependency 'Braintree/3D-Secure'
  end
  
