From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 14:21:17 +0530
Message-ID: <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58013 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1AXIvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 03:51:48 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

In CPU low power state, local timer looses its register context. This
patch adds context save restore hooks which can be used by platforms
appropriately.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/localtimer.h |   13 +++++++++++++
 arch/arm/include/asm/smp_twd.h    |    2 ++
 arch/arm/kernel/smp_twd.c         |   24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 6bc63ab..6753754 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -31,6 +31,9 @@ asmlinkage void do_local_timer(struct pt_regs *);
 
 #define local_timer_ack()	twd_timer_ack()
 
+#define local_timer_save(cpu)		twd_context_save(cpu);
+#define local_timer_restore(cpu)	twd_context_save(cpu);
+
 #else
 
 /*
@@ -46,6 +49,16 @@ int local_timer_ack(void);
  */
 void local_timer_setup(struct clock_event_device *);
 
+/*
+ * Save local timer register context
+ */
+void local_timer_save(unsigned int cpu);
+
+/*
+ * Restore local timer register context
+ */
+void local_timer_restoree(unsigned int cpu);
+
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..7828f29 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -24,5 +24,7 @@ extern void __iomem *twd_base;
 
 int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_context_save(unsigned int cpu);
+void twd_context_restore(unsigned int cpu);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fd91566..f3098e4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -24,6 +24,12 @@
 /* set up by the platform code */
 void __iomem *twd_base;
 
+/* Timer context to be saved in low power modes */
+struct twd_registers {
+	unsigned long timer_ctrl;
+	unsigned long timer_load;
+};
+static DEFINE_PER_CPU(struct twd_registers, twd_context);
 static unsigned long twd_timer_rate;
 
 static void twd_set_mode(enum clock_event_mode mode,
@@ -145,3 +151,21 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	clockevents_register_device(clk);
 }
+
+/* Low power context save */
+void twd_context_save(unsigned int cpu)
+{
+	struct twd_registers *regs = &per_cpu(twd_context, cpu);
+
+	regs->timer_ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+	regs->timer_load = __raw_readl(twd_base + TWD_TIMER_LOAD);
+}
+
+/* Low power context restore */
+void twd_context_restore(unsigned int cpu)
+{
+	struct twd_registers *regs = &per_cpu(twd_context, cpu);
+
+	__raw_writel(regs->timer_load, twd_base + TWD_TIMER_LOAD);
+	__raw_writel(regs->timer_ctrl, twd_base + TWD_TIMER_CONTROL);
+}
-- 
1.6.0.4

