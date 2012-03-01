From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/7] OMAPDSS: HDMI: PHY burnout fix
Date: Thu,  1 Mar 2012 14:34:46 +0200
Message-ID: <1330605286-24166-8-git-send-email-tomi.valkeinen@ti.com>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51334 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759150Ab2CAMfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:35:17 -0500
Received: by bkcjc3 with SMTP id jc3so795553bkc.27
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:35:11 -0800 (PST)
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

A hardware bug in the OMAP4 HDMI PHY may cause physical damage to the
board if the HDMI PHY is already enabled when the HDMI cable is plugged
in. The possible damage breaks HDMI output, otherwise the board is
unaffected.

This patch solves the problem by adding hot-plug-detection into the HDMI
IP driver. This is not a real HPD support in the sense that nobody else
than the IP driver gets to know about the HPD events, but is only meant
to fix the HW bug.

The strategy is simple: If the display device is turned off by the user,
the PHY power is set to OFF. When the display device is turned on by the
user, the PHY power is set either to LDOON or TXON, depending on whether
the HDMI cable is connected.

The reason to avoid PHY OFF when the display device is on, but the cable
is disconnected, is that when the PHY is turned OFF, the HDMI IP is not
"ticking" and thus the DISPC does not receive pixel clock from the HDMI
IP. This would, for example, prevent any VSYNCs from happening, and
would thus affect the users of omapdss. By using LDOON when the cable is
disconnected we'll avoid the HW bug, but keep the HDMI working as usual
from the user's point of view.

Backported from c49d005b6cc8491fad5b24f82805be2d6bcbd3dd

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    5 ++
 arch/arm/mach-omap2/board-omap4panda.c |    5 ++
 drivers/video/omap2/dss/hdmi.c         |   71 ++++++++++++++++++++++++++++++--
 include/video/omapdss.h                |    5 ++
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0ee578a..14a5971 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -610,6 +610,10 @@ static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
 }
 
+static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
+	.hpd_gpio = HDMI_GPIO_HPD,
+};
+
 static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
@@ -617,6 +621,7 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.platform_enable = sdp4430_panel_enable_hdmi,
 	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
+	.data = &sdp4430_hdmi_data,
 };
 
 static struct omap_dss_device *sdp4430_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 2b3f7e0..107dfc3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -646,6 +646,10 @@ static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
 	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
 }
 
+static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
+	.hpd_gpio = HDMI_GPIO_HPD,
+};
+
 static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
@@ -653,6 +657,7 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.platform_enable = omap4_panda_panel_enable_hdmi,
 	.platform_disable = omap4_panda_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
+	.data = &omap4_panda_hdmi_data,
 };
 
 static struct omap_dss_device *omap4_panda_dss_devices[] = {
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index f3369cf..fadd6a0 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -29,6 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/string.h>
+#include <linux/gpio.h>
 #include <video/omapdss.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
@@ -54,6 +55,9 @@ static struct {
 	u8 edid_set;
 	bool custom_set;
 	struct hdmi_config cfg;
+
+	int hpd_gpio;
+	bool phy_tx_enabled;
 } hdmi;
 
 /*
@@ -278,6 +282,47 @@ static int hdmi_pll_reset(void)
 	return 0;
 }
 
+static int hdmi_check_hpd_state(void)
+{
+	unsigned long flags;
+	bool hpd;
+	int r;
+	/* this should be in ti_hdmi_4xxx_ip private data */
+	static DEFINE_SPINLOCK(phy_tx_lock);
+
+	spin_lock_irqsave(&phy_tx_lock, flags);
+
+	hpd = gpio_get_value(hdmi.hpd_gpio);
+
+	if (hpd == hdmi.phy_tx_enabled) {
+		spin_unlock_irqrestore(&phy_tx_lock, flags);
+		return 0;
+	}
+
+	if (hpd)
+		r = hdmi_set_phy_pwr(HDMI_PHYPWRCMD_TXON);
+	else
+		r = hdmi_set_phy_pwr(HDMI_PHYPWRCMD_LDOON);
+
+	if (r) {
+		DSSERR("Failed to %s PHY TX power\n",
+				hpd ? "enable" : "disable");
+		goto err;
+	}
+
+	hdmi.phy_tx_enabled = hpd;
+err:
+	spin_unlock_irqrestore(&phy_tx_lock, flags);
+	return r;
+}
+
+static irqreturn_t hpd_irq_handler(int irq, void *data)
+{
+	hdmi_check_hpd_state();
+
+	return IRQ_HANDLED;
+}
+
 static int hdmi_phy_init(void)
 {
 	u16 r = 0;
@@ -286,10 +331,6 @@ static int hdmi_phy_init(void)
 	if (r)
 		return r;
 
-	r = hdmi_set_phy_pwr(HDMI_PHYPWRCMD_TXON);
-	if (r)
-		return r;
-
 	/*
 	 * Read address 0 in order to get the SCP reset done completed
 	 * Dummy access performed to make sure reset is done
@@ -311,6 +352,23 @@ static int hdmi_phy_init(void)
 	/* Write to phy address 3 to change the polarity control */
 	REG_FLD_MOD(HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
 
+	r = request_threaded_irq(gpio_to_irq(hdmi.hpd_gpio),
+			NULL, hpd_irq_handler,
+			IRQF_DISABLED | IRQF_TRIGGER_RISING |
+			IRQF_TRIGGER_FALLING, "hpd", NULL);
+	if (r) {
+		DSSERR("HPD IRQ request failed\n");
+		hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
+		return r;
+	}
+
+	r = hdmi_check_hpd_state();
+	if (r) {
+		free_irq(gpio_to_irq(hdmi.hpd_gpio), NULL);
+		hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
+		return r;
+	}
+
 	return 0;
 }
 
@@ -361,7 +419,9 @@ static int hdmi_pll_program(struct hdmi_pll_info *fmt)
 
 static void hdmi_phy_off(void)
 {
+	free_irq(gpio_to_irq(hdmi.hpd_gpio), NULL);
 	hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
+	hdmi.phy_tx_enabled = false;
 }
 
 static int hdmi_core_ddc_edid(u8 *pedid, int ext)
@@ -1236,12 +1296,15 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_hdmi_data *priv = dssdev->data;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
 
 	mutex_lock(&hdmi.lock);
 
+	hdmi.hpd_gpio = priv->hpd_gpio;
+
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 892b97f..c0d8014 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -514,6 +514,11 @@ struct omap_dss_device {
 	int (*get_backlight)(struct omap_dss_device *dssdev);
 };
 
+struct omap_dss_hdmi_data
+{
+	int hpd_gpio;
+};
+
 struct omap_dss_driver {
 	struct device_driver driver;
 
-- 
1.7.4.1

