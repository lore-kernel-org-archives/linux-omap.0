From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 10/13] ARM: OMAP: Fix spurious interrupts when using timer match feature
Date: Mon, 12 Nov 2012 12:20:41 -0600
Message-ID: <1352744444-2633-11-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56640 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2KLSVI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 13:21:08 -0500
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP DMTIMERs can generate an interrupt when the timer counter value
matches the value stored in the timer's match register. When using this
feature spurious interrupts were seen, because the compare logic is being
enabled before the match value is loaded and according to the documentation
the match value must be loaded before the compare logic is enable.

The reset value for the timer counter and match registers is 0 and hence,
by enabling the compare logic before the actual match value is loaded a
spurious interrupt can be generated as the reset values match.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f0a3c4c..a38e896 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -584,8 +584,8 @@ int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 		l |= OMAP_TIMER_CTRL_CE;
 	else
 		l &= ~OMAP_TIMER_CTRL_CE;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
 	/* Save the context */
 	timer->context.tclr = l;
-- 
1.7.9.5

