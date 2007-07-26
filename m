From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC 3/5] MMC/SD Controller driver for OMAP2430
Date: Wed, 25 Jul 2007 19:19:10 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A3483@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Continuing with rest of the patch series on linux.omap.com.=20

This should help others in getting MMC/SD working on 2430 SDP.

Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/Makefile =
lin_for_mmc/arch/arm/mach-omap2/Makefile
--- linux-omap/arch/arm/mach-omap2/Makefile	2007-07-11 =
09:55:16.000000000 -0500
+++ lin_for_mmc/arch/arm/mach-omap2/Makefile	2007-07-18 =
12:00:31.000000000 -0500
@@ -22,7 +22,8 @@ obj-$(CONFIG_MACH_OMAP_GENERIC)		+=3D boar
 obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o \
 					   board-2430sdp-flash.o \
-					   board-2430sdp-usb.o
+					   board-2430sdp-usb.o \
+					   board-sdp-hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o

diff -purN linux-omap/arch/arm/mach-omap2/board-2430sdp.c =
lin_for_mmc/arch/arm/mach-omap2/board-2430sdp.c
--- linux-omap/arch/arm/mach-omap2/board-2430sdp.c	2007-06-08 =
08:09:33.000000000 -0500
+++ lin_for_mmc/arch/arm/mach-omap2/board-2430sdp.c	2007-07-25 =
18:27:32.000000000 -0500
@@ -31,6 +31,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
=20
+#include <asm/arch/mmc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
@@ -53,6 +54,8 @@
=20
 #define TWL4030_MSECURE_GPIO	118
=20
+extern void __init sdp_mmc_init(void);
+
 static struct mtd_partition sdp2430_partitions[] =3D {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -441,6 +444,7 @@ static void __init omap_2430sdp_init(voi
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
 	ads7846_dev_init();
+	sdp_mmc_init();
 }
=20
 static void __init omap_2430sdp_map_io(void)

diff -purN linux-omap/arch/arm/mach-omap2/clock.h =
lin_for_mmc/arch/arm/mach-omap2/clock.h
--- linux-omap/arch/arm/mach-omap2/clock.h	2007-07-11 09:55:16.000000000 =
-0500
+++ lin_for_mmc/arch/arm/mach-omap2/clock.h	2007-07-20 =
00:38:39.000000000 -0500
@@ -1901,7 +1901,8 @@ static struct clk usbhs_ick =3D {
 };
=20
 static struct clk mmchs1_ick =3D {
-	.name		=3D "mmchs1_ick",
+	.name		=3D "mmchs_ick",
+	.id             =3D 1,
 	.parent		=3D &l4_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1910,7 +1911,8 @@ static struct clk mmchs1_ick =3D {
 };
=20
 static struct clk mmchs1_fck =3D {
-	.name		=3D "mmchs1_fck",
+	.name		=3D "mmchs_fck",
+	.id             =3D 1,
 	.parent		=3D &func_96m_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1919,7 +1921,8 @@ static struct clk mmchs1_fck =3D {
 };
=20
 static struct clk mmchs2_ick =3D {
-	.name		=3D "mmchs2_ick",
+	.name		=3D "mmchs_ick",
+	.id             =3D 2,
 	.parent		=3D &l4_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1928,7 +1931,8 @@ static struct clk mmchs2_ick =3D {
 };
=20
 static struct clk mmchs2_fck =3D {
-	.name		=3D "mmchs2_fck",
+	.name		=3D "mmchs_fck",
+	.id             =3D 2,
 	.parent		=3D &func_96m_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1964,7 +1968,8 @@ static struct clk mdm_intc_ick =3D {
 };
=20
 static struct clk mmchsdb1_fck =3D {
-	.name		=3D "mmchsdb1_fck",
+	.name		=3D "mmchsdb_fck",
+	.id             =3D 1,
 	.parent		=3D &func_32k_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1973,7 +1978,8 @@ static struct clk mmchsdb1_fck =3D {
 };
=20
 static struct clk mmchsdb2_fck =3D {
-	.name		=3D "mmchsdb2_fck",
+	.name		=3D "mmchsdb_fck",
+	.id             =3D 2,
 	.parent		=3D &func_32k_ck,
 	.flags		=3D CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),

diff -purN linux-omap/drivers/mmc/host/Makefile =
lin_for_mmc/drivers/mmc/host/Makefile
--- linux-omap/drivers/mmc/host/Makefile	2007-05-07 20:59:45.000000000 =
-0500
+++ lin_for_mmc/drivers/mmc/host/Makefile	2007-07-13 11:53:07.000000000 =
-0500
@@ -12,7 +12,12 @@ obj-$(CONFIG_MMC_IMX)		+=3D imxmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
 obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+=3D au1xmmc.o
-obj-$(CONFIG_MMC_OMAP)		+=3D omap.o
+
+ifeq ($(CONFIG_ARCH_OMAP2430),y)
+	obj-$(CONFIG_MMC_OMAP)		+=3D omap_hsmmc.o
+else
+	obj-$(CONFIG_MMC_OMAP)		+=3D omap.o
+endif
+
 obj-$(CONFIG_MMC_AT91)		+=3D at91_mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+=3D tifm_sd.o
-
