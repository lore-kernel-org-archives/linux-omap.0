From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 1/3] TI81XX: Prepare for addition of TI814X support
Date: Thu, 4 Aug 2011 23:14:44 +0530
Message-ID: <1312479884-22636-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41689 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1HDRo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 13:44:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch updates existing macros, functions used for TI816X, to enable
addition of other SoCs belonging to TI81XX family (e.g., TI814X).

The approach taken is to use TI81XX/ti81xx for code/data going to be common
across all TI81XX devices.

cpu_is_ti81xx() is introduced to handle code common across TI81XX devices.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig                        |    6 ++--
 arch/arm/mach-omap2/board-ti8168evm.c              |    6 ++--
 arch/arm/mach-omap2/clock3xxx_data.c               |    2 +-
 arch/arm/mach-omap2/common.c                       |   22 ++++++++++----------
 arch/arm/mach-omap2/control.h                      |    8 +++---
 arch/arm/mach-omap2/id.c                           |    8 +++---
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 +++++-----
 arch/arm/mach-omap2/include/mach/entry-macro.S     |    4 +-
 arch/arm/mach-omap2/io.c                           |   10 ++++----
 arch/arm/mach-omap2/irq.c                          |    2 +-
 arch/arm/mach-omap2/serial.c                       |    6 ++--
 arch/arm/plat-omap/include/plat/common.h           |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   13 +++++++++++
 arch/arm/plat-omap/include/plat/hardware.h         |    2 +-
 arch/arm/plat-omap/include/plat/io.h               |    6 ++--
 arch/arm/plat-omap/include/plat/irqs.h             |    2 +-
 arch/arm/plat-omap/include/plat/serial.h           |   14 ++++++------
 .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 ++++++++--------
 arch/arm/plat-omap/include/plat/uncompress.h       |    8 +++---
 arch/arm/plat-omap/io.c                            |    2 +-
 20 files changed, 83 insertions(+), 70 deletions(-)
 rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d5e4b60..242d9ab 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -74,8 +74,8 @@ config SOC_OMAP3430
 	default y
 	select ARCH_OMAP_OTG
 
-config SOC_OMAPTI816X
-	bool "TI816X support"
+config SOC_OMAPTI81XX
+	bool "TI81XX support"
 	depends on ARCH_OMAP3
 	default y
 
@@ -314,7 +314,7 @@ config MACH_OMAP_3630SDP
 
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
-	depends on SOC_OMAPTI816X
+	depends on SOC_OMAPTI81XX
 	default y
 
 config MACH_OMAP_4430SDP
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index a85d5b0..e516a04 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -42,8 +42,8 @@ static void __init ti8168_evm_init(void)
 
 static void __init ti8168_evm_map_io(void)
 {
-	omap2_set_globals_ti816x();
-	omapti816x_map_common_io();
+	omap2_set_globals_ti81xx();
+	omapti81xx_map_common_io();
 }
 
 MACHINE_START(TI8168EVM, "ti8168evm")
@@ -51,7 +51,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.boot_params	= 0x80000100,
 	.map_io		= ti8168_evm_map_io,
 	.init_early	= ti8168_init_early,
-	.init_irq	= ti816x_init_irq,
+	.init_irq	= ti81xx_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti8168_evm_init,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ffd55b1..10cf22f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3565,7 +3565,7 @@ int __init omap3xxx_clk_init(void)
 	 * Lock DPLL5 -- here only until other device init code can
 	 * handle this
 	 */
-	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
+	if (!cpu_is_ti81xx() && (omap_rev() >= OMAP3430_REV_ES2_0))
 		omap3_clk_lock_dpll5();
 
 	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 3f20cbb..7ce80f2 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -101,23 +101,23 @@ void __init omap3_map_io(void)
 
 /*
  * Adjust TAP register base such that omap3_check_revision accesses the correct
- * TI816X register for checking device ID (it adds 0x204 to tap base while
- * TI816X DEVICE ID register is at offset 0x600 from control base).
+ * TI81XX register for checking device ID (it adds 0x204 to tap base while
+ * TI81XX DEVICE ID register is at offset 0x600 from control base).
  */
-#define TI816X_TAP_BASE		(TI816X_CTRL_BASE + \
-				TI816X_CONTROL_DEVICE_ID - 0x204)
+#define TI81XX_TAP_BASE		(TI81XX_CTRL_BASE + \
+				TI81XX_CONTROL_DEVICE_ID - 0x204)
 
-static struct omap_globals ti816x_globals = {
+static struct omap_globals ti81xx_globals = {
 	.class  = OMAP343X_CLASS,
-	.tap    = OMAP2_L4_IO_ADDRESS(TI816X_TAP_BASE),
-	.ctrl   = TI816X_CTRL_BASE,
-	.prm    = TI816X_PRCM_BASE,
-	.cm     = TI816X_PRCM_BASE,
+	.tap    = OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE),
+	.ctrl   = TI81XX_CTRL_BASE,
+	.prm    = TI81XX_PRCM_BASE,
+	.cm     = TI81XX_PRCM_BASE,
 };
 
-void __init omap2_set_globals_ti816x(void)
+void __init omap2_set_globals_ti81xx(void)
 {
-	__omap2_set_globals(&ti816x_globals);
+	__omap2_set_globals(&ti81xx_globals);
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a016c8b..500d803 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -52,8 +52,8 @@
 #define OMAP343X_CONTROL_PADCONFS_WKUP	0xa00
 #define OMAP343X_CONTROL_GENERAL_WKUP	0xa60
 
-/* TI816X spefic control submodules */
-#define TI816X_CONTROL_DEVCONF		0x600
+/* TI81XX spefic control submodules */
+#define TI81XX_CONTROL_DEVCONF		0x600
 
 /* Control register offsets - read/write with omap_ctrl_{read,write}{bwl}() */
 
@@ -244,8 +244,8 @@
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
 
-/* TI816X CONTROL_DEVCONF register offsets */
-#define TI816X_CONTROL_DEVICE_ID	(TI816X_CONTROL_DEVCONF + 0x000)
+/* TI81XX CONTROL_DEVCONF register offsets */
+#define TI81XX_CONTROL_DEVICE_ID	(TI81XX_CONTROL_DEVCONF + 0x000)
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37efb86..3d84fca 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -237,7 +237,7 @@ static void __init omap4_check_features(void)
 	}
 }
 
-static void __init ti816x_check_features(void)
+static void __init ti81xx_check_features(void)
 {
 	omap_features = OMAP3_HAS_NEON;
 }
@@ -542,11 +542,11 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap34xx()) {
 		omap3_check_revision();
 
-		/* TI816X doesn't have feature register */
-		if (!cpu_is_ti816x())
+		/* TI81XX doesn't have feature register */
+		if (!cpu_is_ti81xx())
 			omap3_check_features();
 		else
-			ti816x_check_features();
+			ti81xx_check_features();
 
 		omap3_cpuinfo();
 		return;
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 48adfe9..309e328 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -72,11 +72,11 @@ omap_uart_lsr:	.word	0
 		beq	34f			@ configure OMAP3UART4
 		cmp	\rp, #OMAP4UART4	@ only on 44xx
 		beq	44f			@ configure OMAP4UART4
-		cmp	\rp, #TI816XUART1	@ ti816x UART offsets different
+		cmp	\rp, #TI81XXUART1	@ ti81Xx UART offsets different
 		beq	81f			@ configure UART1
-		cmp	\rp, #TI816XUART2	@ ti816x UART offsets different
+		cmp	\rp, #TI81XXUART2	@ ti81Xx UART offsets different
 		beq	82f			@ configure UART2
-		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
+		cmp	\rp, #TI81XXUART3	@ ti81Xx UART offsets different
 		beq	83f			@ configure UART3
 		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
 		beq	95f			@ configure ZOOM_UART
@@ -100,11 +100,11 @@ omap_uart_lsr:	.word	0
 		b	98f
 44:		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
 		b	98f
-81:		mov	\rp, #UART_OFFSET(TI816X_UART1_BASE)
+81:		mov	\rp, #UART_OFFSET(TI81XX_UART1_BASE)
 		b	98f
-82:		mov	\rp, #UART_OFFSET(TI816X_UART2_BASE)
+82:		mov	\rp, #UART_OFFSET(TI81XX_UART2_BASE)
 		b	98f
-83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
+83:		mov	\rp, #UART_OFFSET(TI81XX_UART3_BASE)
 		b	98f
 95:		ldr	\rp, =ZOOM_UART_BASE
 		mrc	p15, 0, \rv, c1, c0
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index a48690b..5d3f205 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -64,7 +64,7 @@
 		bne	9998f
 
 		/*
-		 * ti816x has additional IRQ pending register. Checking this
+		 * ti81xx has additional IRQ pending register. Checking this
 		 * register on omap2 & omap3 has no effect (read as 0).
 		 */
 		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
@@ -141,7 +141,7 @@
 		bne	9999f
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
-#ifdef CONFIG_SOC_OMAPTI816X
+#ifdef CONFIG_SOC_OMAPTI81XX
 		bne	9999f
 		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
 		cmp	\irqnr, #0x0
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..d4a89ea 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -175,8 +175,8 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI816X
-static struct map_desc omapti816x_io_desc[] __initdata = {
+#ifdef CONFIG_SOC_OMAPTI81XX
+static struct map_desc omapti81xx_io_desc[] __initdata = {
 	{
 		.virtual	= L4_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
@@ -278,10 +278,10 @@ void __init omap34xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI816X
-void __init omapti816x_map_common_io(void)
+#ifdef CONFIG_SOC_OMAPTI81XX
+void __init omapti81xx_map_common_io(void)
 {
-	iotable_init(omapti816x_io_desc, ARRAY_SIZE(omapti816x_io_desc));
+	iotable_init(omapti81xx_io_desc, ARRAY_SIZE(omapti81xx_io_desc));
 	_omap2_map_common_io();
 }
 #endif
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3a12f75..f8a18f7 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -186,7 +186,7 @@ void __init omap3_init_irq(void)
 	omap_init_irq(OMAP34XX_IC_BASE, 96);
 }
 
-void __init ti816x_init_irq(void)
+void __init ti81xx_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 128);
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..077e91a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -486,7 +486,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
 
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
+	if (cpu_is_omap34xx() && !cpu_is_ti81xx()) {
 		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
 		u32 padconf = 0;
@@ -768,7 +768,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	 */
 	uart->regshift = p->regshift;
 	uart->membase = p->membase;
-	if (cpu_is_omap44xx() || cpu_is_ti816x())
+	if (cpu_is_omap44xx() || cpu_is_ti81xx())
 		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
 	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
 			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
@@ -850,7 +850,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	}
 
 	/* Enable the MDR1 errata for OMAP3 */
-	if (cpu_is_omap34xx() && !cpu_is_ti816x())
+	if (cpu_is_omap34xx() && !cpu_is_ti81xx())
 		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 4564cc6..67b261a 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -66,7 +66,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
-void omap2_set_globals_ti816x(void);
+void omap2_set_globals_ti81xx(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 67b3d75..87dfc8b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -98,6 +98,14 @@ static inline int is_omap ##class (void)		\
 	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
 }
 
+#define GET_TI_CLASS	((omap_rev() >> 24) & 0xff)
+
+#define IS_TI_CLASS(class, id)			\
+static inline int is_ti ##class (void)		\
+{							\
+	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -119,6 +127,8 @@ IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
 
+IS_TI_CLASS(81xx, 0x81)
+
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
@@ -136,6 +146,7 @@ IS_TI_SUBCLASS(816x, 0x816)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_ti81xx()			0
 #define cpu_is_ti816x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
@@ -342,6 +353,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3530
 # undef cpu_is_omap3505
 # undef cpu_is_omap3517
+# undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
@@ -358,6 +370,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3517()		is_omap3517()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
+# define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index e87efe1..1a2f830 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -286,6 +286,6 @@
 #include <plat/omap24xx.h>
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
-#include <plat/ti816x.h>
+#include <plat/ti81xx.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index d72ec85..98c4280 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -283,10 +283,10 @@ static inline void omap34xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI816X
-extern void omapti816x_map_common_io(void);
+#ifdef CONFIG_SOC_OMAPTI81XX
+extern void omapti81xx_map_common_io(void);
 #else
-static inline void omapti816x_map_common_io(void)
+static inline void omapti81xx_map_common_io(void)
 {
 }
 #endif
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 35437d3..1037533 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -440,7 +440,7 @@ extern void __iomem *omap_irq_base;
 void omap1_init_irq(void);
 void omap2_init_irq(void);
 void omap3_init_irq(void);
-void ti816x_init_irq(void);
+void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..865b13e 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -51,10 +51,10 @@
 #define OMAP4_UART3_BASE	0x48020000
 #define OMAP4_UART4_BASE	0x4806e000
 
-/* TI816X serial ports */
-#define TI816X_UART1_BASE	0x48020000
-#define TI816X_UART2_BASE	0x48022000
-#define TI816X_UART3_BASE	0x48024000
+/* TI81XX serial ports */
+#define TI81XX_UART1_BASE	0x48020000
+#define TI81XX_UART2_BASE	0x48022000
+#define TI81XX_UART3_BASE	0x48024000
 
 /* AM3505/3517 UART4 */
 #define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
@@ -89,9 +89,9 @@
 #define OMAP4UART2		OMAP2UART2
 #define OMAP4UART3		43
 #define OMAP4UART4		44
-#define TI816XUART1		81
-#define TI816XUART2		82
-#define TI816XUART3		83
+#define TI81XXUART1		81
+#define TI81XXUART2		82
+#define TI81XXUART3		83
 #define ZOOM_UART		95		/* Only on zoom2/3 */
 
 /* This is only used by 8250.c for omap1510 */
diff --git a/arch/arm/plat-omap/include/plat/ti816x.h b/arch/arm/plat-omap/include/plat/ti81xx.h
similarity index 60%
rename from arch/arm/plat-omap/include/plat/ti816x.h
rename to arch/arm/plat-omap/include/plat/ti81xx.h
index 50510f5..8f9843f 100644
--- a/arch/arm/plat-omap/include/plat/ti816x.h
+++ b/arch/arm/plat-omap/include/plat/ti81xx.h
@@ -1,5 +1,5 @@
 /*
- * This file contains the address data for various TI816X modules.
+ * This file contains the address data for various TI81XX modules.
  *
  * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
  *
@@ -13,15 +13,15 @@
  * GNU General Public License for more details.
  */
 
-#ifndef __ASM_ARCH_TI816X_H
-#define __ASM_ARCH_TI816X_H
+#ifndef __ASM_ARCH_TI81XX_H
+#define __ASM_ARCH_TI81XX_H
 
-#define L4_SLOW_TI816X_BASE	0x48000000
+#define L4_SLOW_TI81XX_BASE	0x48000000
 
-#define TI816X_SCM_BASE		0x48140000
-#define TI816X_CTRL_BASE	TI816X_SCM_BASE
-#define TI816X_PRCM_BASE	0x48180000
+#define TI81XX_SCM_BASE		0x48140000
+#define TI81XX_CTRL_BASE	TI81XX_SCM_BASE
+#define TI81XX_PRCM_BASE	0x48180000
 
-#define TI816X_ARM_INTC_BASE	0x48200000
+#define TI81XX_ARM_INTC_BASE	0x48200000
 
-#endif /* __ASM_ARCH_TI816X_H */
+#endif /* __ASM_ARCH_TI81XX_H */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index cb4a6c2..40336ad 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -93,9 +93,9 @@ static inline void flush(void)
 #define DEBUG_LL_ZOOM(mach)						\
 	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
 
-#define DEBUG_LL_TI816X(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		TI816XUART##p)
+#define DEBUG_LL_TI81XX(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, TI81XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		TI81XXUART##p)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
@@ -173,7 +173,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_ZOOM(omap_zoom3);
 
 		/* TI8168 base boards using UART3 */
-		DEBUG_LL_TI816X(3, ti8168evm);
+		DEBUG_LL_TI81XX(3, ti8168evm);
 
 	} while (0);
 }
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index f1ecfa9..1443992 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -85,7 +85,7 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_ti816x()) {
+	if (cpu_is_ti81xx()) {
 		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
 			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
 	} else if (cpu_is_omap34xx()) {
-- 
1.7.3.5

