From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP: DMTIMER: Ack pending interrupt always when stopping a timer
Date: Tue, 25 May 2010 17:17:16 +0300
Message-ID: <1274797036-21107-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28387 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab0EYMlt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 08:41:49 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o4PCfcGf000541
	for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 07:41:48 -0500
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o4PCfhJr004974
	for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 15:41:43 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

The kernel timer queue is being run currently from a GP timer running in a one
shot mode, which works in a way that when it expires, it will also stop.
Usually during this situation, the interrupt handler will ack the interrupt,
load a new value to the timer and start it again. During suspend, the
situation is slightly different, as we disable interrupts just before
timekeeping is suspended, which leaves a small window where the timer can
expire before it is stopped, and will leave the interrupt flag pending.
This pending interrupt will prevent ARM sleep entry, thus now we ack it always
when we are attempting to stop a timer.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c64875f..023d664 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -541,11 +541,13 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		  * timer is stopped
 		  */
 		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
-		/* Ack possibly pending interrupt */
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
-				OMAP_TIMER_INT_OVERFLOW);
 #endif
 	}
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	/* Ack possibly pending interrupt */
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
+			OMAP_TIMER_INT_OVERFLOW);
+#endif
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
-- 
1.5.4.3

