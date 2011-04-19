From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/19] OMAP: DSS2: DSI: wait for TXCLKESC domain to come out of reset
Date: Tue, 19 Apr 2011 12:22:13 +0300
Message-ID: <1303204942-25450-11-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39233 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754432Ab1DSJXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:00 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dsi_cio_wait_tx_clk_esc_reset() function which waits for the
TXCLKESC domains to come out of reset.

Things have worked fine without this, but better be safe than sorry.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   65 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9f450af..8d85635 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1969,6 +1969,65 @@ static void dsi_cio_disable_lane_override(void)
 	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
 }
 
+static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
+{
+	int t;
+	int bits[3];
+	bool in_use[3];
+
+	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
+		bits[0] = 28;
+		bits[1] = 27;
+		bits[2] = 26;
+	} else {
+		bits[0] = 24;
+		bits[1] = 25;
+		bits[2] = 26;
+	}
+
+	in_use[0] = false;
+	in_use[1] = false;
+	in_use[2] = false;
+
+	if (dssdev->phy.dsi.clk_lane != 0)
+		in_use[dssdev->phy.dsi.clk_lane - 1] = true;
+	if (dssdev->phy.dsi.data1_lane != 0)
+		in_use[dssdev->phy.dsi.data1_lane - 1] = true;
+	if (dssdev->phy.dsi.data2_lane != 0)
+		in_use[dssdev->phy.dsi.data2_lane - 1] = true;
+
+	t = 100000;
+	while (true) {
+		u32 l;
+		int i;
+		int ok;
+
+		l = dsi_read_reg(DSI_DSIPHY_CFG5);
+
+		ok = 0;
+		for (i = 0; i < 3; ++i) {
+			if (!in_use[i] || (l & (1 << bits[i])))
+				ok++;
+		}
+
+		if (ok == 3)
+			break;
+
+		if (--t == 0) {
+			for (i = 0; i < 3; ++i) {
+				if (!in_use[i] || (l & (1 << bits[i])))
+					continue;
+
+				DSSERR("CIO TXCLKESC%d domain not coming " \
+						"out of reset\n", i);
+			}
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -2028,6 +2087,10 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_if_enable(false);
 	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
 
+	r = dsi_cio_wait_tx_clk_esc_reset(dssdev);
+	if (r)
+		goto err_tx_clk_esc_rst;
+
 	if (dsi.ulps_enabled) {
 		/* Keep Mark-1 state for 1ms (as per DSI spec) */
 		ktime_t wait = ns_to_ktime(1000 * 1000);
@@ -2050,6 +2113,8 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	return 0;
 
+err_tx_clk_esc_rst:
+	REG_FLD_MOD(DSI_CLK_CTRL, 0, 20, 20); /* LP_CLK_ENABLE */
 err_cio_pwr_dom:
 	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
 err_cio_pwr:
-- 
1.7.1

