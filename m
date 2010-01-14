From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] omap3: pandora: add DSS2 support and related regulators
Date: Thu, 14 Jan 2010 16:05:20 +0200
Message-ID: <1263477920.2087.186.camel@tubuntu.research.nokia.com>
References: <1260559940-25103-1-git-send-email-notasas@gmail.com>
	 <1263394976.2087.106.camel@tubuntu.research.nokia.com>
	 <6ed0b2681001131301v3e295a51g1d3177c51377356f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45384 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab0ANODk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 09:03:40 -0500
In-Reply-To: <6ed0b2681001131301v3e295a51g1d3177c51377356f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-01-13 at 22:01 +0100, ext Grazvydas Ignotas wrote:
> On Wed, Jan 13, 2010 at 5:02 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > This doesn't apply, can you resend based on Linus' tree or my DSS2 tree?
> 
> ok, will resend shortly.
> 
> BTW, what about enabling vdds_dsi/vdds_sdi regulators we talked about
> earlier? This patch already sets up those regulators in the board file
> for DSS2 to get and enable them. I can come up with a patch for that
> if you want (perhaps doing it somewhere in dss_init()).

It would be nice to get this clarified from TI's HW side, but I haven't
had time to do that.

However, it sure looks like your theory is correct, so a patch would be
ok.

I don't think dss_init is a proper place for it. The power only needs to
be enabled when the display is on, so perhaps
dpi_display_enable/disable() would be better place to turn it on and off
(and suspend/resume). Below is a quick patch I made to test this.

But is the same code needed by RFBI and SDI also? And is it needed only
when certain pins are in use? And only on OMAP3. I'm not sure what would
be the most elegant way for this, but perhaps for now it's good enough
if we enable the power in dpi.c's enable/disable.

 Tomi



>From 839626c3cb47ab209876fe6a67606529a770dd53 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 14 Jan 2010 15:57:06 +0200
Subject: [PATCH] test for vdds_sdi

---
 arch/arm/mach-omap2/board-3430sdp.c                |    4 --
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   35 ------------
 drivers/video/omap2/dss/core.c                     |    2 +-
 drivers/video/omap2/dss/dpi.c                      |   58
+++++++++++++++++---
 drivers/video/omap2/dss/dss.h                      |    2 +-
 5 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..964c390 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -520,10 +520,6 @@ static struct regulator_init_data sdp3430_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	{
-		.supply		= "vdvi",
-		.dev		= &sdp3430_lcd_device.dev,
-	},
-	{
 		.supply		= "vdds_dsi",
 		.dev		= &sdp3430_dss_device.dev,
 	}
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index bbe880b..e207d66 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -25,14 +25,6 @@
 
 #include <plat/display.h>
 
-struct sharp_data {
-	/* XXX This regulator should actually be in SDP board file, not here,
-	 * as it doesn't actually power the LCD, but something else that
-	 * affects the output to LCD (I think. Somebody clarify). It doesn't
do
-	 * harm here, as SDP is the only board using this currently */
-	struct regulator *vdvi_reg;
-};
-
 static struct omap_video_timings sharp_ls_timings = {
 	.x_res = 480,
 	.y_res = 640,
@@ -50,48 +42,25 @@ static struct omap_video_timings sharp_ls_timings =
{
 
 static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd;
-
 	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
 		OMAP_DSS_LCD_IHS;
 	dssdev->panel.acb = 0x28;
 	dssdev->panel.timings = sharp_ls_timings;
 
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
-
-	dev_set_drvdata(&dssdev->dev, sd);
-
-	sd->vdvi_reg = regulator_get(&dssdev->dev, "vdvi");
-	if (IS_ERR(sd->vdvi_reg)) {
-		kfree(sd);
-		pr_err("failed to get VDVI regulator\n");
-		return PTR_ERR(sd->vdvi_reg);
-	}
-
 	return 0;
 }
 
 static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-
-	regulator_put(sd->vdvi_reg);
-
-	kfree(sd);
 }
 
 static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
 	int r = 0;
 
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	regulator_enable(sd->vdvi_reg);
-
 	if (dssdev->platform_enable)
 		r = dssdev->platform_enable(dssdev);
 
@@ -100,13 +69,9 @@ static int sharp_ls_panel_enable(struct
omap_dss_device *dssdev)
 
 static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-	regulator_disable(sd->vdvi_reg);
-
 	/* wait at least 5 vsyncs after disabling the LCD */
 
 	msleep(100);
diff --git a/drivers/video/omap2/dss/core.c
b/drivers/video/omap2/dss/core.c
index 82918ee..9fd37c1 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -473,7 +473,7 @@ static int omap_dss_probe(struct platform_device
*pdev)
 	}
 #endif
 
-	r = dpi_init();
+	r = dpi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
 		goto fail0;
diff --git a/drivers/video/omap2/dss/dpi.c
b/drivers/video/omap2/dss/dpi.c
index 2d71031..eb00073 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -25,7 +25,10 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include <plat/display.h>
 #include <plat/cpu.h>
@@ -34,6 +37,7 @@
 
 static struct {
 	int update_enabled;
+	struct regulator *vdds_dsi_reg;
 } dpi;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
@@ -166,21 +170,28 @@ static int dpi_display_enable(struct
omap_dss_device *dssdev)
 		goto err1;
 	}
 
+	if (cpu_is_omap34xx()) {
+		r = regulator_enable(dpi.vdds_dsi_reg);
+		if (r) {
+			goto err2;
+		}
+	}
+
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
 	r = dpi_basic_init(dssdev);
 	if (r)
-		goto err2;
+		goto err3;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dss_clk_enable(DSS_CLK_FCK2);
 	r = dsi_pll_init(dssdev, 0, 1);
 	if (r)
-		goto err3;
+		goto err4;
 #endif
 	r = dpi_set_mode(dssdev);
 	if (r)
-		goto err4;
+		goto err5;
 
 	mdelay(2);
 
@@ -188,22 +199,25 @@ static int dpi_display_enable(struct
omap_dss_device *dssdev)
 
 	r = dssdev->driver->enable(dssdev);
 	if (r)
-		goto err5;
+		goto err6;
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	return 0;
 
-err5:
+err6:
 	dispc_enable_lcd_out(0);
-err4:
+err5:
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dsi_pll_uninit();
-err3:
+err4:
 	dss_clk_disable(DSS_CLK_FCK2);
 #endif
-err2:
+err3:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+err2:
+	if (cpu_is_omap34xx())
+		regulator_disable(dpi.vdds_dsi_reg);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
@@ -232,6 +246,9 @@ static void dpi_display_disable(struct
omap_dss_device *dssdev)
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
+	if (cpu_is_omap34xx())
+		regulator_disable(dpi.vdds_dsi_reg);
+
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	omap_dss_stop_device(dssdev);
@@ -251,6 +268,9 @@ static int dpi_display_suspend(struct
omap_dss_device *dssdev)
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
+	if (cpu_is_omap34xx())
+		regulator_disable(dpi.vdds_dsi_reg);
+
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
 	return 0;
@@ -258,11 +278,19 @@ static int dpi_display_suspend(struct
omap_dss_device *dssdev)
 
 static int dpi_display_resume(struct omap_dss_device *dssdev)
 {
+	int r;
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
 		return -EINVAL;
 
 	DSSDBG("dpi_display_resume\n");
 
+	if (cpu_is_omap34xx()) {
+		r = regulator_enable(dpi.vdds_dsi_reg);
+		if (r)
+			goto err0;
+	}
+
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
 	dispc_enable_lcd_out(1);
@@ -273,6 +301,8 @@ static int dpi_display_resume(struct omap_dss_device
*dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	return 0;
+err0:
+	return r;
 }
 
 static void dpi_set_timings(struct omap_dss_device *dssdev,
@@ -388,12 +418,22 @@ int dpi_init_display(struct omap_dss_device
*dssdev)
 	return 0;
 }
 
-int dpi_init(void)
+int dpi_init(struct platform_device *pdev)
 {
+	if (cpu_is_omap34xx()) {
+		dpi.vdds_dsi_reg = regulator_get(&pdev->dev, "vdds_dsi");
+		if (IS_ERR(dpi.vdds_dsi_reg)) {
+			DSSERR("can't get VDDS_DSI regulator\n");
+			return PTR_ERR(dpi.vdds_dsi_reg);
+		}
+	}
+
 	return 0;
 }
 
 void dpi_exit(void)
 {
+	if (cpu_is_omap34xx())
+		regulator_put(dpi.vdds_dsi_reg);
 }
 
diff --git a/drivers/video/omap2/dss/dss.h
b/drivers/video/omap2/dss/dss.h
index 2bcb124..c13795d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -261,7 +261,7 @@ void dsi_get_overlay_fifo_thresholds(enum omap_plane
plane,
 		u32 *fifo_low, u32 *fifo_high);
 
 /* DPI */
-int dpi_init(void);
+int dpi_init(struct platform_device *pdev);
 void dpi_exit(void);
 int dpi_init_display(struct omap_dss_device *dssdev);
 
-- 
1.6.5



