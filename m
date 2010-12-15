From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 12/12] OMAP2: dmtimer: set wakeup enable explicitly in plat
Date: Wed, 15 Dec 2010 09:35:10 +0530
Message-ID: <1292385910-5234-13-git-send-email-tarun.kanti@ti.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37486 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab0LNRBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:01:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1gZs008833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:44 -0600
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

For some reason the wakeup enable bit is not getting set on OMAP2430,
OMAP2420. This is inspite of the fact that SYSC_HAS_ENAWAKEUP flag is
present in the hwmod database. Until the reason is found we need this
patch to boot on the above platforms.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4ef25de..2ea0a7b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -227,6 +227,7 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	u32 l;
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
 	timer->fclk = clk_get(&timer->pdev->dev, "fck");
@@ -240,6 +241,18 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	if (cpu_is_omap16xx())
 		pdata->dm_timer_reset(timer);
 
+	/*
+	 * Enable wake-up on OMAP2420, OMAP2430 CPUs.
+	 * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod database.
+	 * But the setting does not seem to work. Need to investigate why
+	 * this is happening.
+	 */
+	if (is_omap2430() || is_omap2420()) {
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+		l |= 1 << 2;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+	}
+
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	/* Match hardware reset default of posted mode */
-- 
1.6.0.4

