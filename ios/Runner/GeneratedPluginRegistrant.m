//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<syncfusion_flutter_pdfviewer/SyncfusionFlutterPdfViewerPlugin.h>)
#import <syncfusion_flutter_pdfviewer/SyncfusionFlutterPdfViewerPlugin.h>
#else
@import syncfusion_flutter_pdfviewer;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SyncfusionFlutterPdfViewerPlugin registerWithRegistrar:[registry registrarForPlugin:@"SyncfusionFlutterPdfViewerPlugin"]];
}

@end
