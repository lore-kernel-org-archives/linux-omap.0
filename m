From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: dmtimer: enable all timers to be wakeup events
Date: Tue, 16 Dec 2008 10:34:09 -0800
Message-ID: <1229452450-22497-3-git-send-email-khilman@deeprootsystems.com>
References: <1229452450-22497-1-git-send-email-khilman@deeprootsystems.com>
 <1229452450-22497-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f31.google.com ([209.85.219.31]:47421 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYLPSe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:34:27 -0500
Received: by mail-ew0-f31.google.com with SMTP id 12so3425524ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 10:34:26 -0800 (PST)
In-Reply-To: <1229452450-22497-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

All GP timers on OMAP2/3 can be wakeup events.  The wakeup status is
cleared in the PRCM interrupt handler.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 5708fd8..ed397f0 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -320,11 +320,9 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
 
 	/*
-	 * Enable wake-up only for GPT1 on OMAP2 CPUs.
-	 * FIXME: All timers should have wake-up enabled and clear
-	 * PRCM status.
+	 * Enable wake-up on OMAP2 CPUs.
 	 */
-	if (cpu_class_is_omap2() && (timer == &dm_timers[0]))
+	if (cpu_class_is_omap2())
 		l |= 1 << 2;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
 
-- 
1.6.0.3

