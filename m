From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 15/17] dmtimer: OMAP4 specific change in plat-omap
Date: Tue, 21 Sep 2010 14:26:02 +0530
Message-ID: <1285059362-26668-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48524 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187Ab0ITVzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:55:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch updates the plat-omap dmtimer code to support
OMAP4 specific feature.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9da527f..4f735d7 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -252,9 +252,19 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u8 reg,
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
+	u32 reg;
+	int reset_is_active;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		reg = OMAP_TIMER_OCP_CFG_REG;
+		reset_is_active = 1;
+	} else {
+		reg = OMAP_TIMER_SYS_STAT_REG;
+		reset_is_active = 0;
+	}
 	c = 0;
-	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
+	while (omap_dm_timer_read_reg(timer, reg) == reset_is_active) {
 		c++;
 		if (c > 100000) {
 			printk(KERN_ERR "Timer failed to reset\n");
-- 
1.6.0.4

