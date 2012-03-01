From: <mythripk@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in TX_ON
Date: Thu, 1 Mar 2012 13:44:24 +0530
Message-ID: <1330589664-15755-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37020 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758180Ab2CAIVa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 03:21:30 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q218LSq1027880
	for <linux-omap@vger.kernel.org>; Thu, 1 Mar 2012 02:21:29 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q218LREo001056
	for <linux-omap@vger.kernel.org>; Thu, 1 Mar 2012 13:51:27 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Currently TX_PHY is put to TX_ON(transmission state) on receiving HPD.
It just ensures that the TV is connected but does not guarantee
that TMDS data lines and clock lines are up and ready for transmission.
Which although is very rare scenario has a potential to  damage the HDMI
port.(A use case where TV is connected to board but it is in different
channel would still trigger a HPD but TMDS lines will be down).

Thus this patch adds a rxdet check on getting a HPD which ensures that
TMDS lines are UP before changing the PHY state from LDO_ON to TX_ON.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   37 +++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index bb784d2..bc55528 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -224,6 +224,30 @@ void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data)
 	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 }
 
+int hdmi_ti_4xxx_rxdet(struct hdmi_ip_data *ip_data)
+{
+	int loop = 0, tmds_data0, tmds_data1, tmds_data2, tmds_clk;
+
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_WP_DEBUG_CFG, 4);
+
+	do {
+		tmds_data0 = hdmi_read_reg(hdmi_wp_base(ip_data),
+					HDMI_WP_WP_DEBUG_DATA);
+		tmds_data1 = hdmi_read_reg(hdmi_wp_base(ip_data),
+					HDMI_WP_WP_DEBUG_DATA);
+		tmds_data2 = hdmi_read_reg(hdmi_wp_base(ip_data),
+					HDMI_WP_WP_DEBUG_DATA);
+		tmds_clk = hdmi_read_reg(hdmi_wp_base(ip_data),
+					HDMI_WP_WP_DEBUG_DATA);
+		udelay(15);
+	} while ((tmds_data0 != tmds_data1 || tmds_data1 != tmds_data2
+			|| tmds_data1 != tmds_clk) && (loop < 500));
+
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_WP_DEBUG_CFG, 0);
+
+	return ((loop == 500) ? -1 : (tmds_data0 & 1)) ;
+}
+
 static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 {
 	unsigned long flags;
@@ -241,10 +265,19 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 		return 0;
 	}
 
-	if (hpd)
+	if (hpd) {
+		/* before putting the phy in TX_ON,ensure that TMDS lanes
+		 * are pulled up .
+		 */
+		r = hdmi_ti_4xxx_rxdet(ip_data);
+		if (r <= 0) {
+			DSSERR("rxdet not set\n");
+			return r;
+		}
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
-	else
+	} else {
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
+	}
 
 	if (r) {
 		DSSERR("Failed to %s PHY TX power\n",
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index a14d1a0..efa6f29 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -47,6 +47,8 @@
 #define HDMI_WP_AUDIO_CFG2			0x84
 #define HDMI_WP_AUDIO_CTRL			0x88
 #define HDMI_WP_AUDIO_DATA			0x8C
+#define HDMI_WP_WP_DEBUG_CFG			0x90
+#define HDMI_WP_WP_DEBUG_DATA			0x94
 
 /* HDMI IP Core System */
 
-- 
1.7.5.4

