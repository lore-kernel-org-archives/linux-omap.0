From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: ti-soc: Kconfig fix to avoid menu showing wrongly
Date: Wed,  9 Sep 2015 21:17:39 -0700
Message-ID: <1441858659-7353-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Move the dependencies to menu, so we avoid showing it wrongly.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig                | 1 +
 drivers/thermal/ti-soc-thermal/Kconfig | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)
---

This depends on the compile test series.

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a752bef..c5eb142 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -341,6 +341,7 @@ config ACPI_THERMAL_REL
 	depends on ACPI
 
 menu "Texas Instruments thermal drivers"
+depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index 7a24018..cb6686f 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -1,7 +1,5 @@
 config TI_SOC_THERMAL
 	tristate "Texas Instruments SoCs temperature sensor driver"
-	depends on THERMAL
-	depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  OMAP4460+ on die bandgap temperature sensor support. The register
-- 
2.5.0
