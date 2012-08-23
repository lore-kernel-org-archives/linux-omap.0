From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/8] OMAPDSS: HDMI: Move GPIO handling to HDMI driver
Date: Thu, 23 Aug 2012 16:45:07 +0300
Message-ID: <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55883 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758889Ab2HWNpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:35 -0400
Received: by lahl5 with SMTP id l5so437508lah.29
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:33 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

We currently manage HDMI GPIOs in the board files via
platform_enable/disable calls. This won't work with device tree, and in
any case the correct place to manage the GPIOs is in the HDMI driver.

This patch moves the handling of the GPIOs to the HDMI driver. The GPIO
handling is moved to the common hdmi.c file, and this probably needs to
be revisited when adding OMAP5 HDMI support to see if the GPIO handling
needs to be moved to IP specific files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   27 +-----------
 arch/arm/mach-omap2/board-omap4panda.c |   27 +-----------
 drivers/video/omap2/dss/hdmi.c         |   75 +++++++++++++++++++++++---------
 include/video/omapdss.h                |    2 +
 4 files changed, 61 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 8e17284..852e05c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -601,29 +601,6 @@ static void __init omap_sfh7741prox_init(void)
 			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
 }
 
-static struct gpio sdp4430_hdmi_gpios[] = {
-	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
-	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
-	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
-};
-
-static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
-{
-	int status;
-
-	status = gpio_request_array(sdp4430_hdmi_gpios,
-				    ARRAY_SIZE(sdp4430_hdmi_gpios));
-	if (status)
-		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
-
-	return status;
-}
-
-static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
-{
-	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
-}
-
 static struct nokia_dsi_panel_data dsi1_panel = {
 		.name		= "taal",
 		.reset_gpio	= 102,
@@ -718,6 +695,8 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 };
 
 static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
+	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
+	.ls_oe_gpio = HDMI_GPIO_LS_OE,
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
@@ -725,8 +704,6 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.platform_enable = sdp4430_panel_enable_hdmi,
-	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &sdp4430_hdmi_data,
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 982fb26..5415faa 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -405,30 +405,9 @@ static struct omap_dss_device omap4_panda_dvi_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-static struct gpio panda_hdmi_gpios[] = {
-	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
-	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
-	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
-};
-
-static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
-{
-	int status;
-
-	status = gpio_request_array(panda_hdmi_gpios,
-				    ARRAY_SIZE(panda_hdmi_gpios));
-	if (status)
-		pr_err("Cannot request HDMI GPIOs\n");
-
-	return status;
-}
-
-static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
-{
-	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
-}
-
 static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
+	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
+	.ls_oe_gpio = HDMI_GPIO_LS_OE,
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
 
@@ -436,8 +415,6 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.platform_enable = omap4_panda_panel_enable_hdmi,
-	.platform_disable = omap4_panda_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &omap4_panda_hdmi_data,
 };
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0cdf246..4fbe271 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -32,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <video/omapdss.h>
 
 #include "ti_hdmi.h"
@@ -61,6 +62,10 @@ static struct {
 	struct hdmi_ip_data ip_data;
 
 	struct clk *sys_clk;
+
+	int ct_cp_hpd_gpio;
+	int ls_oe_gpio;
+	int hpd_gpio;
 } hdmi;
 
 /*
@@ -314,12 +319,34 @@ static void hdmi_runtime_put(void)
 
 static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 {
+	int r;
+
+	struct gpio gpios[] = {
+		{ hdmi.ct_cp_hpd_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ct_cp_hpd" },
+		{ hdmi.ls_oe_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ls_oe" },
+		{ hdmi.hpd_gpio, GPIOF_DIR_IN, "hdmi_hpd" },
+	};
+
 	DSSDBG("init_display\n");
 
 	dss_init_hdmi_ip_ops(&hdmi.ip_data);
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r)
+		return r;
+
 	return 0;
 }
 
+static void __exit hdmi_uninit_display(struct omap_dss_device *dssdev)
+{
+	DSSDBG("uninit_display\n");
+
+	gpio_free(hdmi.ct_cp_hpd_gpio);
+	gpio_free(hdmi.ls_oe_gpio);
+	gpio_free(hdmi.hpd_gpio);
+}
+
 static const struct hdmi_config *hdmi_find_timing(
 					const struct hdmi_config *timings_arr,
 					int len)
@@ -462,9 +489,12 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	struct omap_video_timings *p;
 	unsigned long phy;
 
+	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
+	gpio_set_value(hdmi.ls_oe_gpio, 1);
+
 	r = hdmi_runtime_get();
 	if (r)
-		return r;
+		goto err_runtime_get;
 
 	dss_mgr_disable(dssdev->manager);
 
@@ -482,7 +512,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	r = hdmi.ip_data.ops->pll_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
-		goto err;
+		goto err_pll_enable;
 	}
 
 	r = hdmi.ip_data.ops->phy_enable(&hdmi.ip_data);
@@ -526,8 +556,11 @@ err_vid_enable:
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 err_phy_enable:
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
-err:
+err_pll_enable:
 	hdmi_runtime_put();
+err_runtime_get:
+	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	gpio_set_value(hdmi.ls_oe_gpio, 0);
 	return -EIO;
 }
 
@@ -539,6 +572,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
+
+	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	gpio_set_value(hdmi.ls_oe_gpio, 0);
 }
 
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
@@ -637,7 +673,6 @@ bool omapdss_hdmi_detect(void)
 
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_hdmi_data *priv = dssdev->data;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
@@ -650,7 +685,7 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	hdmi.ip_data.hpd_gpio = priv->hpd_gpio;
+	hdmi.ip_data.hpd_gpio = hdmi.hpd_gpio;
 
 	r = omap_dss_start_device(dssdev);
 	if (r) {
@@ -658,26 +693,15 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r) {
-			DSSERR("failed to enable GPIO's\n");
-			goto err1;
-		}
-	}
-
 	r = hdmi_power_on(dssdev);
 	if (r) {
 		DSSERR("failed to power on device\n");
-		goto err2;
+		goto err1;
 	}
 
 	mutex_unlock(&hdmi.lock);
 	return 0;
 
-err2:
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
@@ -693,9 +717,6 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 	hdmi_power_off(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	omap_dss_stop_device(dssdev);
 
 	mutex_unlock(&hdmi.lock);
@@ -873,10 +894,15 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
+		struct omap_dss_hdmi_data *priv = dssdev->data;
 
 		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
 			continue;
 
+		hdmi.ct_cp_hpd_gpio = priv->ct_cp_hpd_gpio;
+		hdmi.ls_oe_gpio = priv->ls_oe_gpio;
+		hdmi.hpd_gpio = priv->hpd_gpio;
+
 		r = hdmi_init_display(dssdev);
 		if (r) {
 			DSSERR("device %s init failed: %d\n", dssdev->name, r);
@@ -938,8 +964,17 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __exit hdmi_remove_child(struct device *dev, void *data)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	hdmi_uninit_display(dssdev);
+	return 0;
+}
+
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+	device_for_each_child(&pdev->dev, NULL, hdmi_remove_child);
+
 	omap_dss_unregister_child_devices(&pdev->dev);
 
 	hdmi_panel_exit();
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b868123..c6ffe88 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -605,6 +605,8 @@ struct omap_dss_device {
 
 struct omap_dss_hdmi_data
 {
+	int ct_cp_hpd_gpio;
+	int ls_oe_gpio;
 	int hpd_gpio;
 };
 
-- 
1.7.9.5

