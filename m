From: jaswinder.singh@linaro.org
Subject: [PATCH 1/3] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Wed, 27 Jun 2012 19:34:36 +0530
Message-ID: <1340805876-28696-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58344 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab2F0OEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 10:04:49 -0400
Received: by pbbrp8 with SMTP id rp8so1601621pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 07:04:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org, Jassi Brar <jaswinder.singh@linaro.org>

From: Jassi Brar <jaswinder.singh@linaro.org>

It is simpler to read the current status from a register as compared
to maintaining a state variable to hold the information.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    1 -
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index e734cb4..d174ca1 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -177,7 +177,6 @@ struct hdmi_ip_data {
 
 	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
 	int hpd_gpio;
-	bool phy_tx_enabled;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 4dae1b2..3fa3d98 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -157,6 +157,10 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data)
 /* PHY_PWR_CMD */
 static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
 {
+	/* Return if already the state */
+	if (REG_GET(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, 5, 4) == val)
+		return 0;
+
 	/* Command for power control of HDMI PHY */
 	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 7, 6);
 
@@ -241,11 +245,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 
 	hpd = gpio_get_value(ip_data->hpd_gpio);
 
-	if (hpd == ip_data->phy_tx_enabled) {
-		spin_unlock_irqrestore(&phy_tx_lock, flags);
-		return 0;
-	}
-
 	if (hpd)
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
 	else
@@ -257,7 +256,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 		goto err;
 	}
 
-	ip_data->phy_tx_enabled = hpd;
 err:
 	spin_unlock_irqrestore(&phy_tx_lock, flags);
 	return r;
@@ -327,7 +325,6 @@ void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 	free_irq(gpio_to_irq(ip_data->hpd_gpio), ip_data);
 
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
-	ip_data->phy_tx_enabled = false;
 }
 
 static int hdmi_core_ddc_init(struct hdmi_ip_data *ip_data)
-- 
1.7.4.1

