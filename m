From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/13] OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
Date: Fri,  8 Jan 2010 09:59:19 -0800
Message-ID: <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:51031 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab0AHR7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:36 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so2222956pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:35 -0800 (PST)
In-Reply-To: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

OMAP GP timers keep running for a few cycles after they are stopped,
which can cause the timer to expire and generate an interrupt. The pending
interrupt will prevent e.g. OMAP from entering suspend, thus we ack it
manually.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/dmtimer.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 64f407e..5502ce8 100644
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
1.6.6.rc2.1.g42108

