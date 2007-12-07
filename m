From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH  3/4] MMC/SD Controller driver for OMAP2430
Date: Fri, 7 Dec 2007 19:20:52 +0530
Message-ID: <003b01c838d8$2e8bbba0$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch registers the MMC device for OMAP2430/3430.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 arch/arm/plat-omap/devices.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c	2007-12-06 16:04:39.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/devices.c	2007-12-07 11:15:50.567693917 +0530
@@ -19,6 +19,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
+#include <asm/arch/mmc.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/board.h>
 #include <asm/arch/mmc.h>
@@ -156,7 +157,7 @@
 
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define	OMAP_MMC1_BASE		0x4809c000
 #define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
 #else
@@ -228,10 +229,6 @@
 	const struct omap_mmc_config	*mmc_conf;
 	const struct omap_mmc_conf	*mmc;
 
-	/* REVISIT: 2430 has HS MMC */
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
-		return;
-
 	/* NOTE:  assumes MMC was never (wrongly) enabled */
 	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
 	if (!mmc_conf)
@@ -239,6 +236,15 @@
 
 	/* block 1 is always available and has just one pinout option */
 	mmc = &mmc_conf->mmc[0];
+
+#if     defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device1);
+		return;
+	}
+#else
 	if (mmc->enabled) {
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
@@ -289,7 +295,7 @@
 		mmc1_data.conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
-
+#endif
 #ifdef	CONFIG_ARCH_OMAP16XX
 	/* block 2 is on newer chips, and has many pinout options */
 	mmc = &mmc_conf->mmc[1];
@@ -339,6 +345,7 @@
 }
 
 #else
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
 static inline void omap_init_mmc(void) {}
 #endif
 
