From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.4-rc][PATCH] genirq / PM: restore system wake up from chained interrupts
Date: Tue, 10 Nov 2015 11:58:12 +0200
Message-ID: <1447149492-20699-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Commit e509bd7da149 ("genirq: Allow migration of chained interrupts
by installing default action") breaks PCS wake up IRQ behaviour on
TI OMAP based platforms (dra7-evm).

TI OMAP IRQ wake up configuration:
GIC-irqchip->PCM_IRQ
  |- omap_prcm_register_chain_handler
     |- PRCM-irqchip -> PRCM_IO_IRQ
        |- pcs_irq_chain_handler
           |- pinctrl-irqchip -> PCS_uart1_wakeup_irq

This happens because IRQ PM code (irq/pm.c) is expected to ignore
chained interrupts by default:
  static bool suspend_device_irq(struct irq_desc *desc)
  {
	if (!desc->action || desc->no_suspend_depth)
		return false;
 - it's expected !desc->action = true for chained interrupts;

but, after above change, all chained interrupt descriptors will
have default action handler installed - chained_action.
As result, chained interrupts will be silently disabled during system
suspend.

Hence, fix it by introducing helper function irq_desc_is_chained() and
use it in suspend_device_irq() for chained interrupts identification
and skip them, once detected.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>
Fixes: e509bd7da149 ("genirq: Allow migration of chained interrupts..")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/irq/internals.h | 5 +++++
 kernel/irq/pm.c        | 3 ++-
 kernel/irq/proc.c      | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 05c2188..fcab63c 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -199,6 +199,11 @@ static inline int irq_desc_get_node(struct irq_desc *desc)
 	return irq_common_data_get_node(&desc->irq_common_data);
 }
 
+static inline int irq_desc_is_chained(struct irq_desc *desc)
+{
+	return (desc->action && desc->action == &chained_action);
+}
+
 #ifdef CONFIG_PM_SLEEP
 bool irq_pm_check_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index e80c440..cea1de0 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -70,7 +70,8 @@ void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action)
 
 static bool suspend_device_irq(struct irq_desc *desc)
 {
-	if (!desc->action || desc->no_suspend_depth)
+	if (!desc->action || irq_desc_is_chained(desc) ||
+	    desc->no_suspend_depth)
 		return false;
 
 	if (irqd_is_wakeup_set(&desc->irq_data)) {
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index a916cf1..a2c02fd 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -475,7 +475,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	for_each_online_cpu(j)
 		any_count |= kstat_irqs_cpu(i, j);
 	action = desc->action;
-	if ((!action || action == &chained_action) && !any_count)
+	if ((!action || irq_desc_is_chained(desc)) && !any_count)
 		goto out;
 
 	seq_printf(p, "%*d: ", prec, i);
-- 
2.6.2
