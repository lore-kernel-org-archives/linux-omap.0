From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 121/493] video: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:10 -0500
Message-ID: <1353349642-3677-121-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41683 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2KSSiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 13:38:10 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Jaya Kumar <jayalk@intworks.biz>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Jingoo Han <jg1.han@samsung.com>, Inki Dae <inki.dae@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Sascha Hauer <kernel@pengutronix.de>, Maik Broemme <mbroemme@plusserver.de>, Antonino Daplas <adaplas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Winischhofer <thomas@winischhofer.net>, Tony Prisk <linux@prisktech.co.nz>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth.com, linux-omap@vger.kernel.orglinux

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaya Kumar <jayalk@intworks.biz> 
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: Paul Mackerras <paulus@samba.org> 
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jingoo Han <jg1.han@samsung.com> 
Cc: Inki Dae <inki.dae@samsung.com> 
Cc: Donghwa Lee <dh09.lee@samsung.com> 
Cc: Kyungmin Park <kyungmin.park@samsung.com> 
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu> 
Cc: Sascha Hauer <kernel@pengutronix.de> 
Cc: Maik Broemme <mbroemme@plusserver.de> 
Cc: Antonino Daplas <adaplas@gmail.com> 
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: Thomas Winischhofer <thomas@winischhofer.net> 
Cc: Tony Prisk <linux@prisktech.co.nz> 
Cc: linux-fbdev@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-geode@lists.infradead.org 
Cc: linux-nvidia@lists.surfsouth.com 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 drivers/video/arcfb.c                                   | 2 +-
 drivers/video/arkfb.c                                   | 2 +-
 drivers/video/asiliantfb.c                              | 2 +-
 drivers/video/aty/aty128fb.c                            | 2 +-
 drivers/video/aty/atyfb_base.c                          | 2 +-
 drivers/video/aty/radeon_base.c                         | 2 +-
 drivers/video/au1200fb.c                                | 2 +-
 drivers/video/auo_k1900fb.c                             | 2 +-
 drivers/video/auo_k1901fb.c                             | 2 +-
 drivers/video/bf537-lq035.c                             | 4 ++--
 drivers/video/bf54x-lq043fb.c                           | 2 +-
 drivers/video/bfin-lq035q1-fb.c                         | 4 ++--
 drivers/video/bfin-t350mcqb-fb.c                        | 2 +-
 drivers/video/bfin_adv7393fb.c                          | 2 +-
 drivers/video/broadsheetfb.c                            | 2 +-
 drivers/video/bw2.c                                     | 2 +-
 drivers/video/carminefb.c                               | 2 +-
 drivers/video/cg14.c                                    | 2 +-
 drivers/video/cg3.c                                     | 2 +-
 drivers/video/cg6.c                                     | 2 +-
 drivers/video/chipsfb.c                                 | 2 +-
 drivers/video/cirrusfb.c                                | 4 ++--
 drivers/video/cobalt_lcdfb.c                            | 2 +-
 drivers/video/cyber2000fb.c                             | 2 +-
 drivers/video/da8xx-fb.c                                | 2 +-
 drivers/video/ep93xx-fb.c                               | 2 +-
 drivers/video/exynos/exynos_dp_core.c                   | 2 +-
 drivers/video/exynos/exynos_mipi_dsi.c                  | 2 +-
 drivers/video/ffb.c                                     | 2 +-
 drivers/video/gbefb.c                                   | 2 +-
 drivers/video/geode/gx1fb_core.c                        | 2 +-
 drivers/video/grvga.c                                   | 2 +-
 drivers/video/gxt4500.c                                 | 2 +-
 drivers/video/hecubafb.c                                | 2 +-
 drivers/video/hgafb.c                                   | 2 +-
 drivers/video/hitfb.c                                   | 2 +-
 drivers/video/i740fb.c                                  | 2 +-
 drivers/video/imsttfb.c                                 | 2 +-
 drivers/video/imxfb.c                                   | 2 +-
 drivers/video/intelfb/intelfbdrv.c                      | 2 +-
 drivers/video/jz4740_fb.c                               | 2 +-
 drivers/video/kyro/fbdev.c                              | 2 +-
 drivers/video/leo.c                                     | 2 +-
 drivers/video/mb862xx/mb862xxfbdrv.c                    | 4 ++--
 drivers/video/mbx/mbxfb.c                               | 2 +-
 drivers/video/metronomefb.c                             | 2 +-
 drivers/video/mxsfb.c                                   | 2 +-
 drivers/video/neofb.c                                   | 2 +-
 drivers/video/nvidia/nvidia.c                           | 2 +-
 drivers/video/omap/lcd_mipid.c                          | 2 +-
 drivers/video/omap2/displays/panel-acx565akm.c          | 2 +-
 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c | 2 +-
 drivers/video/omap2/displays/panel-n8x0.c               | 2 +-
 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c | 2 +-
 drivers/video/omap2/displays/panel-tpo-td043mtea1.c     | 2 +-
 drivers/video/p9100.c                                   | 2 +-
 drivers/video/platinumfb.c                              | 2 +-
 drivers/video/pm2fb.c                                   | 2 +-
 drivers/video/pm3fb.c                                   | 2 +-
 drivers/video/pvr2fb.c                                  | 2 +-
 drivers/video/pxa168fb.c                                | 2 +-
 drivers/video/pxa3xx-gcu.c                              | 2 +-
 drivers/video/pxafb.c                                   | 2 +-
 drivers/video/riva/fbdev.c                              | 2 +-
 drivers/video/s3c-fb.c                                  | 2 +-
 drivers/video/s3c2410fb.c                               | 4 ++--
 drivers/video/s3fb.c                                    | 2 +-
 drivers/video/savage/savagefb_driver.c                  | 2 +-
 drivers/video/sgivwfb.c                                 | 2 +-
 drivers/video/sh7760fb.c                                | 2 +-
 drivers/video/sh_mipi_dsi.c                             | 2 +-
 drivers/video/sis/sis_main.c                            | 2 +-
 drivers/video/skeletonfb.c                              | 2 +-
 drivers/video/sstfb.c                                   | 2 +-
 drivers/video/sunxvr1000.c                              | 2 +-
 drivers/video/sunxvr2500.c                              | 2 +-
 drivers/video/sunxvr500.c                               | 2 +-
 drivers/video/tcx.c                                     | 2 +-
 drivers/video/tdfxfb.c                                  | 2 +-
 drivers/video/tgafb.c                                   | 4 ++--
 drivers/video/tmiofb.c                                  | 2 +-
 drivers/video/tridentfb.c                               | 2 +-
 drivers/video/vermilion/vermilion.c                     | 2 +-
 drivers/video/vga16fb.c                                 | 2 +-
 drivers/video/via/via-core.c                            | 2 +-
 drivers/video/vt8500lcdfb.c                             | 2 +-
 drivers/video/vt8623fb.c                                | 2 +-
 drivers/video/w100fb.c                                  | 2 +-
 drivers/video/wm8505fb.c                                | 2 +-
 drivers/video/wmt_ge_rops.c                             | 2 +-
 drivers/video/xilinxfb.c                                | 2 +-
 91 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 4659d5d..00967d2 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -601,7 +601,7 @@ static int __devexit arcfb_remove(struct platform_device *dev)
 
 static struct platform_driver arcfb_driver = {
 	.probe	= arcfb_probe,
-	.remove = __devexit_p(arcfb_remove),
+	.remove = arcfb_remove,
 	.driver	= {
 		.name	= "arcfb",
 	},
diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 555dd4c..6bcb6c1 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1196,7 +1196,7 @@ static struct pci_driver arkfb_pci_driver = {
 	.name		= "arkfb",
 	.id_table	= ark_devices,
 	.probe		= ark_pci_probe,
-	.remove		= __devexit_p(ark_pci_remove),
+	.remove		= ark_pci_remove,
 	.suspend	= ark_pci_suspend,
 	.resume		= ark_pci_resume,
 };
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 8cdf88e..640cc69 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -604,7 +604,7 @@ static struct pci_driver asiliantfb_driver = {
 	.name =		"asiliantfb",
 	.id_table =	asiliantfb_pci_tbl,
 	.probe =	asiliantfb_pci_init,
-	.remove =	__devexit_p(asiliantfb_remove),
+	.remove =	asiliantfb_remove,
 };
 
 static int __init asiliantfb_init(void)
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 0fefa84..426e3f2 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -275,7 +275,7 @@ static struct pci_driver aty128fb_driver = {
 	.name		= "aty128fb",
 	.id_table	= aty128_pci_tbl,
 	.probe		= aty128_probe,
-	.remove		= __devexit_p(aty128_remove),
+	.remove		= aty128_remove,
 	.suspend	= aty128_pci_suspend,
 	.resume		= aty128_pci_resume,
 };
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 868932f..bab571b 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3834,7 +3834,7 @@ static struct pci_driver atyfb_driver = {
 	.name		= "atyfb",
 	.id_table	= atyfb_pci_tbl,
 	.probe		= atyfb_pci_probe,
-	.remove		= __devexit_p(atyfb_pci_remove),
+	.remove		= atyfb_pci_remove,
 #ifdef CONFIG_PM
 	.suspend	= atyfb_pci_suspend,
 	.resume		= atyfb_pci_resume,
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 9e279ee..dacaa4e 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2465,7 +2465,7 @@ static struct pci_driver radeonfb_driver = {
 	.name		= "radeonfb",
 	.id_table	= radeonfb_pci_table,
 	.probe		= radeonfb_pci_register,
-	.remove		= __devexit_p(radeonfb_pci_unregister),
+	.remove		= radeonfb_pci_unregister,
 #ifdef CONFIG_PM
 	.suspend       	= radeonfb_pci_suspend,
 	.resume		= radeonfb_pci_resume,
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 7ca79f0..4538b07 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1876,7 +1876,7 @@ static struct platform_driver au1200fb_driver = {
 		.pm	= AU1200FB_PMOPS,
 	},
 	.probe		= au1200fb_drv_probe,
-	.remove		= __devexit_p(au1200fb_drv_remove),
+	.remove		= au1200fb_drv_remove,
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
index c36cf96..1581dbf 100644
--- a/drivers/video/auo_k1900fb.c
+++ b/drivers/video/auo_k1900fb.c
@@ -184,7 +184,7 @@ static int __devexit auok1900fb_remove(struct platform_device *pdev)
 
 static struct platform_driver auok1900fb_driver = {
 	.probe	= auok1900fb_probe,
-	.remove = __devexit_p(auok1900fb_remove),
+	.remove = auok1900fb_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "auo_k1900fb",
diff --git a/drivers/video/auo_k1901fb.c b/drivers/video/auo_k1901fb.c
index 1c054c1..94a0e01 100644
--- a/drivers/video/auo_k1901fb.c
+++ b/drivers/video/auo_k1901fb.c
@@ -237,7 +237,7 @@ static int __devexit auok1901fb_remove(struct platform_device *pdev)
 
 static struct platform_driver auok1901fb_driver = {
 	.probe	= auok1901fb_probe,
-	.remove = __devexit_p(auok1901fb_remove),
+	.remove = auok1901fb_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "auo_k1901fb",
diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index 7347aa1..8081c7b 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -126,7 +126,7 @@ static struct i2c_driver ad5280_driver = {
 		.name = "bf537-lq035-ad5280",
 	},
 	.probe = ad5280_probe,
-	.remove = __devexit_p(ad5280_remove),
+	.remove = ad5280_remove,
 	.id_table = ad5280_id,
 };
 
@@ -889,7 +889,7 @@ static int bfin_lq035_resume(struct platform_device *pdev)
 
 static struct platform_driver bfin_lq035_driver = {
 	.probe = bfin_lq035_probe,
-	.remove = __devexit_p(bfin_lq035_remove),
+	.remove = bfin_lq035_remove,
 	.suspend = bfin_lq035_suspend,
 	.resume = bfin_lq035_resume,
 	.driver = {
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index ff5663f..aff8520 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -754,7 +754,7 @@ static int bfin_bf54x_resume(struct platform_device *pdev)
 
 static struct platform_driver bfin_bf54x_driver = {
 	.probe = bfin_bf54x_probe,
-	.remove = __devexit_p(bfin_bf54x_remove),
+	.remove = bfin_bf54x_remove,
 	.suspend = bfin_bf54x_suspend,
 	.resume = bfin_bf54x_resume,
 	.driver = {
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 6fbc75c..acd438c 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -706,7 +706,7 @@ static int __devinit bfin_lq035q1_probe(struct platform_device *pdev)
 
 	info->spidrv.driver.name = DRIVER_NAME"-spi";
 	info->spidrv.probe    = lq035q1_spidev_probe;
-	info->spidrv.remove   = __devexit_p(lq035q1_spidev_remove);
+	info->spidrv.remove   = lq035q1_spidev_remove;
 	info->spidrv.shutdown = lq035q1_spidev_shutdown;
 	info->spidrv.suspend  = lq035q1_spidev_suspend;
 	info->spidrv.resume   = lq035q1_spidev_resume;
@@ -845,7 +845,7 @@ static struct dev_pm_ops bfin_lq035q1_dev_pm_ops = {
 
 static struct platform_driver bfin_lq035q1_driver = {
 	.probe   = bfin_lq035q1_probe,
-	.remove  = __devexit_p(bfin_lq035q1_remove),
+	.remove  = bfin_lq035q1_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 #ifdef CONFIG_PM
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index ae0fb24..c753abd 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -658,7 +658,7 @@ static int bfin_t350mcqb_resume(struct platform_device *pdev)
 
 static struct platform_driver bfin_t350mcqb_driver = {
 	.probe = bfin_t350mcqb_probe,
-	.remove = __devexit_p(bfin_t350mcqb_remove),
+	.remove = bfin_t350mcqb_remove,
 	.suspend = bfin_t350mcqb_suspend,
 	.resume = bfin_t350mcqb_resume,
 	.driver = {
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index d0f121b..a32ef5a 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -794,7 +794,7 @@ static struct i2c_driver bfin_adv7393_fb_driver = {
 #endif
 	},
 	.probe = bfin_adv7393_fb_probe,
-	.remove = __devexit_p(bfin_adv7393_fb_remove),
+	.remove = bfin_adv7393_fb_remove,
 	.id_table = bfin_adv7393_id,
 };
 
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index c95b417..377dde3 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -1211,7 +1211,7 @@ static int __devexit broadsheetfb_remove(struct platform_device *dev)
 
 static struct platform_driver broadsheetfb_driver = {
 	.probe	= broadsheetfb_probe,
-	.remove = __devexit_p(broadsheetfb_remove),
+	.remove = broadsheetfb_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "broadsheetfb",
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 6bea9a9..bc88682 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -384,7 +384,7 @@ static struct platform_driver bw2_driver = {
 		.of_match_table = bw2_match,
 	},
 	.probe		= bw2_probe,
-	.remove		= __devexit_p(bw2_remove),
+	.remove		= bw2_remove,
 };
 
 static int __init bw2_init(void)
diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index 2c76fdf..27561cc 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -764,7 +764,7 @@ static struct pci_driver carmine_pci_driver = {
 	.name		= "carminefb",
 	.id_table	= carmine_devices,
 	.probe		= carminefb_probe,
-	.remove		= __devexit_p(carminefb_remove),
+	.remove		= carminefb_remove,
 };
 
 static int __init carminefb_init(void)
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index f188950..6889f0c 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -603,7 +603,7 @@ static struct platform_driver cg14_driver = {
 		.of_match_table = cg14_match,
 	},
 	.probe		= cg14_probe,
-	.remove		= __devexit_p(cg14_remove),
+	.remove		= cg14_remove,
 };
 
 static int __init cg14_init(void)
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index c5e7612..0bd94d4 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -469,7 +469,7 @@ static struct platform_driver cg3_driver = {
 		.of_match_table = cg3_match,
 	},
 	.probe		= cg3_probe,
-	.remove		= __devexit_p(cg3_remove),
+	.remove		= cg3_remove,
 };
 
 static int __init cg3_init(void)
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 179e96c..70c7013 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -862,7 +862,7 @@ static struct platform_driver cg6_driver = {
 		.of_match_table = cg6_match,
 	},
 	.probe		= cg6_probe,
-	.remove		= __devexit_p(cg6_remove),
+	.remove		= cg6_remove,
 };
 
 static int __init cg6_init(void)
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index cff742a..809857d 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -495,7 +495,7 @@ static struct pci_driver chipsfb_driver = {
 	.name =		"chipsfb",
 	.id_table =	chipsfb_pci_tbl,
 	.probe =	chipsfb_pci_init,
-	.remove =	__devexit_p(chipsfb_remove),
+	.remove =	chipsfb_remove,
 #ifdef CONFIG_PM
 	.suspend =	chipsfb_pci_suspend,
 	.resume =	chipsfb_pci_resume,
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index bc67d05..3ce6e55 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2226,7 +2226,7 @@ static struct pci_driver cirrusfb_pci_driver = {
 	.name		= "cirrusfb",
 	.id_table	= cirrusfb_pci_table,
 	.probe		= cirrusfb_pci_register,
-	.remove		= __devexit_p(cirrusfb_pci_unregister),
+	.remove		= cirrusfb_pci_unregister,
 #ifdef CONFIG_PM
 #if 0
 	.suspend	= cirrusfb_pci_suspend,
@@ -2364,7 +2364,7 @@ static struct zorro_driver cirrusfb_zorro_driver = {
 	.name		= "cirrusfb",
 	.id_table	= cirrusfb_zorro_table,
 	.probe		= cirrusfb_zorro_register,
-	.remove		= __devexit_p(cirrusfb_zorro_unregister),
+	.remove		= cirrusfb_zorro_unregister,
 };
 #endif /* CONFIG_ZORRO */
 
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index 01a4ee7..9f2dc21 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -389,7 +389,7 @@ static int __devexit cobalt_lcdfb_remove(struct platform_device *dev)
 
 static struct platform_driver cobalt_lcdfb_driver = {
 	.probe	= cobalt_lcdfb_probe,
-	.remove	= __devexit_p(cobalt_lcdfb_remove),
+	.remove	= cobalt_lcdfb_remove,
 	.driver	= {
 		.name	= "cobalt-lcd",
 		.owner	= THIS_MODULE,
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index e40125c..9b75b29 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1923,7 +1923,7 @@ MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
 static struct pci_driver cyberpro_driver = {
 	.name		= "CyberPro",
 	.probe		= cyberpro_pci_probe,
-	.remove		= __devexit_p(cyberpro_pci_remove),
+	.remove		= cyberpro_pci_remove,
 	.suspend	= cyberpro_pci_suspend,
 	.resume		= cyberpro_pci_resume,
 	.id_table	= cyberpro_pci_table
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 80665f6..b3aaf3b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1598,7 +1598,7 @@ static int fb_resume(struct platform_device *dev)
 
 static struct platform_driver da8xx_fb_driver = {
 	.probe = fb_probe,
-	.remove = __devexit_p(fb_remove),
+	.remove = fb_remove,
 	.suspend = fb_suspend,
 	.resume = fb_resume,
 	.driver = {
diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 755ef3e..2f08122 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -620,7 +620,7 @@ static int __devexit ep93xxfb_remove(struct platform_device *pdev)
 
 static struct platform_driver ep93xxfb_driver = {
 	.probe		= ep93xxfb_probe,
-	.remove		= __devexit_p(ep93xxfb_remove),
+	.remove		= ep93xxfb_remove,
 	.driver = {
 		.name	= "ep93xx-fb",
 		.owner	= THIS_MODULE,
diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index d55470e..07c0453 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -1015,7 +1015,7 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
 
 static struct platform_driver exynos_dp_driver = {
 	.probe		= exynos_dp_probe,
-	.remove		= __devexit_p(exynos_dp_remove),
+	.remove		= exynos_dp_remove,
 	.driver		= {
 		.name	= "exynos-dp",
 		.owner	= THIS_MODULE,
diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 07d70a3..1571db7 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -595,7 +595,7 @@ static const struct dev_pm_ops exynos_mipi_dsi_pm_ops = {
 
 static struct platform_driver exynos_mipi_dsi_driver = {
 	.probe = exynos_mipi_dsi_probe,
-	.remove = __devexit_p(exynos_mipi_dsi_remove),
+	.remove = exynos_mipi_dsi_remove,
 	.driver = {
 		   .name = "exynos-mipi-dsim",
 		   .owner = THIS_MODULE,
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 14102a3..d78dc9a 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1058,7 +1058,7 @@ static struct platform_driver ffb_driver = {
 		.of_match_table = ffb_match,
 	},
 	.probe		= ffb_probe,
-	.remove		= __devexit_p(ffb_remove),
+	.remove		= ffb_remove,
 };
 
 static int __init ffb_init(void)
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index 3dad319..f19571b 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1273,7 +1273,7 @@ static int __devexit gbefb_remove(struct platform_device* p_dev)
 
 static struct platform_driver gbefb_driver = {
 	.probe = gbefb_probe,
-	.remove = __devexit_p(gbefb_remove),
+	.remove = gbefb_remove,
 	.driver	= {
 		.name = "gbefb",
 	},
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 265c5ed..094c352 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -441,7 +441,7 @@ static struct pci_driver gx1fb_driver = {
 	.name		= "gx1fb",
 	.id_table	= gx1fb_id_table,
 	.probe		= gx1fb_probe,
-	.remove		= __devexit_p(gx1fb_remove),
+	.remove		= gx1fb_remove,
 };
 
 static int __init gx1fb_init(void)
diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 5245f9a..3ddf206 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -554,7 +554,7 @@ static struct platform_driver grvga_driver = {
 		.of_match_table = svgactrl_of_match,
 	},
 	.probe		= grvga_probe,
-	.remove		= __devexit_p(grvga_remove),
+	.remove		= grvga_remove,
 };
 
 
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 4bdea6e..d4f103e 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -758,7 +758,7 @@ static struct pci_driver gxt4500_driver = {
 	.name = "gxt4500",
 	.id_table = gxt4500_pci_tbl,
 	.probe = gxt4500_probe,
-	.remove = __devexit_p(gxt4500_remove),
+	.remove = gxt4500_remove,
 };
 
 static int __devinit gxt4500_init(void)
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 614251a..b28a520 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -299,7 +299,7 @@ static int __devexit hecubafb_remove(struct platform_device *dev)
 
 static struct platform_driver hecubafb_driver = {
 	.probe	= hecubafb_probe,
-	.remove = __devexit_p(hecubafb_remove),
+	.remove = hecubafb_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "hecubafb",
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index c645f92..f8a7036 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -617,7 +617,7 @@ static int __devexit hgafb_remove(struct platform_device *pdev)
 
 static struct platform_driver hgafb_driver = {
 	.probe = hgafb_probe,
-	.remove = __devexit_p(hgafb_remove),
+	.remove = hgafb_remove,
 	.driver = {
 		.name = "hgafb",
 	},
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
index cfb8d64..4ceb978 100644
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -462,7 +462,7 @@ static const struct dev_pm_ops hitfb_dev_pm_ops = {
 
 static struct platform_driver hitfb_driver = {
 	.probe		= hitfb_probe,
-	.remove		= __devexit_p(hitfb_remove),
+	.remove		= hitfb_remove,
 	.driver		= {
 		.name	= "hitfb",
 		.owner	= THIS_MODULE,
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index ff3f880..1d3c8ee 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -1275,7 +1275,7 @@ static struct pci_driver i740fb_driver = {
 	.name		= "i740fb",
 	.id_table	= i740fb_id_table,
 	.probe		= i740fb_probe,
-	.remove		= __devexit_p(i740fb_remove),
+	.remove		= i740fb_remove,
 	.suspend	= i740fb_suspend,
 	.resume		= i740fb_resume,
 };
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 8149356..1bb3934 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1333,7 +1333,7 @@ static struct pci_driver imsttfb_pci_driver = {
 	.name =		"imsttfb",
 	.id_table =	imsttfb_pci_tbl,
 	.probe =	imsttfb_probe,
-	.remove =	__devexit_p(imsttfb_remove),
+	.remove =	imsttfb_remove,
 };
 
 static struct fb_ops imsttfb_ops = {
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index e501dbc..e1fbfb0 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -959,7 +959,7 @@ void  imxfb_shutdown(struct platform_device * dev)
 static struct platform_driver imxfb_driver = {
 	.suspend	= imxfb_suspend,
 	.resume		= imxfb_resume,
-	.remove		= __devexit_p(imxfb_remove),
+	.remove		= imxfb_remove,
 	.shutdown	= imxfb_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index bdcbfba..971b5d0 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -219,7 +219,7 @@ static struct pci_driver intelfb_driver = {
 	.name =		"intelfb",
 	.id_table =	intelfb_pci_table,
 	.probe =	intelfb_pci_register,
-	.remove =	__devexit_p(intelfb_pci_unregister)
+	.remove =	intelfb_pci_unregister
 };
 
 /* Module description/parameters */
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 4d25711..cb867b6 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -794,7 +794,7 @@ static const struct dev_pm_ops jzfb_pm_ops = {
 
 static struct platform_driver jzfb_driver = {
 	.probe = jzfb_probe,
-	.remove = __devexit_p(jzfb_remove),
+	.remove = jzfb_remove,
 	.driver = {
 		.name = "jz4740-fb",
 		.pm = JZFB_PM_OPS,
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index acb9370..2293f6a 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -653,7 +653,7 @@ static struct pci_driver kyrofb_pci_driver = {
 	.name		= "kyrofb",
 	.id_table	= kyrofb_pci_tbl,
 	.probe		= kyrofb_probe,
-	.remove		= __devexit_p(kyrofb_remove),
+	.remove		= kyrofb_remove,
 };
 
 static struct fb_ops kyrofb_ops = {
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 9e946e2..52a8678 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -668,7 +668,7 @@ static struct platform_driver leo_driver = {
 		.of_match_table = leo_match,
 	},
 	.probe		= leo_probe,
-	.remove		= __devexit_p(leo_remove),
+	.remove		= leo_remove,
 };
 
 static int __init leo_init(void)
diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index d68e332..3025cbb 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -841,7 +841,7 @@ static struct platform_driver of_platform_mb862xxfb_driver = {
 		.of_match_table = of_platform_mb862xx_tbl,
 	},
 	.probe		= of_platform_mb862xx_probe,
-	.remove		= __devexit_p(of_platform_mb862xx_remove),
+	.remove		= of_platform_mb862xx_remove,
 };
 #endif
 
@@ -1174,7 +1174,7 @@ static struct pci_driver mb862xxfb_pci_driver = {
 	.name		= DRV_NAME,
 	.id_table	= mb862xx_pci_tbl,
 	.probe		= mb862xx_pci_probe,
-	.remove		= __devexit_p(mb862xx_pci_remove),
+	.remove		= mb862xx_pci_remove,
 };
 #endif
 
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 6563e50..a8ba922 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -1038,7 +1038,7 @@ static int __devexit mbxfb_remove(struct platform_device *dev)
 
 static struct platform_driver mbxfb_driver = {
 	.probe = mbxfb_probe,
-	.remove = __devexit_p(mbxfb_remove),
+	.remove = mbxfb_remove,
 	.suspend = mbxfb_suspend,
 	.resume = mbxfb_resume,
 	.driver = {
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 97d45e5..c0c358c 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -763,7 +763,7 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
 
 static struct platform_driver metronomefb_driver = {
 	.probe	= metronomefb_probe,
-	.remove = __devexit_p(metronomefb_remove),
+	.remove = metronomefb_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "metronomefb",
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 49619b4..ddac96d 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -949,7 +949,7 @@ static void mxsfb_shutdown(struct platform_device *pdev)
 
 static struct platform_driver mxsfb_driver = {
 	.probe = mxsfb_probe,
-	.remove = __devexit_p(mxsfb_remove),
+	.remove = mxsfb_remove,
 	.shutdown = mxsfb_shutdown,
 	.id_table = mxsfb_devtype,
 	.driver = {
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index afc9521..15c3bef 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -2194,7 +2194,7 @@ static struct pci_driver neofb_driver = {
 	.name =		"neofb",
 	.id_table =	neofb_devices,
 	.probe =	neofb_probe,
-	.remove =	__devexit_p(neofb_remove)
+	.remove =	neofb_remove
 };
 
 /* ************************* init in-kernel code ************************** */
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index fe13ac5..0bbed28 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1529,7 +1529,7 @@ static struct pci_driver nvidiafb_driver = {
 	.probe    = nvidiafb_probe,
 	.suspend  = nvidiafb_suspend,
 	.resume   = nvidiafb_resume,
-	.remove   = __devexit_p(nvidiafb_remove),
+	.remove   = nvidiafb_remove,
 };
 
 /* ------------------------------------------------------------------------- *
diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index b739600..803fee6 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -606,7 +606,7 @@ static struct spi_driver mipid_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= mipid_spi_probe,
-	.remove	= __devexit_p(mipid_spi_remove),
+	.remove	= mipid_spi_remove,
 };
 
 module_spi_driver(mipid_spi_driver);
diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index c835aa7..4a0e1c8 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -800,7 +800,7 @@ static struct spi_driver acx565akm_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= acx565akm_spi_probe,
-	.remove	= __devexit_p(acx565akm_spi_remove),
+	.remove	= acx565akm_spi_remove,
 };
 
 module_spi_driver(acx565akm_spi_driver);
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 90c1cab..bae244f 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -268,7 +268,7 @@ static struct spi_driver lb035q02_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= lb035q02_panel_spi_probe,
-	.remove		= __devexit_p(lb035q02_panel_spi_remove),
+	.remove		= lb035q02_panel_spi_remove,
 };
 
 module_spi_driver(lb035q02_spi_driver);
diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 3fc5ad0..7d836d1 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -723,7 +723,7 @@ static struct spi_driver mipid_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= mipid_spi_probe,
-	.remove	= __devexit_p(mipid_spi_remove),
+	.remove	= mipid_spi_remove,
 };
 
 static int __init n8x0_panel_drv_init(void)
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 908fd26..5664209 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -347,7 +347,7 @@ static int nec_8048_spi_resume(struct spi_device *spi)
 
 static struct spi_driver nec_8048_spi_driver = {
 	.probe		= nec_8048_spi_probe,
-	.remove		= __devexit_p(nec_8048_spi_remove),
+	.remove		= nec_8048_spi_remove,
 	.suspend	= nec_8048_spi_suspend,
 	.resume		= nec_8048_spi_resume,
 	.driver		= {
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index b5e6dbc..d655389 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -600,7 +600,7 @@ static struct spi_driver tpo_td043_spi_driver = {
 		.pm	= &tpo_td043_spi_pm,
 	},
 	.probe	= tpo_td043_spi_probe,
-	.remove	= __devexit_p(tpo_td043_spi_remove),
+	.remove	= tpo_td043_spi_remove,
 };
 
 module_spi_driver(tpo_td043_spi_driver);
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index d57cc58..f402a69 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -359,7 +359,7 @@ static struct platform_driver p9100_driver = {
 		.of_match_table = p9100_match,
 	},
 	.probe		= p9100_probe,
-	.remove		= __devexit_p(p9100_remove),
+	.remove		= p9100_remove,
 };
 
 static int __init p9100_init(void)
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index ae3caa6..6694923 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -683,7 +683,7 @@ static struct platform_driver platinum_driver =
 		.of_match_table = platinumfb_match,
 	},
 	.probe		= platinumfb_probe,
-	.remove		= __devexit_p(platinumfb_remove),
+	.remove		= platinumfb_remove,
 };
 
 static int __init platinumfb_init(void)
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index df31a24..c4f639a 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1765,7 +1765,7 @@ static struct pci_driver pm2fb_driver = {
 	.name		= "pm2fb",
 	.id_table	= pm2fb_id_table,
 	.probe		= pm2fb_probe,
-	.remove		= __devexit_p(pm2fb_remove),
+	.remove		= pm2fb_remove,
 };
 
 MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 055e527..e9d8e23 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1507,7 +1507,7 @@ static struct pci_driver pm3fb_driver = {
 	.name =		"pm3fb",
 	.id_table =	pm3fb_id_table,
 	.probe =	pm3fb_probe,
-	.remove =	__devexit_p(pm3fb_remove),
+	.remove =	pm3fb_remove,
 };
 
 MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index bcd44c3..69fc2c3 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -979,7 +979,7 @@ static struct pci_driver pvr2fb_pci_driver = {
 	.name		= "pvr2fb",
 	.id_table	= pvr2fb_pci_tbl,
 	.probe		= pvr2fb_pci_probe,
-	.remove		= __devexit_p(pvr2fb_pci_remove),
+	.remove		= pvr2fb_pci_remove,
 };
 
 static int __init pvr2fb_pci_init(void)
diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index f146089..a8fd898 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -826,7 +826,7 @@ static struct platform_driver pxa168fb_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa168fb_probe,
-	.remove		= __devexit_p(pxa168fb_remove),
+	.remove		= pxa168fb_remove,
 };
 
 module_platform_driver(pxa168fb_driver);
diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 0b4ae0c..4493a47 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -737,7 +737,7 @@ pxa3xx_gcu_remove(struct platform_device *dev)
 
 static struct platform_driver pxa3xx_gcu_driver = {
 	.probe	  = pxa3xx_gcu_probe,
-	.remove	 = __devexit_p(pxa3xx_gcu_remove),
+	.remove	 = pxa3xx_gcu_remove,
 	.driver	 = {
 		.owner  = THIS_MODULE,
 		.name   = DRV_NAME,
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 4fa2ad4..ffa62e2 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -2304,7 +2304,7 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 
 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
-	.remove 	= __devexit_p(pxafb_remove),
+	.remove		= pxafb_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-fb",
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 90df1a6..693ed5e 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -2186,7 +2186,7 @@ static struct pci_driver rivafb_driver = {
 	.name		= "rivafb",
 	.id_table	= rivafb_pci_tbl,
 	.probe		= rivafb_probe,
-	.remove		= __devexit_p(rivafb_remove),
+	.remove		= rivafb_remove,
 };
 
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2ed7b63..71981a5 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -2037,7 +2037,7 @@ static const struct dev_pm_ops s3cfb_pm_ops = {
 
 static struct platform_driver s3c_fb_driver = {
 	.probe		= s3c_fb_probe,
-	.remove		= __devexit_p(s3c_fb_remove),
+	.remove		= s3c_fb_remove,
 	.id_table	= s3c_fb_driver_ids,
 	.driver		= {
 		.name	= "s3c-fb",
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 1083bb9..fbf3cea 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -1101,7 +1101,7 @@ static int s3c2410fb_resume(struct platform_device *dev)
 
 static struct platform_driver s3c2410fb_driver = {
 	.probe		= s3c2410fb_probe,
-	.remove		= __devexit_p(s3c2410fb_remove),
+	.remove		= s3c2410fb_remove,
 	.suspend	= s3c2410fb_suspend,
 	.resume		= s3c2410fb_resume,
 	.driver		= {
@@ -1112,7 +1112,7 @@ static struct platform_driver s3c2410fb_driver = {
 
 static struct platform_driver s3c2412fb_driver = {
 	.probe		= s3c2412fb_probe,
-	.remove		= __devexit_p(s3c2410fb_remove),
+	.remove		= s3c2410fb_remove,
 	.suspend	= s3c2410fb_suspend,
 	.resume		= s3c2410fb_resume,
 	.driver		= {
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 1d00736..1b4f146 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1537,7 +1537,7 @@ static struct pci_driver s3fb_pci_driver = {
 	.name		= "s3fb",
 	.id_table	= s3_devices,
 	.probe		= s3_pci_probe,
-	.remove		= __devexit_p(s3_pci_remove),
+	.remove		= s3_pci_remove,
 	.suspend	= s3_pci_suspend,
 	.resume		= s3_pci_resume,
 };
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index f4f53b0..a1cc484 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2530,7 +2530,7 @@ static struct pci_driver savagefb_driver = {
 	.probe =    savagefb_probe,
 	.suspend =  savagefb_suspend,
 	.resume =   savagefb_resume,
-	.remove =   __devexit_p(savagefb_remove)
+	.remove =   savagefb_remove
 };
 
 /* **************************** exit-time only **************************** */
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index 53455f2..b5c30b9 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -845,7 +845,7 @@ static int __devexit sgivwfb_remove(struct platform_device *dev)
 
 static struct platform_driver sgivwfb_driver = {
 	.probe	= sgivwfb_probe,
-	.remove	= __devexit_p(sgivwfb_remove),
+	.remove	= sgivwfb_remove,
 	.driver	= {
 		.name	= "sgivwfb",
 	},
diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 83b16e2..ff93339 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -582,7 +582,7 @@ static struct platform_driver sh7760_lcdc_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = sh7760fb_probe,
-	.remove = __devexit_p(sh7760fb_remove),
+	.remove = sh7760fb_remove,
 };
 
 module_platform_driver(sh7760_lcdc_driver);
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 3951fda..ad47e48 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -591,7 +591,7 @@ static int __devexit sh_mipi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver sh_mipi_driver = {
-	.remove		= __devexit_p(sh_mipi_remove),
+	.remove		= sh_mipi_remove,
 	.shutdown	= sh_mipi_shutdown,
 	.driver = {
 		.name	= "sh-mipi-dsi",
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index a7a48db..5193138 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -6591,7 +6591,7 @@ static struct pci_driver sisfb_driver = {
 	.name		= "sisfb",
 	.id_table 	= sisfb_pci_table,
 	.probe		= sisfb_probe,
-	.remove 	= __devexit_p(sisfb_remove)
+	.remove		= sisfb_remove
 };
 
 static int __init sisfb_init(void)
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 5b6abc6..ce61d9d 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -899,7 +899,7 @@ static struct pci_driver xxxfb_driver = {
 	.name =		"xxxfb",
 	.id_table =	xxxfb_id_table,
 	.probe =	xxxfb_probe,
-	.remove =	__devexit_p(xxxfb_remove),
+	.remove =	xxxfb_remove,
 	.suspend =      xxxfb_suspend, /* optional but recommended */
 	.resume =       xxxfb_resume,  /* optional but recommended */
 };
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 111fb32..871e074 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1490,7 +1490,7 @@ static struct pci_driver sstfb_driver = {
 	.name		= "sstfb",
 	.id_table	= sstfb_id_tbl,
 	.probe		= sstfb_probe,
-	.remove		= __devexit_p(sstfb_remove),
+	.remove		= sstfb_remove,
 };
 
 
diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
index 729a507..cc9bf5f 100644
--- a/drivers/video/sunxvr1000.c
+++ b/drivers/video/sunxvr1000.c
@@ -201,7 +201,7 @@ MODULE_DEVICE_TABLE(of, ffb_match);
 
 static struct platform_driver gfb_driver = {
 	.probe		= gfb_probe,
-	.remove		= __devexit_p(gfb_remove),
+	.remove		= gfb_remove,
 	.driver = {
 		.name		= "gfb",
 		.owner		= THIS_MODULE,
diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index 7fbcba8..49bd77a 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -251,7 +251,7 @@ static struct pci_driver s3d_driver = {
 	.name		= "s3d",
 	.id_table	= s3d_pci_table,
 	.probe		= s3d_pci_register,
-	.remove		= __devexit_p(s3d_pci_unregister),
+	.remove		= s3d_pci_unregister,
 };
 
 static int __init s3d_init(void)
diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index 6c71b1b..e94c799 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -437,7 +437,7 @@ static struct pci_driver e3d_driver = {
 	.name		= "e3d",
 	.id_table	= e3d_pci_table,
 	.probe		= e3d_pci_register,
-	.remove		= __devexit_p(e3d_pci_unregister),
+	.remove		= e3d_pci_unregister,
 };
 
 static int __init e3d_init(void)
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 07c66e9..9f57539 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -518,7 +518,7 @@ static struct platform_driver tcx_driver = {
 		.of_match_table = tcx_match,
 	},
 	.probe		= tcx_probe,
-	.remove		= __devexit_p(tcx_remove),
+	.remove		= tcx_remove,
 };
 
 static int __init tcx_init(void)
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index e026724..bbb0d95 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -156,7 +156,7 @@ static struct pci_driver tdfxfb_driver = {
 	.name		= "tdfxfb",
 	.id_table	= tdfxfb_id_table,
 	.probe		= tdfxfb_probe,
-	.remove		= __devexit_p(tdfxfb_remove),
+	.remove		= tdfxfb_remove,
 };
 
 MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index aba7686..7333152 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -107,7 +107,7 @@ static struct pci_driver tgafb_pci_driver = {
 	.name			= "tgafb",
 	.id_table		= tgafb_pci_table,
 	.probe			= tgafb_pci_register,
-	.remove			= __devexit_p(tgafb_pci_unregister),
+	.remove			= tgafb_pci_unregister,
 };
 
 static int __devinit
@@ -143,7 +143,7 @@ static struct tc_driver tgafb_tc_driver = {
 		.name		= "tgafb",
 		.bus		= &tc_bus_type,
 		.probe		= tgafb_tc_register,
-		.remove		= __devexit_p(tgafb_tc_unregister),
+		.remove		= tgafb_tc_unregister,
 	},
 };
 
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index b244f06..7c8133e 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -1002,7 +1002,7 @@ static struct platform_driver tmiofb_driver = {
 	.driver.name	= "tmio-fb",
 	.driver.owner	= THIS_MODULE,
 	.probe		= tmiofb_probe,
-	.remove		= __devexit_p(tmiofb_remove),
+	.remove		= tmiofb_remove,
 	.suspend	= tmiofb_suspend,
 	.resume		= tmiofb_resume,
 };
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index 34cf019..a3f207b 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -1591,7 +1591,7 @@ static struct pci_driver tridentfb_pci_driver = {
 	.name = "tridentfb",
 	.id_table = trident_devices,
 	.probe = trident_pci_probe,
-	.remove = __devexit_p(trident_pci_remove)
+	.remove = trident_pci_remove
 };
 
 /*
diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 4709edc..a2bacf8 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -1060,7 +1060,7 @@ static struct pci_driver vmlfb_pci_driver = {
 	.name = "vmlfb",
 	.id_table = vml_ids,
 	.probe = vml_pci_probe,
-	.remove = __devexit_p(vml_pci_remove)
+	.remove = vml_pci_remove
 };
 
 static void __exit vmlfb_cleanup(void)
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 0267acd..1ab146a 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1407,7 +1407,7 @@ static int __devexit vga16fb_remove(struct platform_device *dev)
 
 static struct platform_driver vga16fb_driver = {
 	.probe = vga16fb_probe,
-	.remove = __devexit_p(vga16fb_remove),
+	.remove = vga16fb_remove,
 	.driver = {
 		.name = "vga16fb",
 	},
diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index dd58b53..29b3af8 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -760,7 +760,7 @@ static struct pci_driver via_driver = {
 	.name		= "viafb",
 	.id_table	= via_pci_table,
 	.probe		= via_pci_probe,
-	.remove		= __devexit_p(via_pci_remove),
+	.remove		= via_pci_remove,
 #ifdef CONFIG_PM
 	.suspend	= via_suspend,
 	.resume		= via_resume,
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 9af8da7..22063bb 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -505,7 +505,7 @@ static const struct of_device_id via_dt_ids[] = {
 
 static struct platform_driver vt8500lcd_driver = {
 	.probe		= vt8500lcd_probe,
-	.remove		= __devexit_p(vt8500lcd_remove),
+	.remove		= vt8500lcd_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "vt8500-lcd",
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 4e74d26..f0bce7a 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -917,7 +917,7 @@ static struct pci_driver vt8623fb_pci_driver = {
 	.name		= "vt8623fb",
 	.id_table	= vt8623_devices,
 	.probe		= vt8623_pci_probe,
-	.remove		= __devexit_p(vt8623_pci_remove),
+	.remove		= vt8623_pci_remove,
 	.suspend	= vt8623_pci_suspend,
 	.resume		= vt8623_pci_resume,
 };
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 2f6b2b8..614e1bd 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -1624,7 +1624,7 @@ static void w100_vsync(void)
 
 static struct platform_driver w100fb_driver = {
 	.probe		= w100fb_probe,
-	.remove		= __devexit_p(w100fb_remove),
+	.remove		= w100fb_remove,
 	.suspend	= w100fb_suspend,
 	.resume		= w100fb_resume,
 	.driver		= {
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 77539c1..5c126af 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -462,7 +462,7 @@ static const struct of_device_id wmt_dt_ids[] = {
 
 static struct platform_driver wm8505fb_driver = {
 	.probe		= wm8505fb_probe,
-	.remove		= __devexit_p(wm8505fb_remove),
+	.remove		= wm8505fb_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index ba025b4..46b7a09 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -165,7 +165,7 @@ static const struct of_device_id wmt_dt_ids[] = {
 
 static struct platform_driver wmt_ge_rops_driver = {
 	.probe		= wmt_ge_rops_probe,
-	.remove		= __devexit_p(wmt_ge_rops_remove),
+	.remove		= wmt_ge_rops_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "wmt_ge_rops",
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 1808452..20a7c0e 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -503,7 +503,7 @@ MODULE_DEVICE_TABLE(of, xilinxfb_of_match);
 
 static struct platform_driver xilinxfb_of_driver = {
 	.probe = xilinxfb_of_probe,
-	.remove = __devexit_p(xilinxfb_of_remove),
+	.remove = xilinxfb_of_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
-- 
1.8.0

