From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] OMAP: dmtimer: enable all timers to be wakeup events
Date: Tue, 14 Apr 2009 12:23:33 -0600
Message-ID: <20090414182332.22344.42465.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45745 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbZDNS1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:17 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

All GP timers on OMAP2/3 can generate wakeup events.  The wakeup status is
cleared in the PRCM interrupt handler.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c99d611..a05205c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -321,11 +321,9 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
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
 


