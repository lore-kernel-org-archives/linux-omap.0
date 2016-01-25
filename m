From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 19/22] thermal: Fix dependencies for !HAS_IOMEM
	archs
Date: Mon, 25 Jan 2016 23:24:18 +0100
Message-ID: <1453760661-1444-20-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/thermal/Kconfig                | 7 +++++++
 drivers/thermal/ti-soc-thermal/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8cc4ac6..8876c7e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -178,6 +178,7 @@ config THERMAL_EMULATION
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
@@ -198,6 +199,7 @@ config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
 	  thermal framework.
@@ -206,6 +208,7 @@ config ROCKCHIP_THERMAL
 	tristate "Rockchip thermal driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  Rockchip thermal driver provides support for Temperature sensor
 	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
@@ -224,6 +227,7 @@ config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
 	  framework. Only kirkwood 88F6282 and 88F6283 have this sensor.
@@ -232,6 +236,7 @@ config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
 	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
 	  framework.
@@ -250,6 +255,7 @@ config ARMADA_THERMAL
 	tristate "Armada 370/XP thermal management"
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
@@ -372,6 +378,7 @@ endmenu
 
 menu "Samsung thermal drivers"
 depends on ARCH_EXYNOS || COMPILE_TEST
+depends on HAS_IOMEM
 source "drivers/thermal/samsung/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index ea8283f..283d794 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -1,5 +1,6 @@
 config TI_SOC_THERMAL
 	tristate "Texas Instruments SoCs temperature sensor driver"
+	depends on HAS_IOMEM
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  OMAP4460+ on die bandgap temperature sensor support. The register
-- 
1.8.4.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
