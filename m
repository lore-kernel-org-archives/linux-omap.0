From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1013/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:08:18 +0800
Message-ID: <20160802120818.17626-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, oleg@redhat.com, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com
List-Id: linux-omap@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index d3af01c..f9ebef0 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -48,13 +48,13 @@ static bool def_mirror;
 static bool auto_update;
 static unsigned int auto_update_freq;
 module_param(auto_update, bool, 0);
-module_param(auto_update_freq, uint, 0644);
+module_param(auto_update_freq, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 #ifdef DEBUG
 bool omapfb_debug;
-module_param_named(debug, omapfb_debug, bool, 0644);
+module_param_named(debug, omapfb_debug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 static bool omapfb_test_pattern;
-module_param_named(test, omapfb_test_pattern, bool, 0644);
+module_param_named(test, omapfb_test_pattern, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 #endif
 
 static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi);
-- 
2.9.2
