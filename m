From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 17/17] thermal: ti-soc: allow compile test
Date: Wed,  9 Sep 2015 21:11:13 -0700
Message-ID: <1441858273-4017-18-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Adding COMPILE_TEST flag to ti-soc driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/ti-soc-thermal/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index bd4c7be..7a24018 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -1,7 +1,7 @@
 config TI_SOC_THERMAL
 	tristate "Texas Instruments SoCs temperature sensor driver"
 	depends on THERMAL
-	depends on ARCH_HAS_BANDGAP
+	depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  OMAP4460+ on die bandgap temperature sensor support. The register
@@ -24,7 +24,7 @@ config TI_THERMAL
 config OMAP4_THERMAL
 	bool "Texas Instruments OMAP4 thermal support"
 	depends on TI_SOC_THERMAL
-	depends on ARCH_OMAP4
+	depends on ARCH_OMAP4 || COMPILE_TEST
 	help
 	  If you say yes here you get thermal support for the Texas Instruments
 	  OMAP4 SoC family. The current chip supported are:
@@ -38,7 +38,7 @@ config OMAP4_THERMAL
 config OMAP5_THERMAL
 	bool "Texas Instruments OMAP5 thermal support"
 	depends on TI_SOC_THERMAL
-	depends on SOC_OMAP5
+	depends on SOC_OMAP5 || COMPILE_TEST
 	help
 	  If you say yes here you get thermal support for the Texas Instruments
 	  OMAP5 SoC family. The current chip supported are:
@@ -50,7 +50,7 @@ config OMAP5_THERMAL
 config DRA752_THERMAL
 	bool "Texas Instruments DRA752 thermal support"
 	depends on TI_SOC_THERMAL
-	depends on SOC_DRA7XX
+	depends on SOC_DRA7XX || COMPILE_TEST
 	help
 	  If you say yes here you get thermal support for the Texas Instruments
 	  DRA752 SoC family. The current chip supported are:
-- 
2.5.0
