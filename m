From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] omap: DMTIMER: Ack pending interrupt always when stopping
	a timer
Date: Tue, 08 Jun 2010 15:03:31 +0300
Message-ID: <20100608120331.24902.90256.stgit@baageli.muru.com>
References: <20100608120104.24902.36055.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55552 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0FHMD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 08:03:28 -0400
In-Reply-To: <20100608120104.24902.36055.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

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
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
[tony@atomide.com: removed the ifdef to make the patch cover omap1 also]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c64875f..44bafda 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -541,11 +541,11 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		  * timer is stopped
 		  */
 		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
-		/* Ack possibly pending interrupt */
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
-				OMAP_TIMER_INT_OVERFLOW);
 #endif
 	}
+	/* Ack possibly pending interrupt */
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
+			OMAP_TIMER_INT_OVERFLOW);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 

