From: jaswinder.singh@linaro.org
Subject: [PATCH] OMAPDSS: HDMI: Replace spinlock with mutex in hdmi_check_hpd_state
Date: Sat, 23 Jun 2012 13:37:18 +0530
Message-ID: <1340438838-25692-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39169 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab2FWIH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jun 2012 04:07:27 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3270238dad.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Jun 2012 01:07:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, Jassi Brar <jaswinder.singh@linaro.org>

From: Jassi Brar <jaswinder.singh@linaro.org>

State change of HDMI PHY could potentially take many millisecs, we can do
better by protecting things in hdmi_set_phy_pwr() with a mutex rather than
a spin_lock_irqsave.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/hdmi.c            |    1 +
 drivers/video/omap2/dss/ti_hdmi.h         |    1 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 ++----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8195c71..0738090 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -758,6 +758,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.core_av_offset = HDMI_CORE_AV;
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
+	mutex_init(&hdmi.ip_data.lock);
 
 	hdmi_panel_init();
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index d174ca1..cc292b8 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -177,6 +177,7 @@ struct hdmi_ip_data {
 
 	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
 	int hpd_gpio;
+	struct mutex lock;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 3fa3d98..04acca9 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -238,10 +238,8 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 	unsigned long flags;
 	bool hpd;
 	int r;
-	/* this should be in ti_hdmi_4xxx_ip private data */
-	static DEFINE_SPINLOCK(phy_tx_lock);
 
-	spin_lock_irqsave(&phy_tx_lock, flags);
+	mutex_lock(&ip_data->lock);
 
 	hpd = gpio_get_value(ip_data->hpd_gpio);
 
@@ -257,7 +255,7 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 	}
 
 err:
-	spin_unlock_irqrestore(&phy_tx_lock, flags);
+	mutex_unlock(&ip_data->lock);
 	return r;
 }
 
-- 
1.7.4.1

