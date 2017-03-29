From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/8] ARM: OMAP: Wakeupgen: Add context save/restore for AM43XX
Date: Tue, 28 Mar 2017 20:57:54 -0500
Message-ID: <20170329015801.22240-2-d-gerlach@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

AM43XX has the same wakeupgen IP as OMAP4/5. The only
notable difference is the presence of 7 register banks
and lack of SAR area which has been used in OMAP4/5 for
saving and restoring the context around low power states.

In case of AM43XX the context is saved and restored by
the kernel. Introduce wakeupgen_ops so that context save
and restore can be set on a per-SoC basis during init.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 68 ++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 369f95a703ac..33ed5d53fa45 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -58,6 +58,17 @@ static unsigned int irq_banks = DEFAULT_NR_REG_BANKS;
 static unsigned int max_irqs = DEFAULT_IRQS;
 static unsigned int omap_secure_apis;
 
+#ifdef CONFIG_CPU_PM
+static unsigned int wakeupgen_context[MAX_NR_REG_BANKS];
+#endif
+
+struct omap_wakeupgen_ops {
+	void (*save_context)(void);
+	void (*restore_context)(void);
+};
+
+static struct omap_wakeupgen_ops *wakeupgen_ops;
+
 /*
  * Static helper functions.
  */
@@ -264,6 +275,16 @@ static inline void omap5_irq_save_context(void)
 
 }
 
+static inline void am43xx_irq_save_context(void)
+{
+	u32 i;
+
+	for (i = 0; i < irq_banks; i++) {
+		wakeupgen_context[i] = wakeupgen_readl(i, 0);
+		wakeupgen_writel(0, i, CPU0_ID);
+	}
+}
+
 /*
  * Save WakeupGen interrupt context in SAR BANK3. Restore is done by
  * ROM code. WakeupGen IP is integrated along with GIC to manage the
@@ -280,11 +301,8 @@ static void irq_save_context(void)
 
 	if (!sar_base)
 		sar_base = omap4_get_sar_ram_base();
-
-	if (soc_is_omap54xx())
-		omap5_irq_save_context();
-	else
-		omap4_irq_save_context();
+	if (wakeupgen_ops && wakeupgen_ops->save_context)
+		wakeupgen_ops->save_context();
 }
 
 /*
@@ -306,6 +324,20 @@ static void irq_sar_clear(void)
 	writel_relaxed(val, sar_base + offset);
 }
 
+static void am43xx_irq_restore_context(void)
+{
+	u32 i;
+
+	for (i = 0; i < irq_banks; i++)
+		wakeupgen_writel(wakeupgen_context[i], i, CPU0_ID);
+}
+
+static void irq_restore_context(void)
+{
+	if (wakeupgen_ops && wakeupgen_ops->restore_context)
+		wakeupgen_ops->restore_context();
+}
+
 /*
  * Save GIC and Wakeupgen interrupt context using secure API
  * for HS/EMU devices.
@@ -319,6 +351,26 @@ static void irq_save_secure_context(void)
 	if (ret != API_HAL_RET_VALUE_OK)
 		pr_err("GIC and Wakeupgen context save failed\n");
 }
+
+/* Define ops for context save and restore for each SoC */
+static struct omap_wakeupgen_ops omap4_wakeupgen_ops = {
+	.save_context = omap4_irq_save_context,
+	.restore_context = irq_sar_clear,
+};
+
+static struct omap_wakeupgen_ops omap5_wakeupgen_ops = {
+	.save_context = omap5_irq_save_context,
+	.restore_context = irq_sar_clear,
+};
+
+static struct omap_wakeupgen_ops am43xx_wakeupgen_ops = {
+	.save_context = am43xx_irq_save_context,
+	.restore_context = am43xx_irq_restore_context,
+};
+#else
+static struct omap_wakeupgen_ops omap4_wakeupgen_ops = {};
+static struct omap_wakeupgen_ops omap5_wakeupgen_ops = {};
+static struct omap_wakeupgen_ops am43xx_wakeupgen_ops = {};
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -359,7 +411,7 @@ static int irq_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 		break;
 	case CPU_CLUSTER_PM_EXIT:
 		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
-			irq_sar_clear();
+			irq_restore_context();
 		break;
 	}
 	return NOTIFY_OK;
@@ -494,9 +546,13 @@ static int __init wakeupgen_init(struct device_node *node,
 		irq_banks = OMAP4_NR_BANKS;
 		max_irqs = OMAP4_NR_IRQS;
 		omap_secure_apis = 1;
+		wakeupgen_ops = &omap4_wakeupgen_ops;
+	} else if (soc_is_omap54xx()) {
+		wakeupgen_ops = &omap5_wakeupgen_ops;
 	} else if (soc_is_am43xx()) {
 		irq_banks = AM43XX_NR_REG_BANKS;
 		max_irqs = AM43XX_IRQS;
+		wakeupgen_ops = &am43xx_wakeupgen_ops;
 	}
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, max_irqs,
-- 
2.11.0
