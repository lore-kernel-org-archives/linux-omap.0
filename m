From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] omap: dmtimer: Enable autoidle
Date: Mon, 14 Feb 2011 19:26:15 +0200
Message-ID: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:35756 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab1BNQXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 11:23:49 -0500
Received: from sokoban.nmp.nokia.com (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id p1EGNlk8022321
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 18:23:47 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This will save some power.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1d706cf..949becc 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -341,6 +341,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
 	l |= 0x02 << 3;  /* Set to smart-idle mode */
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
+	l |= 0x1 << 0;   /* Set autoidle */
 
 	/*
 	 * Enable wake-up on OMAP2 CPUs.
-- 
1.7.1

