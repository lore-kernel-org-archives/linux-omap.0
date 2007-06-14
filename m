From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Pre 3430 patch for io.c map table cleanup
Date: Thu, 14 Jun 2007 16:16:01 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E65C4@dlee13.ent.ti.com>
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

Cleanup map descriptor table in io.c for 2420 and 2430

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/io.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- linux-omap/arch/arm/mach-omap2/io.c	2007-05-30 14:02:43.000000000 =
-0500
+++ lin_for_mmc/arch/arm/mach-omap2/io.c	2007-06-14 15:40:42.000000000 =
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
@@ -73,33 +105,19 @@ static struct map_desc omap2_io_desc[] _
 		.length		=3D OMAP243X_SMS_SIZE,
 		.type		=3D MT_DEVICE
 	},
+};
 #endif
-	{
-		.virtual	=3D DSP_MEM_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		=3D DSP_MEM_24XX_SIZE,
-		.type		=3D MT_DEVICE
-	},
-#ifdef CONFIG_ARCH_OMAP2420
-	{
-		.virtual	=3D DSP_IPI_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		=3D DSP_IPI_24XX_SIZE,
-		.type		=3D MT_DEVICE
-	},
 #endif
-	{
-		.virtual	=3D DSP_MMU_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		=3D DSP_MMU_24XX_SIZE,
-		.type		=3D MT_DEVICE
-	},
-};
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
+#endif
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
 	 * revision check below.
