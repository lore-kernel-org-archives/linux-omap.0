From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 13/15] OMAP: DSS2: Make check-delay-loops consistent
Date: Fri,  8 Jan 2010 15:22:47 +0200
Message-ID: <1262956969-1664-14-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-13-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57058 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab0AHNWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:32 -0500
In-Reply-To: <1262956969-1664-13-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Loops checking for certain condition were rather inconsistent.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Reported-by: Juha Leppanen <juha_motorsportcom@luukku.com>
---
 drivers/video/omap2/dss/dsi.c |   14 +++++++-------
 drivers/video/omap2/dss/dss.c |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2881d93..d964869 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -828,12 +828,12 @@ static int dsi_pll_power(enum dsi_pll_power_state state)
 
 	/* PLL_PWR_STATUS */
 	while (FLD_GET(dsi_read_reg(DSI_CLK_CTRL), 29, 28) != state) {
-		udelay(1);
-		if (t++ > 1000) {
+		if (++t > 1000) {
 			DSSERR("Failed to set DSI PLL power mode to %d\n",
 					state);
 			return -ENODEV;
 		}
+		udelay(1);
 	}
 
 	return 0;
@@ -1441,12 +1441,12 @@ static int dsi_complexio_power(enum dsi_complexio_power_state state)
 
 	/* PWR_STATUS */
 	while (FLD_GET(dsi_read_reg(DSI_COMPLEXIO_CFG1), 26, 25) != state) {
-		udelay(1);
-		if (t++ > 1000) {
+		if (++t > 1000) {
 			DSSERR("failed to set complexio power state to "
 					"%d\n", state);
 			return -ENODEV;
 		}
+		udelay(1);
 	}
 
 	return 0;
@@ -1646,10 +1646,10 @@ static void dsi_complexio_uninit(void)
 
 static int _dsi_wait_reset(void)
 {
-	int i = 0;
+	int t = 0;
 
 	while (REG_GET(DSI_SYSSTATUS, 0, 0) == 0) {
-		if (i++ > 5) {
+		if (++t > 5) {
 			DSSERR("soft reset failed\n");
 			return -ENODEV;
 		}
@@ -2707,7 +2707,6 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 		/* using fifo not empty */
 		/* TX_FIFO_NOT_EMPTY */
 		while (FLD_GET(dsi_read_reg(DSI_VC_CTRL(0)), 5, 5)) {
-			udelay(1);
 			fifo_stalls++;
 			if (fifo_stalls > 0xfffff) {
 				DSSERR("fifo stalls overflow, pixels left %d\n",
@@ -2715,6 +2714,7 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 				dsi_if_enable(0);
 				return -EIO;
 			}
+			udelay(1);
 		}
 #elif 1
 		/* using fifo emptiness */
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 9b05ee6..0a26b7d 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -467,14 +467,14 @@ static irqreturn_t dss_irq_handler_omap3(int irq, void *arg)
 
 static int _omap_dss_wait_reset(void)
 {
-	unsigned timeout = 1000;
+	int t = 0;
 
 	while (REG_GET(DSS_SYSSTATUS, 0, 0) == 0) {
-		udelay(1);
-		if (!--timeout) {
+		if (++t > 1000) {
 			DSSERR("soft reset failed\n");
 			return -ENODEV;
 		}
+		udelay(1);
 	}
 
 	return 0;
-- 
1.6.5

