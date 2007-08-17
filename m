From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [08/17 PATCH] PLAT: OMAP: Modifications at
 arch/arm/plat-omap/devices.c to use multislot structures.
Date: Fri, 17 Aug 2007 15:02:01 -0400
Message-ID: <46C5F0A9.5010303@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070805000101090907010106"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070805000101090907010106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Modifications at arch/arm/plat-omap/devices.c to use multislot structures.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

--------------070805000101090907010106
Content-Type: text/x-patch;
	name*0="0008-PLAT-OMAP-Modifications-at-devices.c-to-use-multislot-struc";
	name*1="tures.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0008-PLAT-OMAP-Modifications-at-devices.c-to-use-multislot-s";
	filename*1="tructures.patch"

Modifications at arch/arm/plat-omap/devices.c to use multislot structures

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Index: linux-omap/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/devices.c	2007-08-07 10:20:13.000000000 -0400
+++ linux-omap/arch/arm/plat-omap/devices.c	2007-08-13 12:20:12.000000000 -0400
@@ -21,6 +21,7 @@
 
 #include <asm/arch/tc.h>
 #include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
@@ -231,7 +232,7 @@ static inline void omap_init_kp(void) {}
 #endif
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
-static struct omap_mmc_conf mmc1_conf;
+static struct omap_mmc_platform_data mmc1_data;
 
 static u64 mmc1_dmamask = 0xffffffff;
 
@@ -252,7 +253,7 @@ static struct platform_device mmc_omap_d
 	.id		= 1,
 	.dev = {
 		.dma_mask	= &mmc1_dmamask,
-		.platform_data	= &mmc1_conf,
+		.platform_data	= &mmc1_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc1_resources),
 	.resource	= mmc1_resources,
@@ -260,7 +261,7 @@ static struct platform_device mmc_omap_d
 
 #ifdef	CONFIG_ARCH_OMAP16XX
 
-static struct omap_mmc_conf mmc2_conf;
+static struct omap_mmc_platform_data mmc2_data;
 
 static u64 mmc2_dmamask = 0xffffffff;
 
@@ -282,7 +283,7 @@ static struct platform_device mmc_omap_d
 	.id		= 2,
 	.dev = {
 		.dma_mask	= &mmc2_dmamask,
-		.platform_data	= &mmc2_conf,
+		.platform_data	= &mmc2_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc2_resources),
 	.resource	= mmc2_resources,
@@ -291,20 +292,14 @@ static struct platform_device mmc_omap_d
 
 static void __init omap_init_mmc(void)
 {
-	const struct omap_mmc_config	*mmc_conf;
-	const struct omap_mmc_conf	*mmc;
+	const struct omap_mmc_platform_data     *mmc;
 
 	/* REVISIT: 2430 has HS MMC */
 	if (cpu_is_omap2430() || cpu_is_omap34xx())
 		return;
 
-	/* NOTE:  assumes MMC was never (wrongly) enabled */
-	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
-	if (!mmc_conf)
-		return;
-
 	/* block 1 is always available and has just one pinout option */
-	mmc = &mmc_conf->mmc[0];
+	mmc = &mmc1_data;
 	if (mmc->enabled) {
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
@@ -339,24 +334,12 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
-		if (mmc->internal_clock) {
-			/*
-			 * Use internal loop-back in MMC/SDIO
-			 * Module Input Clock selection
-			 */
-			if (cpu_is_omap24xx()) {
-				u32 v = omap_readl(OMAP24XX_CONTROL_DEVCONF);
-				v |= (1 << 24);
-				omap_writel(v, OMAP24XX_CONTROL_DEVCONF);
-			}
-		}
-		mmc1_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
 
 #ifdef	CONFIG_ARCH_OMAP16XX
 	/* block 2 is on newer chips, and has many pinout options */
-	mmc = &mmc_conf->mmc[1];
+	mmc = &mmc2_data;
 	if (mmc->enabled) {
 		if (!mmc->nomux) {
 			omap_cfg_reg(Y8_1610_MMC2_CMD);
@@ -379,12 +362,28 @@ static void __init omap_init_mmc(void)
 		if (cpu_is_omap1710())
 			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
 				     MOD_CONF_CTRL_1);
-		mmc2_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device2);
 	}
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
+{
+	switch (host) {
+	case 1:
+		mmc1_data = *info;
+		break;
+#ifdef CONFIG_ARCH_OMAP16XX
+	case 2:
+		mmc2_data = *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
+
 #else
 static inline void omap_init_mmc(void) {}
 #endif

--------------070805000101090907010106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070805000101090907010106--
