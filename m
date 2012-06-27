From: jaswinder.singh@linaro.org
Subject: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Wed, 27 Jun 2012 19:35:44 +0530
Message-ID: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64003 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2F0OF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 10:05:56 -0400
Received: by pbbrp8 with SMTP id rp8so1602874pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 07:05:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org, Jassi Brar <jaswinder.singh@linaro.org>

From: Jassi Brar <jaswinder.singh@linaro.org>

We can easily keep track of latest EDID from the display and hence avoid
expensive EDID re-reads over I2C.
This could also help some cheapo displays that provide EDID reliably only
immediately after asserting HPD and not later.
Even with good displays, there is something in OMAPDSS that apparantly
messes up DDC occasionally while EDID is being read, giving the
  "operation stopped when reading edid" error.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/hdmi.c            |    1 +
 drivers/video/omap2/dss/ti_hdmi.h         |    2 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   15 +++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0738090..9853621 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -758,6 +758,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.core_av_offset = HDMI_CORE_AV;
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
+	hdmi.ip_data.edid_len = 0; /* Invalidate EDID Cache */
 	mutex_init(&hdmi.ip_data.lock);
 
 	hdmi_panel_init();
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index cc292b8..4735860 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -178,6 +178,8 @@ struct hdmi_ip_data {
 	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
 	int hpd_gpio;
 	struct mutex lock;
+	u8 edid_cached[256];
+	unsigned edid_len;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 04acca9..b5c3dc4 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 
 	hpd = gpio_get_value(ip_data->hpd_gpio);
 
-	if (hpd)
+	if (hpd) {
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
-	else
+	} else {
+		/* Invalidate EDID Cache */
+		ip_data->edid_len = 0;
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
+	}
 
 	if (r) {
 		DSSERR("Failed to %s PHY TX power\n",
@@ -454,6 +457,11 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 {
 	int r, l;
 
+	if (ip_data->edid_len) {
+		memcpy(edid, ip_data->edid_cached, ip_data->edid_len);
+		return ip_data->edid_len;
+	}
+
 	if (len < 128)
 		return -EINVAL;
 
@@ -474,6 +482,9 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 		l += 128;
 	}
 
+	ip_data->edid_len = l;
+	memcpy(ip_data->edid_cached, edid, l);
+
 	return l;
 }
 
-- 
1.7.4.1

