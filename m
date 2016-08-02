From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1011/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:08:05 +0800
Message-ID: <20160802120805.17489-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com
List-Id: linux-omap@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 6429f33..e03c066 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1307,8 +1307,8 @@ static ssize_t omapfb_show_caps_text(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(caps_num, 0444, omapfb_show_caps_num, NULL);
-static DEVICE_ATTR(caps_text, 0444, omapfb_show_caps_text, NULL);
+static DEVICE_ATTR(caps_num, S_IRUSR | S_IRGRP | S_IROTH, omapfb_show_caps_num, NULL);
+static DEVICE_ATTR(caps_text, S_IRUSR | S_IRGRP | S_IROTH, omapfb_show_caps_text, NULL);
 
 /* panel sysfs entries */
 static ssize_t omapfb_show_panel_name(struct device *dev,
@@ -1370,9 +1370,9 @@ static ssize_t omapfb_show_bklight_max(struct device *dev,
 
 static struct device_attribute dev_attr_panel_name =
 	__ATTR(name, 0444, omapfb_show_panel_name, NULL);
-static DEVICE_ATTR(backlight_level, 0664,
+static DEVICE_ATTR(backlight_level, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 		   omapfb_show_bklight_level, omapfb_store_bklight_level);
-static DEVICE_ATTR(backlight_max, 0444, omapfb_show_bklight_max, NULL);
+static DEVICE_ATTR(backlight_max, S_IRUSR | S_IRGRP | S_IROTH, omapfb_show_bklight_max, NULL);
 
 static struct attribute *panel_attrs[] = {
 	&dev_attr_panel_name.attr,
@@ -1928,13 +1928,13 @@ static void __exit omapfb_cleanup(void)
 	platform_driver_unregister(&omapfb_driver);
 }
 
-module_param_named(accel, def_accel, uint, 0664);
-module_param_array_named(vram, def_vram, ulong, &def_vram_cnt, 0664);
-module_param_named(vxres, def_vxres, long, 0664);
-module_param_named(vyres, def_vyres, long, 0664);
-module_param_named(rotate, def_rotate, uint, 0664);
-module_param_named(mirror, def_mirror, uint, 0664);
-module_param_named(manual_update, manual_update, bool, 0664);
+module_param_named(accel, def_accel, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_array_named(vram, def_vram, ulong, &def_vram_cnt, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_named(vxres, def_vxres, long, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_named(vyres, def_vyres, long, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_named(rotate, def_rotate, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_named(mirror, def_mirror, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+module_param_named(manual_update, manual_update, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
 
 module_init(omapfb_init);
 module_exit(omapfb_cleanup);
-- 
2.9.2
