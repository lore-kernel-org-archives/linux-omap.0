From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH  3/4] MMC/SD Controller driver for OMAP2430
Date: Tue, 11 Dec 2007 12:18:55 +0530
Message-ID: <001e01c83bc1$e66eb100$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I am reposting the patch after removing the ifdefs pointed out by you.

Thanks,
Madhu
--------------------------------------------------------------------------------


This patch registers the MMC device for OMAP2430/3430.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 arch/arm/plat-omap/devices.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Index: Madhu-linux-mmc/arch/arm/plat-omap/devices.c
===================================================================
--- Madhu-linux-mmc.orig/arch/arm/plat-omap/devices.c	2007-12-06 16:04:39.000000000 +0530
+++ Madhu-linux-mmc/arch/arm/plat-omap/devices.c	2007-12-11 12:05:27.521559900 +0530
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
@@ -239,6 +236,13 @@
 
 	/* block 1 is always available and has just one pinout option */
 	mmc = &mmc_conf->mmc[0];
+
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device1);
+		return;
+	}
+
 	if (mmc->enabled) {
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
@@ -339,6 +343,7 @@
 }
 
 #else
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
 static inline void omap_init_mmc(void) {}
 #endif
 
