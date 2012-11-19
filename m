From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 446/493] video: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:35 -0500
Message-ID: <1353349642-3677-446-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Jaya Kumar <jayalk@intworks.biz>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Jingoo Han <jg1.han@samsung.com>, Inki Dae <inki.dae@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Sascha Hauer <kernel@pengutronix.de>, Maik Broemme <mbroemme@plusserver.de>, Antonino Daplas <adaplas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Winischhofer <thomas@winischhofer.net>, Michal Januszewski <spock@gentoo.org>, Tony Prisk <linux@prisktech.co.nz>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth
List-Id: linux-omap@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
Cc: Michal Januszewski <spock@gentoo.org> 
Cc: Tony Prisk <linux@prisktech.co.nz> 
Cc: linux-fbdev@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-geode@lists.infradead.org 
Cc: linux-nvidia@lists.surfsouth.com 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 drivers/video/arcfb.c                                   |  2 +-
 drivers/video/arkfb.c                                   |  2 +-
 drivers/video/asiliantfb.c                              |  2 +-
 drivers/video/aty/aty128fb.c                            |  2 +-
 drivers/video/aty/atyfb_base.c                          |  4 ++--
 drivers/video/aty/radeon_base.c                         |  2 +-
 drivers/video/au1200fb.c                                |  2 +-
 drivers/video/auo_k1900fb.c                             |  2 +-
 drivers/video/auo_k1901fb.c                             |  2 +-
 drivers/video/auo_k190x.c                               |  2 +-
 drivers/video/bf537-lq035.c                             |  4 ++--
 drivers/video/bf54x-lq043fb.c                           |  2 +-
 drivers/video/bfin-lq035q1-fb.c                         |  2 +-
 drivers/video/bfin-t350mcqb-fb.c                        |  2 +-
 drivers/video/bfin_adv7393fb.c                          |  2 +-
 drivers/video/broadsheetfb.c                            |  2 +-
 drivers/video/bw2.c                                     |  2 +-
 drivers/video/carminefb.c                               |  2 +-
 drivers/video/cg14.c                                    |  2 +-
 drivers/video/cg3.c                                     |  2 +-
 drivers/video/cg6.c                                     |  2 +-
 drivers/video/chipsfb.c                                 |  2 +-
 drivers/video/cirrusfb.c                                |  6 +++---
 drivers/video/cobalt_lcdfb.c                            |  2 +-
 drivers/video/console/sticore.c                         |  2 +-
 drivers/video/cyber2000fb.c                             |  4 ++--
 drivers/video/da8xx-fb.c                                |  2 +-
 drivers/video/ep93xx-fb.c                               |  2 +-
 drivers/video/exynos/exynos_dp_core.c                   |  2 +-
 drivers/video/exynos/exynos_mipi_dsi.c                  |  2 +-
 drivers/video/ffb.c                                     |  2 +-
 drivers/video/gbefb.c                                   |  4 ++--
 drivers/video/geode/gx1fb_core.c                        |  4 ++--
 drivers/video/geode/gxfb_core.c                         |  2 +-
 drivers/video/geode/lxfb_core.c                         |  2 +-
 drivers/video/grvga.c                                   |  2 +-
 drivers/video/gxt4500.c                                 |  2 +-
 drivers/video/hecubafb.c                                |  2 +-
 drivers/video/hgafb.c                                   |  2 +-
 drivers/video/hitfb.c                                   |  2 +-
 drivers/video/hpfb.c                                    |  2 +-
 drivers/video/i740fb.c                                  |  2 +-
 drivers/video/imsttfb.c                                 |  2 +-
 drivers/video/imxfb.c                                   |  2 +-
 drivers/video/intelfb/intelfbdrv.c                      |  4 ++--
 drivers/video/jz4740_fb.c                               |  2 +-
 drivers/video/kyro/fbdev.c                              |  2 +-
 drivers/video/leo.c                                     |  2 +-
 drivers/video/mb862xx/mb862xxfbdrv.c                    |  4 ++--
 drivers/video/mbx/mbxdebugfs.c                          |  2 +-
 drivers/video/mbx/mbxfb.c                               |  2 +-
 drivers/video/metronomefb.c                             |  2 +-
 drivers/video/mxsfb.c                                   |  4 ++--
 drivers/video/neofb.c                                   |  2 +-
 drivers/video/nvidia/nvidia.c                           |  2 +-
 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c |  2 +-
 drivers/video/omap2/displays/panel-tpo-td043mtea1.c     |  2 +-
 drivers/video/p9100.c                                   |  2 +-
 drivers/video/platinumfb.c                              |  2 +-
 drivers/video/pm2fb.c                                   |  2 +-
 drivers/video/pm3fb.c                                   |  2 +-
 drivers/video/pvr2fb.c                                  |  2 +-
 drivers/video/pxa168fb.c                                |  2 +-
 drivers/video/pxa3xx-gcu.c                              |  2 +-
 drivers/video/pxafb.c                                   |  4 ++--
 drivers/video/riva/fbdev.c                              |  2 +-
 drivers/video/s3c-fb.c                                  |  2 +-
 drivers/video/s3c2410fb.c                               |  2 +-
 drivers/video/s3fb.c                                    |  2 +-
 drivers/video/savage/savagefb_driver.c                  |  2 +-
 drivers/video/sgivwfb.c                                 |  2 +-
 drivers/video/sh7760fb.c                                |  2 +-
 drivers/video/sh_mipi_dsi.c                             |  2 +-
 drivers/video/sis/sis_main.c                            |  2 +-
 drivers/video/skeletonfb.c                              |  4 ++--
 drivers/video/sstfb.c                                   |  6 +++---
 drivers/video/sunxvr1000.c                              |  2 +-
 drivers/video/sunxvr2500.c                              |  2 +-
 drivers/video/sunxvr500.c                               |  2 +-
 drivers/video/tcx.c                                     |  2 +-
 drivers/video/tdfxfb.c                                  |  4 ++--
 drivers/video/tgafb.c                                   | 14 +++++++-------
 drivers/video/tmiofb.c                                  |  2 +-
 drivers/video/tridentfb.c                               |  2 +-
 drivers/video/uvesafb.c                                 |  2 +-
 drivers/video/vermilion/vermilion.c                     |  2 +-
 drivers/video/vga16fb.c                                 |  2 +-
 drivers/video/via/via-core.c                            |  2 +-
 drivers/video/via/viafbdev.c                            |  2 +-
 drivers/video/vt8500lcdfb.c                             |  2 +-
 drivers/video/vt8623fb.c                                |  2 +-
 drivers/video/w100fb.c                                  |  2 +-
 drivers/video/wm8505fb.c                                |  2 +-
 drivers/video/wmt_ge_rops.c                             |  2 +-
 drivers/video/xilinxfb.c                                |  2 +-
 95 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 3ef36a9..e43401a 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -587,7 +587,7 @@ err:
 	return retval;
 }
 
-static int __devexit arcfb_remove(struct platform_device *dev)
+static int arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 459b31e..94a51f1 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1086,7 +1086,7 @@ err_enable_device:
 
 /* PCI remove */
 
-static void __devexit ark_pci_remove(struct pci_dev *dev)
+static void ark_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index d291750..0e5ea94 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -581,7 +581,7 @@ asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	return 0;
 }
 
-static void __devexit asiliantfb_remove(struct pci_dev *dp)
+static void asiliantfb_remove(struct pci_dev *dp)
 {
 	struct fb_info *p = pci_get_drvdata(dp);
 
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index e63fc9d..9cdf5a4 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -2156,7 +2156,7 @@ err_free_fb:
 	return -ENODEV;
 }
 
-static void __devexit aty128_remove(struct pci_dev *pdev)
+static void aty128_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index a3f117d..bdd98ac 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3714,7 +3714,7 @@ static int __init atyfb_atari_probe(void)
 
 #ifdef CONFIG_PCI
 
-static void __devexit atyfb_remove(struct fb_info *info)
+static void atyfb_remove(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
@@ -3762,7 +3762,7 @@ static void __devexit atyfb_remove(struct fb_info *info)
 }
 
 
-static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
+static void atyfb_pci_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 7687179..6416137 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2407,7 +2407,7 @@ err_out:
 
 
 
-static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+static void radeonfb_pci_unregister (struct pci_dev *pdev)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index b270a5c..1b59054 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1798,7 +1798,7 @@ failed:
 	return ret;
 }
 
-static int __devexit au1200fb_drv_remove(struct platform_device *dev)
+static int au1200fb_drv_remove(struct platform_device *dev)
 {
 	struct au1200fb_platdata *pd = platform_get_drvdata(dev);
 	struct au1200fb_device *fbdev;
diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
index 46ec47b..1a9ac6e 100644
--- a/drivers/video/auo_k1900fb.c
+++ b/drivers/video/auo_k1900fb.c
@@ -177,7 +177,7 @@ static int auok1900fb_probe(struct platform_device *pdev)
 	return auok190x_common_probe(pdev, &init);
 }
 
-static int __devexit auok1900fb_remove(struct platform_device *pdev)
+static int auok1900fb_remove(struct platform_device *pdev)
 {
 	return auok190x_common_remove(pdev);
 }
diff --git a/drivers/video/auo_k1901fb.c b/drivers/video/auo_k1901fb.c
index 9eb7eeb..d1db165 100644
--- a/drivers/video/auo_k1901fb.c
+++ b/drivers/video/auo_k1901fb.c
@@ -230,7 +230,7 @@ static int auok1901fb_probe(struct platform_device *pdev)
 	return auok190x_common_probe(pdev, &init);
 }
 
-static int __devexit auok1901fb_remove(struct platform_device *pdev)
+static int auok1901fb_remove(struct platform_device *pdev)
 {
 	return auok190x_common_remove(pdev);
 }
diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 70aa5d4..800898b 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -1006,7 +1006,7 @@ err_reg:
 }
 EXPORT_SYMBOL_GPL(auok190x_common_probe);
 
-int  __devexit auok190x_common_remove(struct platform_device *pdev)
+int  auok190x_common_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct auok190xfb_par *par = info->par;
diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index 5b8e95d..44b8c36 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -108,7 +108,7 @@ static int ad5280_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit ad5280_remove(struct i2c_client *client)
+static int ad5280_remove(struct i2c_client *client)
 {
 	ad5280_client = NULL;
 	return 0;
@@ -816,7 +816,7 @@ out_ports:
 	return ret;
 }
 
-static int __devexit bfin_lq035_remove(struct platform_device *pdev)
+static int bfin_lq035_remove(struct platform_device *pdev)
 {
 	if (fb_buffer != NULL)
 		dma_free_coherent(NULL, TOTAL_VIDEO_MEM_SIZE, fb_buffer, 0);
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 9f72580..2726a5b 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -686,7 +686,7 @@ out1:
 	return ret;
 }
 
-static int __devexit bfin_bf54x_remove(struct platform_device *pdev)
+static int bfin_bf54x_remove(struct platform_device *pdev)
 {
 
 	struct fb_info *fbinfo = platform_get_drvdata(pdev);
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 353fb7c..20c26374 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -764,7 +764,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit bfin_lq035q1_remove(struct platform_device *pdev)
+static int bfin_lq035q1_remove(struct platform_device *pdev)
 {
 	struct fb_info *fbinfo = platform_get_drvdata(pdev);
 	struct bfin_lq035q1fb_info *info = fbinfo->par;
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 9456865..d46da01 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -583,7 +583,7 @@ out1:
 	return ret;
 }
 
-static int __devexit bfin_t350mcqb_remove(struct platform_device *pdev)
+static int bfin_t350mcqb_remove(struct platform_device *pdev)
 {
 
 	struct fb_info *fbinfo = platform_get_drvdata(pdev);
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index 5754140..90196d3 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -719,7 +719,7 @@ static int bfin_adv7393_fb_setcolreg(u_int regno, u_int red, u_int green,
 	return 0;
 }
 
-static int __devexit bfin_adv7393_fb_remove(struct i2c_client *client)
+static int bfin_adv7393_fb_remove(struct i2c_client *client)
 {
 	struct adv7393fb_device *fbdev = i2c_get_clientdata(client);
 
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index bc04699..b09701c 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -1190,7 +1190,7 @@ err:
 
 }
 
-static int __devexit broadsheetfb_remove(struct platform_device *dev)
+static int broadsheetfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 7695927..652b693 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -352,7 +352,7 @@ out_err:
 	return err;
 }
 
-static int __devexit bw2_remove(struct platform_device *op)
+static int bw2_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct bw2_par *par = info->par;
diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index ccbe958..5780afa 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -721,7 +721,7 @@ err_enable_pci:
 	return ret;
 }
 
-static void __devexit carminefb_remove(struct pci_dev *dev)
+static void carminefb_remove(struct pci_dev *dev)
 {
 	struct carmine_hw *hw = pci_get_drvdata(dev);
 	struct fb_fix_screeninfo fix;
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index 1b95656..9738ca2 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -571,7 +571,7 @@ out_err:
 	return err;
 }
 
-static int __devexit cg14_remove(struct platform_device *op)
+static int cg14_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct cg14_par *par = info->par;
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 4d20257..a26ecfa 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -433,7 +433,7 @@ out_err:
 	return err;
 }
 
-static int __devexit cg3_remove(struct platform_device *op)
+static int cg3_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct cg3_par *par = info->par;
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 3204e5a..3545dec 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -827,7 +827,7 @@ out_err:
 	return err;
 }
 
-static int __devexit cg6_remove(struct platform_device *op)
+static int cg6_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct cg6_par *par = info->par;
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index 71f46e3..ee60b3c 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -438,7 +438,7 @@ chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	return rc;
 }
 
-static void __devexit chipsfb_remove(struct pci_dev *dp)
+static void chipsfb_remove(struct pci_dev *dp)
 {
 	struct fb_info *p = pci_get_drvdata(dp);
 
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index f8961c3..12ba41f 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2096,7 +2096,7 @@ err_dealloc_cmap:
 	return err;
 }
 
-static void __devexit cirrusfb_cleanup(struct fb_info *info)
+static void cirrusfb_cleanup(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 
@@ -2215,7 +2215,7 @@ err_out:
 	return ret;
 }
 
-static void __devexit cirrusfb_pci_unregister(struct pci_dev *pdev)
+static void cirrusfb_pci_unregister(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 
@@ -2352,7 +2352,7 @@ err_release_fb:
 	return error;
 }
 
-void __devexit cirrusfb_zorro_unregister(struct zorro_dev *z)
+void cirrusfb_zorro_unregister(struct zorro_dev *z)
 {
 	struct fb_info *info = zorro_get_drvdata(z);
 
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index bea956e..a903149 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -374,7 +374,7 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit cobalt_lcdfb_remove(struct platform_device *dev)
+static int cobalt_lcdfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info;
 
diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index a4827da..e5b654c 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -998,7 +998,7 @@ static int sticore_pci_init(struct pci_dev *pd,
 }
 
 
-static void __devexit sticore_pci_remove(struct pci_dev *pd)
+static void sticore_pci_remove(struct pci_dev *pd)
 {
 	BUG();
 }
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index b93cabc..bbdcac7 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1615,7 +1615,7 @@ failed:
 	return err;
 }
 
-static void __devexit cyberpro_common_remove(struct cfb_info *cfb)
+static void cyberpro_common_remove(struct cfb_info *cfb)
 {
 	unregister_framebuffer(&cfb->fb);
 #ifdef CONFIG_FB_CYBER2000_DDC
@@ -1863,7 +1863,7 @@ failed_release:
 	return err;
 }
 
-static void __devexit cyberpro_pci_remove(struct pci_dev *dev)
+static void cyberpro_pci_remove(struct pci_dev *dev)
 {
 	struct cfb_info *cfb = pci_get_drvdata(dev);
 
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 33b286b..229b9bd 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1012,7 +1012,7 @@ static inline void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
 }
 #endif
 
-static int __devexit fb_remove(struct platform_device *dev)
+static int fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
 
diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index ef4ca55..3f2519d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -599,7 +599,7 @@ failed_cmap:
 	return err;
 }
 
-static int __devexit ep93xxfb_remove(struct platform_device *pdev)
+static int ep93xxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct ep93xx_fbi *fbi = info->par;
diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 47f0448..aa845cd 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -948,7 +948,7 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit exynos_dp_remove(struct platform_device *pdev)
+static int exynos_dp_remove(struct platform_device *pdev)
 {
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 1571db7..4a17cdc 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -490,7 +490,7 @@ err_platform_get_irq:
 	return ret;
 }
 
-static int __devexit exynos_mipi_dsi_remove(struct platform_device *pdev)
+static int exynos_mipi_dsi_remove(struct platform_device *pdev)
 {
 	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
 	struct mipi_dsim_ddi *dsim_ddi, *next;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 46aee0e..6d27447 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1022,7 +1022,7 @@ out_err:
 	return err;
 }
 
-static int __devexit ffb_remove(struct platform_device *op)
+static int ffb_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct ffb_par *par = info->par;
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index f2e9788..bda5e39 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1082,7 +1082,7 @@ static ssize_t gbefb_show_rev(struct device *device, struct device_attribute *at
 
 static DEVICE_ATTR(revision, S_IRUGO, gbefb_show_rev, NULL);
 
-static void __devexit gbefb_remove_sysfs(struct device *dev)
+static void gbefb_remove_sysfs(struct device *dev)
 {
 	device_remove_file(dev, &dev_attr_size);
 	device_remove_file(dev, &dev_attr_revision);
@@ -1254,7 +1254,7 @@ out_release_framebuffer:
 	return ret;
 }
 
-static int __devexit gbefb_remove(struct platform_device* p_dev)
+static int gbefb_remove(struct platform_device* p_dev)
 {
 	struct fb_info *info = platform_get_drvdata(p_dev);
 
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index cf97a70..ebbaada 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -382,7 +382,7 @@ static int gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void __devexit gx1fb_remove(struct pci_dev *pdev)
+static void gx1fb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct geodefb_par *par = info->par;
@@ -456,7 +456,7 @@ static int __init gx1fb_init(void)
 	return pci_register_driver(&gx1fb_driver);
 }
 
-static void __devexit gx1fb_cleanup(void)
+static void gx1fb_cleanup(void)
 {
 	pci_unregister_driver(&gx1fb_driver);
 }
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index d40a9eb..ca0a422 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -455,7 +455,7 @@ static int gxfb_probe(struct pci_dev *pdev,
 	return ret;
 }
 
-static void __devexit gxfb_remove(struct pci_dev *pdev)
+static void gxfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct gxfb_par *par = info->par;
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 04f0098..af07dce 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -590,7 +590,7 @@ err:
 	return ret;
 }
 
-static void __devexit lxfb_remove(struct pci_dev *pdev)
+static void lxfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct lxfb_par *par = info->par;
diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 3cdfacd..8b1dd9a 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -512,7 +512,7 @@ free_fb:
 	return retval;
 }
 
-static int __devexit grvga_remove(struct platform_device *device)
+static int grvga_remove(struct platform_device *device)
 {
 	struct fb_info *info = dev_get_drvdata(&device->dev);
 	struct grvga_par *par = info->par;
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 58d3543..09133de 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -720,7 +720,7 @@ static int gxt4500_probe(struct pci_dev *pdev,
 	return -ENODEV;
 }
 
-static void __devexit gxt4500_remove(struct pci_dev *pdev)
+static void gxt4500_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct gxt4500_par *par;
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 298f977..59d2318 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -280,7 +280,7 @@ err_videomem_alloc:
 	return retval;
 }
 
-static int __devexit hecubafb_remove(struct platform_device *dev)
+static int hecubafb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index 43b3976..1e9e2d8 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -592,7 +592,7 @@ static int hgafb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit hgafb_remove(struct platform_device *pdev)
+static int hgafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
index adb6708..c2414d6 100644
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -417,7 +417,7 @@ err_fb:
 	return ret;
 }
 
-static int __devexit hitfb_remove(struct platform_device *dev)
+static int hitfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
index aa2abe8..d6bbd98 100644
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -350,7 +350,7 @@ static int hpfb_dio_probe(struct dio_dev * d, const struct dio_device_id * ent)
 	return 0;
 }
 
-static void __devexit hpfb_remove_one(struct dio_dev *d)
+static void hpfb_remove_one(struct dio_dev *d)
 {
 	unregister_framebuffer(&fb_info);
 	if (d->scode >= DIOII_SCBASE)
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index 05c7d94..47671f1 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -1174,7 +1174,7 @@ err_enable_device:
 	return ret;
 }
 
-static void __devexit i740fb_remove(struct pci_dev *dev)
+static void i740fb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 7060401..954ac45 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1534,7 +1534,7 @@ imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 }
 
-static void __devexit
+static void
 imsttfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index e1fbfb0..1252678 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -917,7 +917,7 @@ failed_init:
 	return ret;
 }
 
-static int __devexit imxfb_remove(struct platform_device *pdev)
+static int imxfb_remove(struct platform_device *pdev)
 {
 	struct imx_fb_platform_data *pdata;
 	struct fb_info *info = platform_get_drvdata(pdev);
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 184bbb7..524b87f 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -164,7 +164,7 @@ static int intelfb_ioctl(struct fb_info *info,
 
 static int intelfb_pci_register(struct pci_dev *pdev,
 					  const struct pci_device_id *ent);
-static void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
+static void intelfb_pci_unregister(struct pci_dev *pdev);
 static int intelfb_set_fbinfo(struct intelfb_info *dinfo);
 
 /*
@@ -921,7 +921,7 @@ err_out_cmap:
 	return -ENODEV;
 }
 
-static void __devexit
+static void
 intelfb_pci_unregister(struct pci_dev *pdev)
 {
 	struct intelfb_info *dinfo = pci_get_drvdata(pdev);
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 9f5003f..d999bb5 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -725,7 +725,7 @@ err_framebuffer_release:
 	return ret;
 }
 
-static int __devexit jzfb_remove(struct platform_device *pdev)
+static int jzfb_remove(struct platform_device *pdev)
 {
 	struct jzfb *jzfb = platform_get_drvdata(pdev);
 
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 2f0effd..fea5b52 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -754,7 +754,7 @@ out_unmap:
 	return -EINVAL;
 }
 
-static void __devexit kyrofb_remove(struct pci_dev *pdev)
+static void kyrofb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct kyrofb_info *par = info->par;
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 8c64c79..b17f500 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -636,7 +636,7 @@ out_err:
 	return err;
 }
 
-static int __devexit leo_remove(struct platform_device *op)
+static int leo_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct leo_par *par = info->par;
diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 28ae8fb..a7611b7 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -786,7 +786,7 @@ fbrel:
 	return ret;
 }
 
-static int __devexit of_platform_mb862xx_remove(struct platform_device *ofdev)
+static int of_platform_mb862xx_remove(struct platform_device *ofdev)
 {
 	struct fb_info *fbi = dev_get_drvdata(&ofdev->dev);
 	struct mb862xxfb_par *par = fbi->par;
@@ -1133,7 +1133,7 @@ out:
 	return ret;
 }
 
-static void __devexit mb862xx_pci_remove(struct pci_dev *pdev)
+static void mb862xx_pci_remove(struct pci_dev *pdev)
 {
 	struct fb_info *fbi = pci_get_drvdata(pdev);
 	struct mb862xxfb_par *par = fbi->par;
diff --git a/drivers/video/mbx/mbxdebugfs.c b/drivers/video/mbx/mbxdebugfs.c
index 474f94f..4449f24 100644
--- a/drivers/video/mbx/mbxdebugfs.c
+++ b/drivers/video/mbx/mbxdebugfs.c
@@ -236,7 +236,7 @@ static void mbxfb_debugfs_init(struct fb_info *fbi)
 					fbi, &misc_fops);
 }
 
-static void __devexit mbxfb_debugfs_remove(struct fb_info *fbi)
+static void mbxfb_debugfs_remove(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
 	struct mbxfb_debugfs_data *dbg = mfbi->debugfs_data;
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index faa171f..f3a9ede 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -1006,7 +1006,7 @@ err1:
 	return ret;
 }
 
-static int __devexit mbxfb_remove(struct platform_device *dev)
+static int mbxfb_remove(struct platform_device *dev)
 {
 	struct fb_info *fbi = platform_get_drvdata(dev);
 
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 6454888..d3fc9b1 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -741,7 +741,7 @@ err:
 	return retval;
 }
 
-static int __devexit metronomefb_remove(struct platform_device *dev)
+static int metronomefb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index be26b36..a45b37c 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -739,7 +739,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	return 0;
 }
 
-static void __devexit mxsfb_free_videomem(struct mxsfb_info *host)
+static void mxsfb_free_videomem(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
 
@@ -912,7 +912,7 @@ error_alloc_info:
 	return ret;
 }
 
-static int __devexit mxsfb_remove(struct platform_device *pdev)
+static int mxsfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *fb_info = platform_get_drvdata(pdev);
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index b86fd96..9770ff3 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -2128,7 +2128,7 @@ err_map_mmio:
 	return err;
 }
 
-static void __devexit neofb_remove(struct pci_dev *dev)
+static void neofb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index b7f8feb..fd4e7bf 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1438,7 +1438,7 @@ err_out:
 	return -ENODEV;
 }
 
-static void __devexit nvidiafb_remove(struct pci_dev *pd)
+static void nvidiafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct nvidia_par *par = info->par;
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 4ed48af..0b36093 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -256,7 +256,7 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 	return omap_dss_register_driver(&lb035q02_driver);
 }
 
-static int __devexit lb035q02_panel_spi_remove(struct spi_device *spi)
+static int lb035q02_panel_spi_remove(struct spi_device *spi)
 {
 	omap_dss_unregister_driver(&lb035q02_driver);
 	return 0;
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index d655389..60f1990 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -548,7 +548,7 @@ static int tpo_td043_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit tpo_td043_spi_remove(struct spi_device *spi)
+static int tpo_td043_spi_remove(struct spi_device *spi)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index 62d8339..4b23af6 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -326,7 +326,7 @@ out_err:
 	return err;
 }
 
-static int __devexit p9100_remove(struct platform_device *op)
+static int p9100_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct p9100_par *par = info->par;
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index f638002..5113bf3 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -645,7 +645,7 @@ static int platinumfb_probe(struct platform_device* odev)
 	return rc;
 }
 
-static int __devexit platinumfb_remove(struct platform_device* odev)
+static int platinumfb_remove(struct platform_device* odev)
 {
 	struct fb_info		*info = dev_get_drvdata(&odev->dev);
 	struct fb_info_platinum	*pinfo = info->par;
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index f3ab16b..8fbfcc2 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1727,7 +1727,7 @@ static int pm2fb_probe(struct pci_dev *pdev,
  *
  * @param	pdev	PCI device to clean up.
  */
-static void __devexit pm2fb_remove(struct pci_dev *pdev)
+static void pm2fb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct fb_fix_screeninfo *fix = &info->fix;
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 60d608b..dbc75d0 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1469,7 +1469,7 @@ static int pm3fb_probe(struct pci_dev *dev,
 	/*
 	 *  Cleanup
 	 */
-static void __devexit pm3fb_remove(struct pci_dev *dev)
+static void pm3fb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 05ca970..2e08e36 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -953,7 +953,7 @@ static int pvr2fb_pci_probe(struct pci_dev *pdev,
 	return pvr2fb_common_init();
 }
 
-static void __devexit pvr2fb_pci_remove(struct pci_dev *pdev)
+static void pvr2fb_pci_remove(struct pci_dev *pdev)
 {
 	if (fb_info->screen_base) {
 		iounmap(fb_info->screen_base);
diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 49af862..aa9bd1f 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -783,7 +783,7 @@ failed_put_clk:
 	return ret;
 }
 
-static int __devexit pxa168fb_remove(struct platform_device *pdev)
+static int pxa168fb_remove(struct platform_device *pdev)
 {
 	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
 	struct fb_info *info;
diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index f163474..d658902 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -714,7 +714,7 @@ err_free_priv:
 	return ret;
 }
 
-static int __devexit
+static int
 pxa3xx_gcu_remove(struct platform_device *dev)
 {
 	struct pxa3xx_gcu_priv *priv = platform_get_drvdata(dev);
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 9289bcf..082a602 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -959,7 +959,7 @@ static void pxafb_overlay_init(struct pxafb_info *fbi)
 	pr_info("PXA Overlay driver loaded successfully!\n");
 }
 
-static void __devexit pxafb_overlay_exit(struct pxafb_info *fbi)
+static void pxafb_overlay_exit(struct pxafb_info *fbi)
 {
 	int i;
 
@@ -2263,7 +2263,7 @@ failed:
 	return ret;
 }
 
-static int __devexit pxafb_remove(struct platform_device *dev)
+static int pxafb_remove(struct platform_device *dev)
 {
 	struct pxafb_info *fbi = platform_get_drvdata(dev);
 	struct resource *r;
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 0cdf63b..b453625 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -2105,7 +2105,7 @@ err_ret:
 	return ret;
 }
 
-static void __devexit rivafb_remove(struct pci_dev *pd)
+static void rivafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct riva_par *par = info->par;
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 141fefd..def429c 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1519,7 +1519,7 @@ err_bus_clk:
  * Shutdown and then release all the resources that the driver allocated
  * on initialisation.
  */
-static int __devexit s3c_fb_remove(struct platform_device *pdev)
+static int s3c_fb_remove(struct platform_device *pdev)
 {
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	int win;
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 528cec6..3ffbdd1 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -1024,7 +1024,7 @@ static int s3c2412fb_probe(struct platform_device *pdev)
 /*
  *  Cleanup
  */
-static int __devexit s3c2410fb_remove(struct platform_device *pdev)
+static int s3c2410fb_remove(struct platform_device *pdev)
 {
 	struct fb_info *fbinfo = platform_get_drvdata(pdev);
 	struct s3c2410fb_info *info = fbinfo->par;
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 0ff9a77..47ca86c 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1403,7 +1403,7 @@ err_enable_device:
 
 /* PCI remove */
 
-static void __devexit s3_pci_remove(struct pci_dev *dev)
+static void s3_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct s3fb_info __maybe_unused *par = info->par;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 4bfb8c6..8f3b531 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2340,7 +2340,7 @@ static int savagefb_probe(struct pci_dev* dev,
 	return err;
 }
 
-static void __devexit savagefb_remove(struct pci_dev *dev)
+static void savagefb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index 23df880..2331fad 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -825,7 +825,7 @@ fail_ioremap_regs:
 	return -ENXIO;
 }
 
-static int __devexit sgivwfb_remove(struct platform_device *dev)
+static int sgivwfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 0ad44d1..5fbb0c7 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -557,7 +557,7 @@ out_fb:
 	return ret;
 }
 
-static int __devexit sh7760fb_remove(struct platform_device *dev)
+static int sh7760fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct sh7760fb_par *par = info->par;
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index ad47e48..80895c8 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -550,7 +550,7 @@ efindslot:
 	return ret;
 }
 
-static int __devexit sh_mipi_remove(struct platform_device *pdev)
+static int sh_mipi_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index e60df84..832a8cf 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -6528,7 +6528,7 @@ error_3:	vfree(ivideo->bios_abase);
 /*                PCI DEVICE HANDLING                */
 /*****************************************************/
 
-static void __devexit sisfb_remove(struct pci_dev *pdev)
+static void sisfb_remove(struct pci_dev *pdev)
 {
 	struct sis_video_info	*ivideo = pci_get_drvdata(pdev);
 	struct fb_info		*sis_fb_info = ivideo->memyselfandi;
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index dde47f7..8dcc181 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -835,8 +835,8 @@ static int xxxfb_probe(struct pci_dev *dev,
     /*
      *  Cleanup
      */
-/* static void __devexit xxxfb_remove(struct platform_device *pdev) */
-static void __devexit xxxfb_remove(struct pci_dev *dev)
+/* static void xxxfb_remove(struct platform_device *pdev) */
+static void xxxfb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	/* or platform_get_drvdata(pdev); */
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 49f9338..8f7c076 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1239,7 +1239,7 @@ static int sst_init(struct fb_info *info, struct sstfb_par *par)
 	return 1;
 }
 
-static void  __devexit sst_shutdown(struct fb_info *info)
+static void  sst_shutdown(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	struct pci_dev *dev = par->dev;
@@ -1458,7 +1458,7 @@ fail_mmio_mem:
 	return -ENXIO; 	/* no voodoo detected */
 }
 
-static void __devexit sstfb_remove(struct pci_dev *pdev)
+static void sstfb_remove(struct pci_dev *pdev)
 {
 	struct sstfb_par *par;
 	struct fb_info *info;
@@ -1505,7 +1505,7 @@ static int sstfb_init(void)
 	return pci_register_driver(&sstfb_driver);
 }
 
-static void __devexit sstfb_exit(void)
+static void sstfb_exit(void)
 {
 	pci_unregister_driver(&sstfb_driver);
 }
diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
index 9e86e3c..cc6f48b 100644
--- a/drivers/video/sunxvr1000.c
+++ b/drivers/video/sunxvr1000.c
@@ -173,7 +173,7 @@ err_out:
 	return err;
 }
 
-static int __devexit gfb_remove(struct platform_device *op)
+static int gfb_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct gfb_info *gp = info->par;
diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index b6a14d2..b6c2057 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -219,7 +219,7 @@ err_out:
 	return err;
 }
 
-static void __devexit s3d_pci_unregister(struct pci_dev *pdev)
+static void s3d_pci_unregister(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct s3d_info *sp = info->par;
diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index afcdab1..92202aa 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -392,7 +392,7 @@ err_out:
 	return err;
 }
 
-static void __devexit e3d_pci_unregister(struct pci_dev *pdev)
+static void e3d_pci_unregister(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct e3d_info *ep = info->par;
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index cfdc1bb..c000852 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -486,7 +486,7 @@ out_err:
 	return err;
 }
 
-static int __devexit tcx_remove(struct platform_device *op)
+static int tcx_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct tcx_par *par = info->par;
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 09ec76319..cb8373b 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -137,7 +137,7 @@ static struct fb_var_screeninfo tdfx_var = {
  */
 static int tdfxfb_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id);
-static void __devexit tdfxfb_remove(struct pci_dev *pdev);
+static void tdfxfb_remove(struct pci_dev *pdev);
 
 static struct pci_device_id tdfxfb_id_table[] = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
@@ -1626,7 +1626,7 @@ static void __init tdfxfb_setup(char *options)
  *      lifetime for the PCI device @pdev.
  *
  */
-static void __devexit tdfxfb_remove(struct pci_dev *pdev)
+static void tdfxfb_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct tdfx_par *par = info->par;
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 63fc5ba..945e09f 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -62,7 +62,7 @@ static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int tgafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 
 static int tgafb_register(struct device *dev);
-static void __devexit tgafb_unregister(struct device *dev);
+static void tgafb_unregister(struct device *dev);
 
 static const char *mode_option;
 static const char *mode_option_pci = "640x480@60";
@@ -95,7 +95,7 @@ static struct fb_ops tgafb_ops = {
  */
 static int tgafb_pci_register(struct pci_dev *,
 					const struct pci_device_id *);
-static void __devexit tgafb_pci_unregister(struct pci_dev *);
+static void tgafb_pci_unregister(struct pci_dev *);
 
 static struct pci_device_id const tgafb_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA) },
@@ -116,7 +116,7 @@ tgafb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return tgafb_register(&pdev->dev);
 }
 
-static void __devexit
+static void
 tgafb_pci_unregister(struct pci_dev *pdev)
 {
 	tgafb_unregister(&pdev->dev);
@@ -128,7 +128,7 @@ tgafb_pci_unregister(struct pci_dev *pdev)
  *  TC registration operations
  */
 static int tgafb_tc_register(struct device *);
-static int __devexit tgafb_tc_unregister(struct device *);
+static int tgafb_tc_unregister(struct device *);
 
 static struct tc_device_id const tgafb_tc_table[] = {
 	{ "DEC     ", "PMAGD-AA" },
@@ -156,7 +156,7 @@ tgafb_tc_register(struct device *dev)
 	return status;
 }
 
-static int __devexit
+static int
 tgafb_tc_unregister(struct device *dev)
 {
 	put_device(dev);
@@ -1692,7 +1692,7 @@ tgafb_register(struct device *dev)
 	return ret;
 }
 
-static void __devexit
+static void
 tgafb_unregister(struct device *dev)
 {
 	resource_size_t bar0_start = 0, bar0_len = 0;
@@ -1721,7 +1721,7 @@ tgafb_unregister(struct device *dev)
 	framebuffer_release(info);
 }
 
-static void __devexit
+static void
 tgafb_exit(void)
 {
 	tc_unregister_driver(&tgafb_tc_driver);
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index 91246ab..dc4fb86 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -807,7 +807,7 @@ err_ioremap_ccr:
 	return retval;
 }
 
-static int __devexit tmiofb_remove(struct platform_device *dev)
+static int tmiofb_remove(struct platform_device *dev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	struct fb_info *info = platform_get_drvdata(dev);
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index 03edce6..fe72d6f 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -1543,7 +1543,7 @@ out_unmap1:
 	return err;
 }
 
-static void __devexit trident_pci_remove(struct pci_dev *dev)
+static void trident_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct tridentfb_par *par = info->par;
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index ad5e72d..f9ca933 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1994,7 +1994,7 @@ static int uvesafb_init(void)
 
 module_init(uvesafb_init);
 
-static void __devexit uvesafb_exit(void)
+static void uvesafb_exit(void)
 {
 	struct uvesafb_ktask *task;
 
diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 3e92d0e..48c748a 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -393,7 +393,7 @@ static void vmlfb_release_devices(struct vml_par *par)
  * Free up allocated resources for a device.
  */
 
-static void __devexit vml_pci_remove(struct pci_dev *dev)
+static void vml_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info;
 	struct vml_info *vinfo;
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 99c0edb..545faec 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1395,7 +1395,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int __devexit vga16fb_remove(struct platform_device *dev)
+static int vga16fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index e0d95d5..6ada670 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -716,7 +716,7 @@ out_disable:
 	return ret;
 }
 
-static void __devexit via_pci_remove(struct pci_dev *pdev)
+static void via_pci_remove(struct pci_dev *pdev)
 {
 	via_teardown_subdevs();
 	via_fb_pci_remove(pdev);
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index bb41017..325c43c 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1945,7 +1945,7 @@ out_fb_release:
 	return rc;
 }
 
-void __devexit via_fb_pci_remove(struct pci_dev *pdev)
+void via_fb_pci_remove(struct pci_dev *pdev)
 {
 	DEBUG_MSG(KERN_INFO "via_pci_remove!\n");
 	fb_dealloc_cmap(&viafbinfo->cmap);
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 1b94610..aa2579c 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -469,7 +469,7 @@ failed:
 	return ret;
 }
 
-static int __devexit vt8500lcd_remove(struct platform_device *pdev)
+static int vt8500lcd_remove(struct platform_device *pdev)
 {
 	struct vt8500lcd_info *fbi = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index a3cbe8f..e9557fa 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -807,7 +807,7 @@ err_enable_device:
 
 /* PCI remove */
 
-static void __devexit vt8623_pci_remove(struct pci_dev *dev)
+static void vt8623_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 1c2eaf2..7a299e95 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -783,7 +783,7 @@ out:
 }
 
 
-static int __devexit w100fb_remove(struct platform_device *pdev)
+static int w100fb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 456694a..4dd0580 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -431,7 +431,7 @@ failed:
 	return ret;
 }
 
-static int __devexit wm8505fb_remove(struct platform_device *pdev)
+static int wm8505fb_remove(struct platform_device *pdev)
 {
 	struct wm8505fb_info *fbi = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index e65361d..4aaeb18 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -152,7 +152,7 @@ static int wmt_ge_rops_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit wmt_ge_rops_remove(struct platform_device *pdev)
+static int wmt_ge_rops_remove(struct platform_device *pdev)
 {
 	iounmap(regbase);
 	return 0;
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index eab07ba..af0b4fd 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -485,7 +485,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	return -ENODEV;
 }
 
-static int __devexit xilinxfb_of_remove(struct platform_device *op)
+static int xilinxfb_of_remove(struct platform_device *op)
 {
 	return xilinxfb_release(&op->dev);
 }
-- 
1.8.0
