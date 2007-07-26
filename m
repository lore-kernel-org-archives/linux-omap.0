From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC 5/5] MMC/SD Controller driver for OMAP2430
Date: Wed, 25 Jul 2007 19:19:31 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A3485@dlee13.ent.ti.com>
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


plat-omap/device.c updated to support OMAP2430 MMC controller.

Regards,
Khasim
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

diff -purN linux-omap/arch/arm/plat-omap/devices.c =
lin_for_mmc/arch/arm/plat-omap/devices.c
--- linux-omap/arch/arm/plat-omap/devices.c	2007-07-11 =
09:55:17.000000000 -0500
+++ lin_for_mmc/arch/arm/plat-omap/devices.c	2007-07-24 =
00:59:14.000000000 -0500
@@ -19,6 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
=20
+#include <asm/arch/mmc.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
@@ -231,7 +232,11 @@ static inline void omap_init_kp(void) {}
 #endif
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
=20
+#if	defined(CONFIG_ARCH_OMAP2430)
+static struct omap_mmc_platform_data mmc1_conf;
+#else
 static struct omap_mmc_conf mmc1_conf;
+#endif
=20
 static u64 mmc1_dmamask =3D 0xffffffff;
=20
@@ -294,10 +299,18 @@ static void __init omap_init_mmc(void)
 	const struct omap_mmc_config	*mmc_conf;
 	const struct omap_mmc_conf	*mmc;
=20
-	/* REVISIT: 2430 has HS MMC */
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	/* REVISIT: 3430 HS MMC is TBD */
+	if (cpu_is_omap34xx())
 		return;
=20
+#if	defined(CONFIG_ARCH_OMAP2430)
+	if (cpu_is_omap243x()) {
+		if (mmc1_conf.enabled){
+			(void) platform_device_register(&mmc_omap_device1);
+		}
+		return;
+	}
+#else
 	/* NOTE:  assumes MMC was never (wrongly) enabled */
 	mmc_conf =3D omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
 	if (!mmc_conf)
@@ -306,7 +319,7 @@ static void __init omap_init_mmc(void)
 	/* block 1 is always available and has just one pinout option */
 	mmc =3D &mmc_conf->mmc[0];
 	if (mmc->enabled) {
-		if (cpu_is_omap24xx()) {
+		if (cpu_is_omap242x()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
 			omap_cfg_reg(H15_24XX_MMC_CLKI);
 			omap_cfg_reg(G19_24XX_MMC_CLKO);
@@ -324,7 +337,7 @@ static void __init omap_init_mmc(void)
 			}
 		}
 		if (mmc->wire4) {
-			if (cpu_is_omap24xx()) {
+			if (cpu_is_omap242x()) {
 				omap_cfg_reg(H14_24XX_MMC_DAT1);
 				omap_cfg_reg(E19_24XX_MMC_DAT2);
 				omap_cfg_reg(D19_24XX_MMC_DAT3);
@@ -344,7 +357,7 @@ static void __init omap_init_mmc(void)
 			 * Use internal loop-back in MMC/SDIO
 			 * Module Input Clock selection
 			 */
-			if (cpu_is_omap24xx()) {
+			if (cpu_is_omap242x()) {
 				u32 v =3D omap_readl(OMAP24XX_CONTROL_DEVCONF);
 				v |=3D (1 << 24);
 				omap_writel(v, OMAP24XX_CONTROL_DEVCONF);
@@ -353,6 +366,7 @@ static void __init omap_init_mmc(void)
 		mmc1_conf =3D *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
+#endif
=20
 #ifdef	CONFIG_ARCH_OMAP16XX
 	/* block 2 is on newer chips, and has many pinout options */
@@ -385,8 +399,27 @@ static void __init omap_init_mmc(void)
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data =
*info)
+{
+	switch (host) {
+	case 1:
+		mmc1_conf =3D *info;
+		break;
+#ifdef	CONFIG_ARCH_OMAP16XX
+	case 2:
+		mmc2_conf =3D *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
 #else
 static inline void omap_init_mmc(void) {}
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data =
*info)
+{
+}
 #endif
=20
 =
/*-----------------------------------------------------------------------=
--*/
