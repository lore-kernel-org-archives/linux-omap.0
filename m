From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/22] OMAPDSS: DSI: remove pll_locked field
Date: Wed, 12 Nov 2014 13:52:08 +0200
Message-ID: <1415793144-11723-7-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbaKLLwx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:53 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have pll_locked field in struct dsi_data, but it doesn't have any
meaningful use anymore, and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index deab4135ddc0..37517e407f37 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -329,8 +329,6 @@ struct dsi_data {
 	struct mutex lock;
 	struct semaphore bus_lock;
 
-	unsigned pll_locked;
-
 	spinlock_t irq_lock;
 	struct dsi_isr_tables isr_tables;
 	/* space for a copy used by the interrupt handler */
@@ -1206,11 +1204,6 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 		clk_prepare_enable(dsi->sys_clk);
 	else
 		clk_disable_unprepare(dsi->sys_clk);
-
-	if (enable && dsi->pll_locked) {
-		if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1)
-			DSSERR("cannot lock PLL when enabling clocks\n");
-	}
 }
 
 static void _dsi_print_reset_status(struct platform_device *dsidev)
@@ -1647,8 +1640,6 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		goto err;
 	}
 
-	dsi->pll_locked = 1;
-
 	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
 	l = FLD_MOD(l, 0, 0, 0);	/* DSI_PLL_IDLE */
 	l = FLD_MOD(l, 0, 5, 5);	/* DSI_PLL_PLLLPMODE */
@@ -1739,7 +1730,6 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	dsi->pll_locked = 0;
 	dsi_pll_power(dsidev, DSI_PLL_POWER_OFF);
 	if (disconnect_lanes) {
 		WARN_ON(!dsi->vdds_dsi_enabled);
-- 
2.1.3

