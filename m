From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-20081106 2/3] OMAP: PM: Build fails if PM is not enabled
Date: Tue, 18 Nov 2008 14:42:37 +0200
Message-ID: <1227012157-895-1-git-send-email-jouni.hogander@nokia.com>
References: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48009 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYKRMmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 07:42:55 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAICgObp006631
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 06:42:54 -0600
In-Reply-To: <87skppi50r.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch fixes build in case if PM is not enabled

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/control.c          |    6 ++++--
 arch/arm/mach-omap2/serial.c           |   32 +++++++++++++++++++-------------
 arch/arm/plat-omap/Kconfig             |    3 ++-
 arch/arm/plat-omap/include/mach/sram.h |    5 +++++
 arch/arm/plat-omap/sram.c              |    2 ++
 5 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 743b57e..d28b823 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -26,6 +26,7 @@
 
 static void __iomem *omap2_ctrl_base;
 
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
 	u32 boot_config_ptr;
 	u32 public_restore_ptr;
@@ -133,6 +134,7 @@ struct omap3_control_regs {
 };
 
 static struct omap3_control_regs control_context;
+#endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 
@@ -176,7 +178,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
  * Clears the scratchpad contents in case of cold boot-
  * called during bootup
@@ -425,4 +427,4 @@ void omap3_control_restore_context(void)
 	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
 	return;
 }
-#endif /* CONFIG_ARCH_OMAP3 */
+#endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 65cce87..95a2299 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -51,7 +51,7 @@ struct omap_uart_state {
 	struct plat_serial8250_port *p;
 	struct list_head node;
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 	int context_valid;
 
 	/* Registers to be saved/restored for OFF-mode */
@@ -126,7 +126,7 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
@@ -186,6 +186,18 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
 static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 #endif /* CONFIG_ARCH_OMAP3 */
 
+static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
+{
+	if (uart->clocked)
+		return;
+
+	clk_enable(uart->ick);
+	clk_enable(uart->fck);
+	uart->clocked = 1;
+	omap_uart_restore_context(uart);
+}
+
+#ifdef CONFIG_PM
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					  int enable)
 {
@@ -201,17 +213,6 @@ static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 	serial_write_reg(p, UART_OMAP_SYSC, sysc);
 }
 
-static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
-{
-	if (uart->clocked)
-		return;
-
-	clk_enable(uart->ick);
-	clk_enable(uart->fck);
-	uart->clocked = 1;
-	omap_uart_restore_context(uart);
-}
-
 static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 {
 	if (!uart->clocked)
@@ -409,6 +410,11 @@ static void omap_uart_pm(struct uart_port *port,
 		break;
 	}
 }
+#else
+static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+static inline void omap_uart_pm(struct uart_port *port,
+		unsigned int state, unsigned int old_state) {}
+#endif /* CONFIG_PM */
 
 void __init omap_serial_init(void)
 {
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 0ee0985..ca67862 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -58,7 +58,7 @@ config OMAP_DEBUG_CLOCKDOMAIN
 
 config OMAP_SMARTREFLEX
 	bool "SmartReflex support"
-	depends on ARCH_OMAP34XX && TWL4030_CORE
+	depends on ARCH_OMAP34XX && TWL4030_CORE && PM
 	help
 	  Say Y if you want to enable SmartReflex.
 
@@ -264,6 +264,7 @@ config OMAP_PM_NOOP
 	bool "No-op/debug PM layer"
 
 config OMAP_PM_SRF
+	depends on PM
 	bool "PM layer implemented using SRF"
 
 endchoice
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 87f4567..0c0b45f 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -63,6 +63,11 @@ extern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
 					  u32 sdrc_actim_ctrla,
 					  u32 sdrc_actim_ctrlb, u32 m2);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
+
+#ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
+#else
+static inline void omap_push_sram_idle(void) {}
+#endif /* CONFIG_PM */
 
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index ea95488..b0cefd4 100755
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -373,6 +373,7 @@ u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
 					       sdrc_actim_ctrlb, m2);
  }
 
+#ifdef CONFIG_PM
 void omap3_sram_restore_context(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
@@ -382,6 +383,7 @@ void omap3_sram_restore_context(void)
 			       omap3_sram_configure_core_dpll_sz);
 	omap_push_sram_idle();
 }
+#endif /* CONFIG_PM */
 
 int __init omap3_sram_init(void)
 {
-- 
1.6.0.1

