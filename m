From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC] io.c for OMAP3430
Date: Tue, 29 May 2007 23:12:59 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470106287E@dlee13.ent.ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I have incorporated your review comments for io.c.=20

Please do let me know if you find any further issues.

I have incorporated other review comments from Andrew and Trilok, will =
regenerate and publish
the patch set once we agree upon these (irq.c and io.c) patch set.

Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/mach-omap2/io.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-05-29 22:57:44.000000000 =
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
@@ -35,6 +38,7 @@ extern void omapfb_reserve_sdram(void);
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
  */
+#ifdef CONFIG_ARCH_OMAP24XX
 static struct map_desc omap2_io_desc[] __initdata =3D {
 	{
 		.virtual	=3D L3_24XX_VIRT,
@@ -95,6 +99,60 @@ static struct map_desc omap2_io_desc[] _
 		.type		=3D MT_DEVICE
 	},
 };
+#endif
+
+#ifdef	CONFIG_ARCH_OMAP34XX
+static struct map_desc omap2_io_desc[] __initdata =3D {
+	{
+		.virtual	=3D L3_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L3_34XX_PHYS),
+		.length		=3D L3_34XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D L4_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_34XX_PHYS),
+		.length		=3D L4_34XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
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
+		.type		=3D MT_DEVICE
+	},
+};
+#endif
=20
 void __init omap2_map_common_io(void)
 {
