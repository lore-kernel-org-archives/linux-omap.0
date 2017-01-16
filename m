From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] thermal: ti-soc-thermal: Remove CPU_THERMAL Dependency from TI_THERMAL
Date: Mon, 16 Jan 2017 15:43:02 +0530
Message-ID: <1484561582-5101-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Currently when CPU_THERMAL is not defined the thermal sensors
are not even exposed consequently no cooling is possible. CPU_THERMAL
eventually depends on CPUFREQ. CPPUFREQ is not the only cooling
for CPU.

The thermal shutdown for critical temperatures is another
cooling solution which will currently not get enabled if CPU_THERMAL
is not defined. Remove this dependency so as to have the last level
of thermal protection working even without CPUFREQ defined.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index ea8283f..fe0e877 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -11,7 +11,6 @@ config TI_SOC_THERMAL
 config TI_THERMAL
 	bool "Texas Instruments SoCs thermal framework support"
 	depends on TI_SOC_THERMAL
-	depends on CPU_THERMAL
 	help
 	  If you say yes here you want to get support for generic thermal
 	  framework for the Texas Instruments on die bandgap temperature sensor.
-- 
1.9.1

