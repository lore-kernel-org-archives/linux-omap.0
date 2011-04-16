From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and clockevent timers reserved
Date: Sat, 16 Apr 2011 21:21:02 +0530
Message-ID: <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891Ab1DPPu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Apr 2011 11:50:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3GFoNXw013832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 10:50:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p3GFoM3d026805
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 21:20:22 +0530 (IST)
In-Reply-To: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

In driver probe use sys_timer_reserved to identify which all timers
have already been used for clocksource and clockevent. Mark all those
timers as reserved so that no one else can use them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e15b3a8..8b6fd22 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -554,7 +554,13 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->id = pdev->id;
 	timer->irq = irq->start;
 	timer->pdev = pdev;
-	timer->reserved = 0;
+#if defined(CONFIG_ARCH_OMAP2)
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+		timer->reserved = 1;
+	else
+#endif
+		timer->reserved = 0;
 
 	 /* Skip pm_runtime_enable for OMAP1 */
 	if (!pdata->needs_manual_reset)
-- 
1.6.0.4

