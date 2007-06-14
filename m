From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 6 / 12] Mach omap2 updation for 3430
Date: Thu, 14 Jun 2007 00:01:40 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E6095@dlee13.ent.ti.com>
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


Mach omap2 file updates for 3430

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 clock.h
 gpmc.c
 id.c
 io.c
 irq.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/clock.h =
val_3430_GIT/arch/arm/mach-omap2/clock.h
--- linux-omap/arch/arm/mach-omap2/clock.h	2007-05-25 15:52:23.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/clock.h	2007-06-12 =
15:12:08.000000000 -0500
@@ -39,6 +39,7 @@ static u32 omap2_clksel_get_divisor(stru
=20
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
+#define RATE_IN_343X	(1 << 2)
=20
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are =
mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
diff -purN linux-omap/arch/arm/mach-omap2/gpmc.c =
val_3430_GIT/arch/arm/mach-omap2/gpmc.c
--- linux-omap/arch/arm/mach-omap2/gpmc.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/gpmc.c	2007-06-12 =
15:12:08.000000000 -0500
@@ -22,12 +22,10 @@
=20
 #undef DEBUG
=20
-#ifdef CONFIG_ARCH_OMAP2420
+#if defined(CONFIG_ARCH_OMAP2420)
 #define GPMC_BASE		0x6800a000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define GPMC_BASE		0x6E000000
+#elif defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define GPMC_BASE		0x6e000000
 #endif
=20
 #define GPMC_REVISION		0x00
diff -purN linux-omap/arch/arm/mach-omap2/id.c =
val_3430_GIT/arch/arm/mach-omap2/id.c
--- linux-omap/arch/arm/mach-omap2/id.c	2006-11-20 21:54:01.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/id.c	2007-06-12 15:12:08.000000000 =
-0500
@@ -18,11 +18,11 @@
 #include <asm/io.h>
=20
 #if defined(CONFIG_ARCH_OMAP2420)
-#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
+#define TAP_BASE	io_p2v(0x48014000)
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define TAP_BASE	io_p2v(0x4900A000)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TAP_BASE	io_p2v(0x54004000)
 #endif
=20
 #define OMAP_TAP_IDCODE		0x0204
@@ -58,7 +58,7 @@ static struct omap_id omap_ids[] __initd
=20
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(OMAP24XX_TAP_BASE + reg);
+	return __raw_readl(TAP_BASE + reg);
 }
=20
 void __init omap2_check_revision(void)
@@ -118,9 +118,16 @@ void __init omap2_check_revision(void)
=20
 	system_rev |=3D rev << 8;
=20
-	/* Add the cpu class info (24xx) */
-	system_rev |=3D 0x24;
+	/* REVISIT:
+	 * OMAP 3430 ES 1.0 does't populate IDCODE registers
+	 * Following lines have to be revisited for next version
+	 */
=20
+#ifndef CONFIG_ARCH_OMAP3
+	system_rev |=3D 0x24;
+#else
+	system_rev |=3D 0x34;
+#endif
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
 		printk("%x", (system_rev >> 8) & 0x0f);
diff -purN linux-omap/arch/arm/mach-omap2/io.c =
val_3430_GIT/arch/arm/mach-omap2/io.c
--- linux-omap/arch/arm/mach-omap2/io.c	2007-05-30 14:02:43.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-06-12 15:12:08.000000000 =
-0500
@@ -4,8 +4,11 @@
  * OMAP2 I/O mapping code
  *
  * Copyright (C) 2005 Nokia Corporation
- * Author: Juha Yrjola<juha.yrjola@nokia.com>
- * Updated map desc to add 2430 support : <x0khasim@ti.com>
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Author:
+ *	Juha Yrjola <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -35,7 +38,9 @@ extern void omapfb_reserve_sdram(void);
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
  */
-static struct map_desc omap2_io_desc[] __initdata =3D {
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct map_desc omap24xx_io_desc[] __initdata =3D {
 	{
 		.virtual	=3D L3_24XX_VIRT,
 		.pfn		=3D __phys_to_pfn(L3_24XX_PHYS),
@@ -48,7 +53,34 @@ static struct map_desc omap2_io_desc[] _
 		.length		=3D L4_24XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
+};
+
+#ifdef CONFIG_ARCH_OMAP2420
+static struct map_desc omap242x_io_desc[] __initdata =3D {
+	{
+		.virtual	=3D DSP_MEM_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
+		.length		=3D DSP_MEM_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D DSP_IPI_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
+		.length		=3D DSP_IPI_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D DSP_MMU_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
+		.length		=3D DSP_MMU_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+};
+
+#endif
+
 #ifdef CONFIG_ARCH_OMAP2430
+static struct map_desc omap243x_io_desc[] __initdata =3D {
 	{
 		.virtual	=3D L4_WK_243X_VIRT,
 		.pfn		=3D __phys_to_pfn(L4_WK_243X_PHYS),
@@ -73,33 +105,74 @@ static struct map_desc omap2_io_desc[] _
 		.length		=3D OMAP243X_SMS_SIZE,
 		.type		=3D MT_DEVICE
 	},
+};
+#endif
 #endif
+
+#ifdef	CONFIG_ARCH_OMAP34XX
+static struct map_desc omap34xx_io_desc[] __initdata =3D {
 	{
-		.virtual	=3D DSP_MEM_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		=3D DSP_MEM_24XX_SIZE,
+		.virtual	=3D L3_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L3_34XX_PHYS),
+		.length		=3D L3_34XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
-#ifdef CONFIG_ARCH_OMAP2420
 	{
-		.virtual	=3D DSP_IPI_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		=3D DSP_IPI_24XX_SIZE,
+		.virtual	=3D L4_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_34XX_PHYS),
+		.length		=3D L4_34XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
-#endif
 	{
-		.virtual	=3D DSP_MMU_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		=3D DSP_MMU_24XX_SIZE,
+		.virtual	=3D L4_WK_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_WK_34XX_PHYS),
+		.length		=3D L4_WK_34XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D OMAP34XX_GPMC_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP34XX_GPMC_PHYS),
+		.length		=3D OMAP34XX_GPMC_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D OMAP343X_SMS_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP343X_SMS_PHYS),
+		.length		=3D OMAP343X_SMS_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D OMAP343X_SDRC_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP343X_SDRC_PHYS),
+		.length		=3D OMAP343X_SDRC_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D L4_PER_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_PER_34XX_PHYS),
+		.length		=3D L4_PER_34XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D L4_EMU_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_EMU_34XX_PHYS),
+		.length		=3D L4_EMU_34XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
 };
+#endif
=20
 void __init omap2_map_common_io(void)
 {
-	iotable_init(omap2_io_desc, ARRAY_SIZE(omap2_io_desc));
-
+#if defined(CONFIG_ARCH_OMAP2420)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
+#elif defined(CONFIG_ARCH_OMAP2430)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
+#elif defined(CONFIG_ARCH_OMAP34XX)
+	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
+#endif
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
 	 * revision check below.
diff -purN linux-omap/arch/arm/mach-omap2/irq.c =
val_3430_GIT/arch/arm/mach-omap2/irq.c
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-06-12 15:12:08.000000000 =
-0500
@@ -37,11 +37,9 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] =3D {
 	{
 		/* MPU INTC */
-		.base_reg	=3D IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	=3D 0,
 		.nr_irqs	=3D 96,
-	}, {
-		/* XXX: DSP INTC */
-	}
+	},
 };
=20
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -118,10 +116,16 @@ void __init omap_init_irq(void)
 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank =3D irq_banks + i;
=20
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+#ifdef CONFIG_ARCH_OMAP24XX
+		if (cpu_is_omap24xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
+		}
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+		if (cpu_is_omap34xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
+		}
+#endif
 		omap_irq_bank_init_one(bank);
=20
 		nr_irqs +=3D bank->nr_irqs;
