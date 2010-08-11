From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v2 3/6] TI816X: Update common OMAP machine specific sources
Date: Wed, 11 Aug 2010 22:41:04 +0530
Message-ID: <1281546664-11477-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59235 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab0HKRLK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 13:11:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch updates the common machine spcific source files with support for
TI816X.

Note that the nr_irqs is overridden in INTC driver since the number of IRQs on
TI816X are different (128) comapared to other OMAPs (96).

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   20 ++++++++++----------
 arch/arm/mach-omap2/id.c          |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c          |   21 ++++++++++++++++++++-
 arch/arm/mach-omap2/irq.c         |    4 ++++
 arch/arm/mach-omap2/serial.c      |    3 ++-
 5 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5d80cb8..d7d539d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,5 +1,5 @@
 /*
- * OMAP2/3/4 clockdomain framework functions
+ * OMAP2/3/4 and TI816X clockdomain framework functions
  *
  * Copyright (C) 2008-2010 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
@@ -240,7 +240,7 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 			bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
 		else
 			bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx() || cpu_is_ti816x()) {
 		if (enable)
 			bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
 		else
@@ -812,7 +812,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx() || cpu_is_ti816x()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
 			 __ffs(clkdm->clktrctrl_mask));
@@ -856,7 +856,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx() || cpu_is_ti816x()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
 			 __ffs(clkdm->clktrctrl_mask));
@@ -899,10 +899,10 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 
 	/*
 	 * XXX This should be removed once TI adds wakeup/sleep
-	 * dependency code and data for OMAP4.
+	 * dependency code and data for OMAP4, TI816X
 	 */
-	if (cpu_is_omap44xx()) {
-		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
+		WARN_ONCE(1, "clockdomain: wakeup/sleep dependency "
 			  "support is not yet implemented\n");
 	} else {
 		if (atomic_read(&clkdm->usecount) > 0)
@@ -941,10 +941,10 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 
 	/*
 	 * XXX This should be removed once TI adds wakeup/sleep
-	 * dependency code and data for OMAP4.
+	 * dependency code and data for OMAP4, TI816X.
 	 */
-	if (cpu_is_omap44xx()) {
-		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
+		WARN_ONCE(1, "clockdomain: wakeup/sleep dependency "
 			  "support is not yet implemented\n");
 	} else {
 		if (atomic_read(&clkdm->usecount) > 0)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..ca0779a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -61,6 +61,8 @@ int omap_type(void)
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
 		val = omap_ctrl_readl(OMAP44XX_CONTROL_STATUS);
+	} else if (cpu_is_ti816x()) {
+		val = omap_ctrl_readl(TI816X_CONTROL_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
@@ -319,6 +321,26 @@ static void __init omap4_check_revision(void)
 	pr_err("Unknown OMAP4 CPU id\n");
 }
 
+void __init ti816x_check_revision(void)
+{
+	u32 idcode;
+	u16 partnum;
+	u8 rev;
+
+	idcode = read_tap_reg(TI816X_CONTROL_DEVICE_ID);
+	partnum = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0xff;
+
+	if ((partnum == 0xb81e) && (rev == 0x0)) {
+		omap_revision = TI8168_REV_ES1_0;
+		omap_chip.oc |= CHIP_IS_TI816X;
+		pr_info("OMAP chip is TI8168\n");
+		return;
+	}
+
+	pr_err("Unknown TI816X CPU id\n");
+}
+
 #define OMAP3_SHOW_FEATURE(feat)		\
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
@@ -419,6 +441,9 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
 		return;
+	} else if (cpu_is_ti816x()) {
+		ti816x_check_revision();
+		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
 	}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b9ea70b..8675b57 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -229,6 +229,17 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
+#ifdef CONFIG_ARCH_TI816X
+static struct map_desc ti816x_io_desc[] __initdata = {
+	{
+		.virtual	= L4_SLOW_TI816X_VIRT,
+		.pfn		= __phys_to_pfn(L4_SLOW_TI816X_PHYS),
+		.length		= L4_SLOW_TI816X_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+#endif
+
 static void __init _omap2_map_common_io(void)
 {
 	/* Normally devicemaps_init() would flush caches and tlb after
@@ -276,6 +287,14 @@ void __init omap44xx_map_common_io(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_TI816X
+void __init ti816x_map_common_io()
+{
+	iotable_init(ti816x_io_desc, ARRAY_SIZE(ti816x_io_desc));
+	_omap2_map_common_io();
+}
+#endif
+
 /*
  * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
  *
@@ -342,7 +361,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 #ifndef CONFIG_PM_RUNTIME
 	skip_setup_idle = 1;
 #endif
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4, TI8168 */
 		omap_hwmod_late_init(skip_setup_idle);
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 26aeef5..e440d7f 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -201,6 +201,10 @@ void __init omap_init_irq(void)
 			base = OMAP24XX_IC_BASE;
 		else if (cpu_is_omap34xx())
 			base = OMAP34XX_IC_BASE;
+		else if (cpu_is_ti816x()) {
+			base = TI816X_ARM_INTC_BASE;
+			bank->nr_irqs = 128;
+		}
 
 		BUG_ON(!base);
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 566e991..4b654cf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -798,10 +798,11 @@ void __init omap_serial_init_port(int port)
 
 	/*
 	 * omap44xx: Never read empty UART fifo
+	 * ti816x: Never read when UART fifo empty or write when full
 	 * omap3xxx: Never read empty UART fifo on UARTs
 	 * with IP rev >=0x52
 	 */
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx() || cpu_is_ti816x())
 		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
 	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
 			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-- 
1.6.2.4

