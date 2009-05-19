From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Tue, 19 May 2009 16:37:32 -0700
Message-ID: <20090519233732.12760.34595.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62495 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZESXhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:37:34 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Imre Deak <imre.deak@nokia.com>, Andrew de Quincey <adq_dvb@lidskialf.net>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Make 770 LCD work by passing the clock from platform data.
Also remove the old unused functions.

Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-nokia770.c     |   16 ++++++++++++++++
 arch/arm/plat-omap/include/mach/hwa742.h |    5 +----
 drivers/video/omap/hwa742.c              |   26 ++++++++++----------------
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 8780ca6..2c4785e 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -33,6 +33,7 @@
 #include <mach/common.h>
 #include <mach/dsp_common.h>
 #include <mach/omapfb.h>
+#include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
@@ -163,6 +164,20 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 	},
 };
 
+static struct hwa742_platform_data nokia770_hwa742_platform_data = {
+	.sys_ck 		= NULL,
+	.te_connected		= 1,
+};
+
+static void hwa742_dev_init(void)
+{
+	nokia770_hwa742_platform_data.sys_ck = clk_get(NULL, "bclk");
+	if (IS_ERR(nokia770_hwa742_platform_data.sys_ck)) {
+		printk(KERN_ERR "can't get HWA742 clock\n");
+	} else {
+		omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
+	}
+}
 
 /* assume no Mini-AB port */
 
@@ -371,6 +386,7 @@ static void __init omap_nokia770_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_dsp_init();
+	hwa742_dev_init();
 	ads7846_dev_init();
 	mipid_dev_init();
 	omap_usb_init(&nokia770_usb_config);
diff --git a/arch/arm/plat-omap/include/mach/hwa742.h b/arch/arm/plat-omap/include/mach/hwa742.h
index 577f492..c00e05d 100644
--- a/arch/arm/plat-omap/include/mach/hwa742.h
+++ b/arch/arm/plat-omap/include/mach/hwa742.h
@@ -2,10 +2,7 @@
 #define _HWA742_H
 
 struct hwa742_platform_data {
-	void		(*power_up)(struct device *dev);
-	void		(*power_down)(struct device *dev);
-	unsigned long	(*get_clock_rate)(struct device *dev);
-
+	struct clk 	*sys_ck;
 	unsigned	te_connected:1;
 };
 
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 8aa6e47..1230476 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -133,8 +133,7 @@ struct {
 	struct lcd_ctrl_extif	*extif;
 	struct lcd_ctrl		*int_ctrl;
 
-	void			(*power_up)(struct device *dev);
-	void			(*power_down)(struct device *dev);
+	struct clk		*sys_ck;
 } hwa742;
 
 struct lcd_ctrl hwa742_ctrl;
@@ -915,14 +914,13 @@ static void hwa742_suspend(void)
 	hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
 	/* Enable sleep mode */
 	hwa742_write_reg(HWA742_POWER_SAVE, 1 << 1);
-	if (hwa742.power_down != NULL)
-		hwa742.power_down(hwa742.fbdev->dev);
+	clk_disable(hwa742.sys_ck);
 }
 
 static void hwa742_resume(void)
 {
-	if (hwa742.power_up != NULL)
-		hwa742.power_up(hwa742.fbdev->dev);
+	clk_enable(hwa742.sys_ck);
+
 	/* Disable sleep mode */
 	hwa742_write_reg(HWA742_POWER_SAVE, 0);
 	while (1) {
@@ -955,14 +953,13 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	omapfb_conf = fbdev->dev->platform_data;
 	ctrl_conf = omapfb_conf->ctrl_platform_data;
 
-	if (ctrl_conf == NULL || ctrl_conf->get_clock_rate == NULL) {
+	if (ctrl_conf == NULL || ctrl_conf->sys_ck == NULL) {
 		dev_err(fbdev->dev, "HWA742: missing platform data\n");
 		r = -ENOENT;
 		goto err1;
 	}
 
-	hwa742.power_down = ctrl_conf->power_down;
-	hwa742.power_up = ctrl_conf->power_up;
+	hwa742.sys_ck = ctrl_conf->sys_ck;
 
 	spin_lock_init(&hwa742.req_lock);
 
@@ -972,12 +969,11 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	if ((r = hwa742.extif->init(fbdev)) < 0)
 		goto err2;
 
-	ext_clk = ctrl_conf->get_clock_rate(fbdev->dev);
+	ext_clk = clk_get_rate(hwa742.sys_ck);
 	if ((r = calc_extif_timings(ext_clk, &extif_mem_div)) < 0)
 		goto err3;
 	hwa742.extif->set_timings(&hwa742.reg_timings);
-	if (hwa742.power_up != NULL)
-		hwa742.power_up(fbdev->dev);
+	clk_enable(hwa742.sys_ck);
 
 	calc_hwa742_clk_rates(ext_clk, &sys_clk, &pix_clk);
 	if ((r = calc_extif_timings(sys_clk, &extif_mem_div)) < 0)
@@ -1040,8 +1036,7 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 
 	return 0;
 err4:
-	if (hwa742.power_down != NULL)
-		hwa742.power_down(fbdev->dev);
+	clk_disable(hwa742.sys_ck);
 err3:
 	hwa742.extif->cleanup();
 err2:
@@ -1055,8 +1050,7 @@ static void hwa742_cleanup(void)
 	hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
 	hwa742.extif->cleanup();
 	hwa742.int_ctrl->cleanup();
-	if (hwa742.power_down != NULL)
-		hwa742.power_down(hwa742.fbdev->dev);
+	clk_disable(hwa742.sys_ck);
 }
 
 struct lcd_ctrl hwa742_ctrl = {

