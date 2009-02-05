From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/21] OMAP: dmtimer: enable all timers to be wakeup events
Date: Wed,  4 Feb 2009 18:05:51 -0800
Message-ID: <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:13429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183AbZBECGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:06:44 -0500
Received: by an-out-0708.google.com with SMTP id c2so43anc.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:06:44 -0800 (PST)
In-Reply-To: <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

All GP timers on OMAP2/3 can be wakeup events.  The wakeup status is
cleared in the PRCM interrupt handler.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e4f0ce0..d0fc974 100644
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
1.6.1

