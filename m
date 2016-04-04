From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] ARM: OMAP: wakeupgen: Add comment for unhandled FROZEN transitions
Date: Mon,  4 Apr 2016 14:55:17 +0200
Message-ID: <1459774517-58943-1-git-send-email-anna-maria@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

FROZEN hotplug notifiers are not handled and do not have to be. Insert
a comment to remember that the lack of the FROZEN transitions is no
accident.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -320,6 +320,11 @@ static int irq_cpu_hotplug_notify(struct
 {
 	unsigned int cpu = (unsigned int)hcpu;
 
+	/*
+	 * Corresponding FROZEN transitions do not have to be handled,
+	 * they are handled by at a higher level
+	 * (drivers/cpuidle/coupled.c).
+	 */
 	switch (action) {
 	case CPU_ONLINE:
 		wakeupgen_irqmask_all(cpu, 0);
