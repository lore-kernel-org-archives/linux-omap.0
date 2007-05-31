From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 11/12] OMAP3430 support in include/asm-arm/arch-omap
Date: Thu, 31 May 2007 12:59:42 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470106321C@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adding OMAP3430 support to include/asm-arm/arch-omap

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 clock.h       |    1 +
 cpu.h         |   28 +++++++++++++++++++++++++++-
 debug-macro.S |   12 ++++++++++++
 entry-macro.S |    8 +++++++-
 hardware.h    |   12 +++++++++++-
 io.h          |   57
 irqs.h        |   17 +++++++++++++++++
 mcbsp.h       |    2 +-
 memory.h      |    2 +-
 serial.h      |    5 +++++
 10 files changed, 139 insertions(+), 5 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/include/asm-arm/arch-omap/clock.h =
val_3430_GIT/include/asm-arm/arch-omap/clock.h
--- linux-omap/include/asm-arm/arch-omap/clock.h	2006-11-20 =
21:56:59.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/clock.h	2007-05-25 =
22:38:46.000000000 -0500
@@ -87,5 +87,6 @@ extern int clk_get_usecount(struct clk *
 #define CLOCK_IN_OMAP16XX	(1 << 24)
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
+#define CLOCK_IN_OMAP343X	(1 << 27)
=20
 #endif
diff -purN linux-omap/include/asm-arm/arch-omap/cpu.h =
val_3430_GIT/include/asm-arm/arch-omap/cpu.h
--- linux-omap/include/asm-arm/arch-omap/cpu.h	2006-11-20 =
21:56:59.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/cpu.h	2007-05-29 =
15:19:45.000000000 -0500
@@ -35,6 +35,7 @@ extern unsigned int system_rev;
  */
 #undef MULTI_OMAP1
 #undef MULTI_OMAP2
+#undef MULTI_OMAP3
 #undef OMAP_NAME
=20
 #ifdef CONFIG_ARCH_OMAP730
@@ -69,6 +70,14 @@ extern unsigned int system_rev;
 #  define OMAP_NAME omap24xx
 # endif
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+# if (defined(OMAP_NAME) || defined(MULTI_OMAP1) || =
defined(MULTI_OMAP2))
+#  error "OMAP1 / OMAP2 / OMAP3 can't be selected at the same time"
+# else
+#  undef MULTI_OMAP3
+#  define OMAP_NAME omap34xx
+# endif
+#endif
=20
 /*
  * Macros to group OMAP into cpu classes.
@@ -79,6 +88,7 @@ extern unsigned int system_rev;
  * cpu_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
+ * cpu_is_omap343x():	True for OMAP3430
  */
 #define GET_OMAP_CLASS	(system_rev & 0xff)
=20
@@ -100,9 +110,11 @@ IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
+IS_OMAP_CLASS(34xx, 0x34)
=20
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
+IS_OMAP_SUBCLASS(343x, 0x343)
=20
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -110,6 +122,7 @@ IS_OMAP_SUBCLASS(243x, 0x243)
 #define cpu_is_omap24xx()		0
 #define cpu_is_omap242x()		0
 #define cpu_is_omap243x()		0
+#define cpu_is_omap343x()		0
=20
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -145,6 +158,12 @@ IS_OMAP_SUBCLASS(243x, 0x243)
 #  define cpu_is_omap242x()		is_omap242x()
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
+# if defined(CONFIG_ARCH_OMAP34XX)
+#  undef  cpu_is_omap34xx
+#  define cpu_is_omap34xx()		1
+# else
+#  define cpu_is_omap34xx()		0
+# endif
 #endif
=20
 /*
@@ -183,6 +202,7 @@ IS_OMAP_TYPE(2420, 0x2420)
 IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
+IS_OMAP_TYPE(3430, 0x3430)
=20
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -196,6 +216,7 @@ IS_OMAP_TYPE(2430, 0x2430)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
+#define cpu_is_omap3430()		0
=20
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -244,9 +265,14 @@ IS_OMAP_TYPE(2430, 0x2430)
 # define cpu_is_omap2430()		is_omap2430()
 #endif
=20
+#if defined(CONFIG_ARCH_OMAP34XX)
+# undef cpu_is_omap3430
+# define cpu_is_omap3430()		is_omap3430()
+#endif
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || =
\
 				cpu_is_omap16xx())
-#define cpu_class_is_omap2()	cpu_is_omap24xx()
+#define cpu_class_is_omap2()	cpu_is_omap24xx() || cpu_is_omap34xx()
=20
 #endif
diff -purN linux-omap/include/asm-arm/arch-omap/debug-macro.S =
val_3430_GIT/include/asm-arm/arch-omap/debug-macro.S
--- linux-omap/include/asm-arm/arch-omap/debug-macro.S	2006-11-20 =
21:56:59.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/debug-macro.S	2007-05-25 =
22:59:27.000000000 -0500
@@ -35,6 +35,18 @@
 #ifdef CONFIG_OMAP_LL_DEBUG_UART3
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
+
+#elif	CONFIG_ARCH_OMAP3
+		moveq	\rx, #0x48000000	@ physical base address
+		movne	\rx, #0xd8000000	@ virtual base
+		orr	\rx, \rx, #0x0006a000
+#ifdef CONFIG_OMAP_LL_DEBUG_UART2
+		add	\rx, \rx, #0x00002000	@ UART 2
+#endif
+#ifdef CONFIG_OMAP_LL_DEBUG_UART3
+		add	\rx, \rx, #0x00fb0000	@ UART 3
+		add	\rx, \rx, #0x00006000
+#endif
 #endif
 		.endm
=20
diff -purN linux-omap/include/asm-arm/arch-omap/entry-macro.S =
val_3430_GIT/include/asm-arm/arch-omap/entry-macro.S
--- linux-omap/include/asm-arm/arch-omap/entry-macro.S	2007-05-25 =
15:52:27.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/entry-macro.S	2007-05-29 =
13:13:19.000000000 -0500
@@ -54,9 +54,15 @@
 1510:
 		.endm
=20
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#endif
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
=20
+#if defined(CONFIG_ARCH_OMAP24XX)
 #include <asm/arch/omap24xx.h>
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+#include <asm/arch/omap34xx.h>
+#endif
=20
 		.macro	disable_fiq
 		.endm
diff -purN linux-omap/include/asm-arm/arch-omap/hardware.h =
val_3430_GIT/include/asm-arm/arch-omap/hardware.h
--- linux-omap/include/asm-arm/arch-omap/hardware.h	2007-05-25 =
15:52:27.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/hardware.h	2007-05-25 =
22:59:27.000000000 -0500
@@ -283,10 +283,16 @@
=20
 #include "omap730.h"
 #include "omap1510.h"
-#include "omap24xx.h"
 #include "omap16xx.h"
 #include "omap34xx.h"
=20
+#ifdef CONFIG_ARCH_OMAP24XX
+#include "omap24xx.h"
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+#include "omap34xx.h"
+#endif
+
 #ifndef __ASSEMBLER__
=20
 /*
@@ -323,6 +329,10 @@
 #include "board-2430sdp.h"
 #endif
=20
+#ifdef CONFIG_MACH_OMAP_3430SDP
+#include "board-3430sdp.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_APOLLON
 #include "board-apollon.h"
 #endif
diff -purN linux-omap/include/asm-arm/arch-omap/io.h =
val_3430_GIT/include/asm-arm/arch-omap/io.h
--- linux-omap/include/asm-arm/arch-omap/io.h	2007-05-25 =
15:52:27.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/io.h	2007-05-28 =
12:47:13.000000000 -0500
@@ -105,6 +105,63 @@
 #define DSP_MMU_24XX_VIRT	0xe2000000
 #define DSP_MMU_24XX_SIZE	SZ_4K
=20
+#elif defined(CONFIG_ARCH_OMAP3)
+
+/* We map both L3 and L4 on OMAP3 */
+#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
+#define L3_34XX_VIRT		0xf8000000
+#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
+
+#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 */
+#define L4_34XX_VIRT		0xd8000000
+#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
+ * Need to look at the Size 4M for L4.
+ * VPOM3430 was not working for Int controller
+ */
+
+#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE /* 0x48300000 */
+#define L4_WK_34XX_VIRT		0xd8300000
+#define L4_WK_34XX_SIZE		SZ_1M
+
+#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE /* 0x49000000 */
+#define L4_PER_34XX_VIRT	0xd9000000
+#define L4_PER_34XX_SIZE	SZ_1M
+
+#define L4_EMU_34XX_PHYS	L4_34XX_EMU_BASE /* 0x54000000 */
+#define L4_EMU_34XX_VIRT	0xe4000000
+#define L4_EMU_34XX_SIZE	SZ_64M
+
+#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE /* 0x6E000000 */
+#define OMAP34XX_GPMC_VIRT	0xFE000000
+#define OMAP34XX_GPMC_SIZE	SZ_1M
+
+#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE /* 0x6C000000 */
+#define OMAP343X_SMS_VIRT	0xFC000000
+#define OMAP343X_SMS_SIZE	SZ_1M
+
+#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE /* 0x6D000000 */
+#define OMAP343X_SDRC_VIRT	0xFD000000
+#define OMAP343X_SDRC_SIZE	SZ_1M
+
+
+#define IO_OFFSET		0x90000000
+#define IO_ADDRESS(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_p2v(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
+
+/* DSP */
+#define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_34XX_VIRT	0xe0000000
+#define DSP_MEM_34XX_SIZE	0x28000
+#define DSP_IPI_34XX_PHYS	OMAP34XX_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_34XX_VIRT	0xe1000000
+#define DSP_IPI_34XX_SIZE	SZ_4K
+#define DSP_MMU_34XX_PHYS	OMAP34XX_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_34XX_VIRT	0xe2000000
+#define DSP_MMU_34XX_SIZE	SZ_4K
+
 #endif
=20
 #ifndef __ASSEMBLER__
diff -purN linux-omap/include/asm-arm/arch-omap/irqs.h =
val_3430_GIT/include/asm-arm/arch-omap/irqs.h
--- linux-omap/include/asm-arm/arch-omap/irqs.h	2007-05-16 =
14:33:06.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/irqs.h	2007-05-25 =
22:50:26.000000000 -0500
@@ -283,6 +283,23 @@
 #define	INT_243X_HS_USB_DMA	93
 #define	INT_243X_CARKIT		94
=20
+#define INT_34XX_ST_MCBSP2_IRQ	4
+#define INT_34XX_ST_MCBSP3_IRQ	3
+#define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_MCBSP1_IRQ	16
+#define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_MCBSP3_IRQ	22
+#define INT_34XX_MCBSP4_IRQ	23
+#define INT_34XX_MCBSP5_IRQ	27
+#define INT_34XX_GPIO_BANK1	29
+#define INT_34XX_GPIO_BANK2	30
+#define INT_34XX_GPIO_BANK3	31
+#define INT_34XX_GPIO_BANK4	32
+#define INT_34XX_GPIO_BANK5	33
+#define INT_34XX_GPIO_BANK6	34
+#define INT_34XX_WDT3_IRQ	36
+#define INT_34XX_GPT12_IRQ	95
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
diff -purN linux-omap/include/asm-arm/arch-omap/mcbsp.h =
val_3430_GIT/include/asm-arm/arch-omap/mcbsp.h
--- linux-omap/include/asm-arm/arch-omap/mcbsp.h	2006-11-20 =
21:56:59.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/mcbsp.h	2007-05-25 =
22:59:27.000000000 -0500
@@ -83,7 +83,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
=20
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
=20
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
diff -purN linux-omap/include/asm-arm/arch-omap/memory.h =
val_3430_GIT/include/asm-arm/arch-omap/memory.h
--- linux-omap/include/asm-arm/arch-omap/memory.h	2006-12-17 =
08:56:42.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/memory.h	2007-05-25 =
22:59:27.000000000 -0500
@@ -38,7 +38,7 @@
  */
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #define PHYS_OFFSET		UL(0x80000000)
 #endif
=20
diff -purN linux-omap/include/asm-arm/arch-omap/serial.h =
val_3430_GIT/include/asm-arm/arch-omap/serial.h
--- linux-omap/include/asm-arm/arch-omap/serial.h	2006-11-20 =
21:56:59.000000000 -0600
+++ val_3430_GIT/include/asm-arm/arch-omap/serial.h	2007-05-25 =
22:59:27.000000000 -0500
@@ -20,6 +20,11 @@
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x4806e000
+#elif defined(CONFIG_ARCH_OMAP3)
+/* OMAP3 serial ports */
+#define OMAP_UART1_BASE		0x4806a000
+#define OMAP_UART2_BASE		0x4806c000
+#define OMAP_UART3_BASE		0x49020000
 #endif
=20
 #define OMAP_MAX_NR_PORTS	3
