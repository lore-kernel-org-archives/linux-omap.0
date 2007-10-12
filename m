From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [PATCH] To add WDT support for OMAP3430
Date: Fri, 12 Oct 2007 19:31:04 +0530
Message-ID: <001301c80cd8$54ea0030$248918ac@ent.ti.com>
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
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Add watchdog timer support for TI OMAP3430.

Fix clk_put functions mismatch in the release fn which would crash the
kernel if
the WDT test is run multiple times with "CONFIG_WATCHDOG_NOWAYOUT" disabled.

Fix the shutdown function.Check for wdt users before calling disable.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>

diff -purN omap-git/arch/arm/plat-omap/devices.c
omap-ti/arch/arm/plat-omap/devices.c
--- omap-git/arch/arm/plat-omap/devices.c	2007-09-24
10:09:16.000000000 -0400
+++ omap-ti/arch/arm/plat-omap/devices.c	2007-10-08
11:25:06.316435848 -0400
@@ -437,7 +437,9 @@ static inline void omap_init_uwire(void)
 
 #if	defined(CONFIG_OMAP_WATCHDOG) ||
defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP34XX)
+#define	OMAP_WDT_BASE		0x48314000
+#elif defined(CONFIG_ARCH_OMAP24XX)
 
 #ifdef CONFIG_ARCH_OMAP2430
 /* WDT2 */
diff -purN omap-git/drivers/char/watchdog/Kconfig
omap-ti/drivers/char/watchdog/Kconfig
--- omap-git/drivers/char/watchdog/Kconfig	2007-09-24
10:09:17.000000000 -0400
+++ omap-ti/drivers/char/watchdog/Kconfig	2007-10-11
04:08:26.695994096 -0400
@@ -173,10 +173,10 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
-	  Support for TI OMAP1610/OMAP1710/OMAP2420 watchdog.  Say 'Y' here
to
-	  enable the OMAP1610/OMAP1710 watchdog timer.
+	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog.  Say
'Y'
+	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog
timer.
 
 config PNX4008_WATCHDOG
 	tristate "PNX4008 Watchdog"
diff -purN omap-git/drivers/char/watchdog/omap_wdt.c
omap-ti/drivers/char/watchdog/omap_wdt.c
--- omap-git/drivers/char/watchdog/omap_wdt.c	2007-09-24
10:09:17.000000000 -0400
+++ omap-ti/drivers/char/watchdog/omap_wdt.c	2007-10-09
03:39:18.906291496 -0400
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/watchdog/omap_wdt.c
  *
- * Watchdog driver for the TI OMAP 16xx & 24xx 32KHz (non-secure) watchdog
+ * Watchdog driver for the TI OMAP 16xx & 24xx/34xx 32KHz (non-secure)
watchdog
  *
  * Author: MontaVista Software, Inc.
  *	 <gdavis@mvista.com> or <source@mvista.com>
@@ -146,7 +146,7 @@ static int omap_wdt_open(struct inode *i
 	if (cpu_is_omap16xx())
 		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface
clock */
 		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional
clock */
 	}
@@ -176,19 +176,12 @@ static int omap_wdt_release(struct inode
 
 	omap_wdt_disable(wdev);
 
-	if (cpu_is_omap16xx()) {
+	if (cpu_is_omap16xx())
 		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
-		clk_put(wdev->armwdt_ck);
-		wdev->armwdt_ck = NULL;
-	}
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
 		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
-		clk_put(wdev->mpu_wdt_ick);
-		clk_put(wdev->mpu_wdt_fck);
-		wdev->mpu_wdt_ick = NULL;
-		wdev->mpu_wdt_fck = NULL;
 	}
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
@@ -316,6 +309,21 @@ static int __init omap_wdt_probe(struct 
 			goto fail;
 		}
 	}
+
+	if (cpu_is_omap34xx()) {
+		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "wdt2_ick");
+		if (IS_ERR(wdev->mpu_wdt_ick)) {
+			ret = PTR_ERR(wdev->mpu_wdt_ick);
+			wdev->mpu_wdt_ick = NULL;
+			goto fail;
+		}
+		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "wdt2_fck");
+		if (IS_ERR(wdev->mpu_wdt_fck)) {
+			ret = PTR_ERR(wdev->mpu_wdt_fck);
+			wdev->mpu_wdt_fck = NULL;
+			goto fail;
+		}
+	}
 	wdev->base = (void __iomem *) (mem->start);
 	platform_set_drvdata(pdev, wdev);
 
@@ -363,7 +371,9 @@ static void omap_wdt_shutdown(struct pla
 {
 	struct omap_wdt_dev *wdev;
 	wdev = platform_get_drvdata(pdev);
-	omap_wdt_disable(wdev);
+
+	if (wdev->omap_wdt_users)
+		omap_wdt_disable(wdev);
 }
 
 static int omap_wdt_remove(struct platform_device *pdev)
@@ -374,12 +384,18 @@ static int omap_wdt_remove(struct platfo
 	misc_deregister(&(wdev->omap_wdt_miscdev));
 	release_resource(wdev->mem);
 	platform_set_drvdata(pdev, NULL);
-	if (wdev->armwdt_ck)
+	if (wdev->armwdt_ck) {
 		clk_put(wdev->armwdt_ck);
-	if (wdev->mpu_wdt_ick)
+		wdev->armwdt_ck = NULL;
+	}
+	if (wdev->mpu_wdt_ick) {
 		clk_put(wdev->mpu_wdt_ick);
-	if (wdev->mpu_wdt_fck)
+		wdev->mpu_wdt_ick = NULL;
+	}
+	if (wdev->mpu_wdt_fck) {
 		clk_put(wdev->mpu_wdt_fck);
+		wdev->mpu_wdt_fck = NULL;
+	}
 	kfree(wdev);
 	omap_wdt_dev = NULL;
 	return 0;
--- omap-git/arch/arm/configs/omap_3430sdp_defconfig	2007-10-03
10:35:37.000000000 -0400
+++ omap-ti/arch/arm/configs/omap_3430sdp_defconfig	2007-10-11
07:50:30.364488608 -0400
@@ -595,6 +595,7 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
