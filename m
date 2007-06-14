From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] MAP descriptor table for 3430
Date: Thu, 14 Jun 2007 16:20:29 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E65CD@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adding map descriptor table for 3430

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/io.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- lin_for_mmc/arch/arm/mach-omap2/io.c	2007-06-14 15:40:42.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-06-12 15:12:08.000000000 =
-0500
@@ -109,6 +109,59 @@ static struct map_desc omap243x_io_desc[
 #endif
 #endif
=20
+#ifdef	CONFIG_ARCH_OMAP34XX
+static struct map_desc omap34xx_io_desc[] __initdata =3D {
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
+
 void __init omap2_map_common_io(void)
 {
 #if defined(CONFIG_ARCH_OMAP2420)
@@ -117,6 +170,8 @@ void __init omap2_map_common_io(void)
 #elif defined(CONFIG_ARCH_OMAP2430)
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
+#elif defined(CONFIG_ARCH_OMAP34XX)
+	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 #endif
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
