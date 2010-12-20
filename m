From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly in plat
Date: Tue, 21 Dec 2010 03:35:19 +0530
Message-ID: <1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
References: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57846 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442Ab0LTLCA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 06:02:00 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBKB1vUP009977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 05:01:59 -0600
In-Reply-To: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

For some reason the wakeup enable bit is not getting set on OMAP2430,
OMAP2420. This is inspite of the fact that SYSC_HAS_ENAWAKEUP flag is
present in the hwmod database.

I am not sure if there is already a patch to fix this problem. Until the
reason is found we need this patch to boot on the above platforms.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f4aa4a1..007b754 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -227,6 +227,7 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	u32 l;
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
 	if (!pdata->is_omap16xx) {
@@ -243,6 +244,18 @@ static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	if (pdata->dm_timer_reset)
 		pdata->dm_timer_reset(timer);
 
+	/*
+	 * Enable wake-up on OMAP2420, OMAP2430 CPUs.
+	 * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod database.
+	 * But the setting does not seem to work. Need to investigate why
+	 * this is happening.
+	 */
+	if (cpu_is_omap2430() || cpu_is_omap2420()) {
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+		l |= 1 << 2;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+	}
+
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	/* Match hardware reset default of posted mode */
-- 
1.6.0.4

