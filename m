From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/8] OMAPDSS: HDMI: use vdda_hdmi_dac
Date: Thu, 23 Aug 2012 16:45:10 +0300
Message-ID: <1345729514-2441-5-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55476 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933047Ab2HWNpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:41 -0400
Received: by lagu2 with SMTP id u2so419617lag.36
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:38 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The HDMI driver requires vdda_hdmi_dac power for operation, but does not
enable it. This has worked because the regulator has been always
enabled.

But this may not always be the case, as I encountered when implementing
HDMI device tree support.

This patch changes the HDMI driver to use the vdda_hdmi_dac.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 96a6e29..ccfc677 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
 #include "ti_hdmi.h"
@@ -62,6 +63,7 @@ static struct {
 	struct hdmi_ip_data ip_data;
 
 	struct clk *sys_clk;
+	struct regulator *vdda_hdmi_dac_reg;
 
 	int ct_cp_hpd_gpio;
 	int ls_oe_gpio;
@@ -331,6 +333,19 @@ static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 
 	dss_init_hdmi_ip_ops(&hdmi.ip_data);
 
+	if (hdmi.vdda_hdmi_dac_reg == NULL) {
+		struct regulator *reg;
+
+		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
+
+		if (IS_ERR(reg)) {
+			DSSERR("can't get VDDA_HDMI_DAC regulator\n");
+			return PTR_ERR(reg);
+		}
+
+		hdmi.vdda_hdmi_dac_reg = reg;
+	}
+
 	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
 	if (r)
 		return r;
@@ -495,6 +510,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	/* wait 300us after CT_CP_HPD for the 5V power output to reach 90% */
 	udelay(300);
 
+	r = regulator_enable(hdmi.vdda_hdmi_dac_reg);
+	if (r)
+		goto err_vdac_enable;
+
 	r = hdmi_runtime_get();
 	if (r)
 		goto err_runtime_get;
@@ -562,6 +581,8 @@ err_phy_enable:
 err_pll_enable:
 	hdmi_runtime_put();
 err_runtime_get:
+	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+err_vdac_enable:
 	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
 	gpio_set_value(hdmi.ls_oe_gpio, 0);
 	return -EIO;
@@ -576,6 +597,8 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 	hdmi_runtime_put();
 
+	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+
 	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
 	gpio_set_value(hdmi.ls_oe_gpio, 0);
 }
-- 
1.7.9.5

