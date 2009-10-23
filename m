From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 03/11] OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
Date: Fri, 23 Oct 2009 19:03:47 +0300
Message-ID: <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19346 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZJWQSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:31 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIQ7u027784
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 11:18:35 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPi7022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:29 +0300
In-Reply-To: <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

OMAP GP timers keep running for a few cycles after they are stopped,
which can cause the timer to expire and generate an interrupt. The pending
interrupt will prevent e.g. OMAP from entering suspend, thus we ack it
manually.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 830b072..09a623d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -551,6 +551,16 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+		/* Readback to make sure write has completed */
+		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+		 /*
+		  * Wait for functional clock period x 3.5 to make sure that
+		  * timer is stopped
+		  */
+		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
+		/* Ack possibly pending interrupt */
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
+				OMAP_TIMER_INT_OVERFLOW);
 	}
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
-- 
1.5.4.3

