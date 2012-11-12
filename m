From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 08/13] ARM: OMAP: Don't restore of DMTIMER TISTAT register
Date: Mon, 12 Nov 2012 12:20:39 -0600
Message-ID: <1352744444-2633-9-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33314 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab2KLSVB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 13:21:01 -0500
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The timer TISTAT register is a read-only register and therefore restoring the
context is not needed. Furthermore, the context of TISTAT is never saved
anywhere in the current code. The TISTAT register is read-only for all OMAP
devices from OMAP1 to OMAP4. OMAP5 timers no longer have this register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |    3 ---
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d4f9541..320d103 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -83,9 +83,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	if (timer->revision == 1)
-		__raw_writel(timer->context.tistat, timer->sys_stat);
-
 	__raw_writel(timer->context.tisr, timer->irq_stat);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
 				timer->context.twer);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index ac16f1e..2f9fd1d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -84,7 +84,6 @@ struct omap_dm_timer;
 
 struct timer_regs {
 	u32 tidr;
-	u32 tistat;
 	u32 tisr;
 	u32 tier;
 	u32 twer;
-- 
1.7.9.5

