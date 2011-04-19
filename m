From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/19] OMAP: DSS2: DSI: fix _dsi_print_reset_status
Date: Tue, 19 Apr 2011 12:22:10 +0300
Message-ID: <1303204942-25450-8-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58488 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab1DSJWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:49 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The bits for TXCLKESCx reset have changed for OMAP3630 and OMAP4.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 61d9f3c..a6b6ca6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -960,6 +960,7 @@ static inline void dsi_enable_pll_clock(bool enable)
 static void _dsi_print_reset_status(void)
 {
 	u32 l;
+	int b0, b1, b2;
 
 	if (!dss_debug)
 		return;
@@ -977,9 +978,21 @@ static void _dsi_print_reset_status(void)
 	l = dsi_read_reg(DSI_COMPLEXIO_CFG1);
 	printk("CIO (%d) ", FLD_GET(l, 29, 29));
 
+	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
+		b0 = 28;
+		b1 = 27;
+		b2 = 26;
+	} else {
+		b0 = 24;
+		b1 = 25;
+		b2 = 26;
+	}
+
 	l = dsi_read_reg(DSI_DSIPHY_CFG5);
-	printk("PHY (%x, %d, %d, %d)\n",
-			FLD_GET(l, 28, 26),
+	printk("PHY (%x%x%x, %d, %d, %d)\n",
+			FLD_GET(l, b0, b0),
+			FLD_GET(l, b1, b1),
+			FLD_GET(l, b2, b2),
 			FLD_GET(l, 29, 29),
 			FLD_GET(l, 30, 30),
 			FLD_GET(l, 31, 31));
-- 
1.7.1

