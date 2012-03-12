From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] ARM: OMAP2+: fix 'using plain integer as NULL pointer'
 sparse warnings
Date: Mon, 12 Mar 2012 16:42:57 -0600
Message-ID: <20120312224255.4103.6182.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37693 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab2CLWnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 18:43:41 -0400
In-Reply-To: <20120312224006.4103.29464.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

sparse warns when 0 is passed to a function expecting a pointer argument.
Resolve these warnings by replacing the 0 with NULL.

arch/arm/plat-omap/include/plat/dmtimer.h:319:34: warning: Using plain integer as NULL pointer
arch/arm/plat-omap/include/plat/dmtimer.h:324:35: warning: Using plain integer as NULL pointer
arch/arm/mach-omap2/irq.c:294:22: warning: Using plain integer as NULL pointer

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/irq.c                 |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8247c51..22d9f6b 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -292,7 +292,7 @@ void omap_intc_restore_context(void)
 void omap3_intc_suspend(void)
 {
 	/* A pending interrupt would prevent OMAP from entering suspend */
-	omap_ack_irq(0);
+	omap_ack_irq(NULL);
 }
 
 void omap3_intc_prepare_idle(void)
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 9418f00..230ff91 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -316,12 +316,12 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 				OMAP_TIMER_V1_SYS_STAT_OFFSET;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = 0;
+		timer->irq_dis = NULL;
 		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base = timer->io_base;
 	} else {
 		timer->revision = 2;
-		timer->sys_stat = 0;
+		timer->sys_stat = NULL;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
 		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;


