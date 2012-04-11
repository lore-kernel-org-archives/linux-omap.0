From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 06/12] ARM: OMAP: fix 'using plain integer as NULL pointer'
 sparse warnings
Date: Tue, 10 Apr 2012 18:35:45 -0600
Message-ID: <20120411003542.27059.97130.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43930 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2DKAiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:21 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

sparse warns when 0 is passed to a function expecting a pointer argument.
Resolve these warnings by replacing the 0 with NULL.

arch/arm/plat-omap/include/plat/dmtimer.h:319:34: warning: Using plain integer as NULL pointer
arch/arm/plat-omap/include/plat/dmtimer.h:324:35: warning: Using plain integer as NULL pointer
arch/arm/mach-omap2/irq.c:294:22: warning: Using plain integer as NULL pointer
arch/arm/mach-omap1/board-palmz71.c:292:50: warning: Using plain integer as NULL pointer
arch/arm/mach-omap1/board-palmz71.c:295:73: warning: Using plain integer as NULL pointer
arch/arm/mach-omap1/ams-delta-fiq.c:105:63: warning: Using plain integer as NULL pointer

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c       |    2 +-
 arch/arm/mach-omap1/board-palmz71.c       |    4 ++--
 arch/arm/mach-omap2/irq.c                 |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index fcce7ff..31197bd 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -102,7 +102,7 @@ void __init ams_delta_init_fiq(void)
 	}
 
 	retval = request_irq(INT_DEFERRED_FIQ, deferred_fiq,
-			IRQ_TYPE_EDGE_RISING, "deferred_fiq", 0);
+			IRQ_TYPE_EDGE_RISING, "deferred_fiq", NULL);
 	if (retval < 0) {
 		pr_err("Failed to get deferred_fiq IRQ, ret=%d\n", retval);
 		release_fiq(&fh);
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index a2c5abc..61ed4f0 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -289,10 +289,10 @@ palmz71_gpio_setup(int early)
 		gpio_direction_input(PALMZ71_USBDETECT_GPIO);
 		if (request_irq(gpio_to_irq(PALMZ71_USBDETECT_GPIO),
 				palmz71_powercable, IRQF_SAMPLE_RANDOM,
-				"palmz71-cable", 0))
+				"palmz71-cable", NULL))
 			printk(KERN_ERR
 					"IRQ request for power cable failed!\n");
-		palmz71_powercable(gpio_to_irq(PALMZ71_USBDETECT_GPIO), 0);
+		palmz71_powercable(gpio_to_irq(PALMZ71_USBDETECT_GPIO), NULL);
 	}
 }
 
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 14fbc78..80f3ced 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -335,7 +335,7 @@ void omap_intc_restore_context(void)
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


