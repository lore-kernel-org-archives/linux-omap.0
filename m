From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/6] PM / AVS / OMAP: move Kconfig definition of smartreflex to avs directory
Date: Mon, 5 Nov 2012 09:02:09 -0600
Message-ID: <1352127734-30103-3-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620Ab2KEPCk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 10:02:40 -0500
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Don't see why the source should be in drivers/power/avs, but not config option

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/Kconfig |   22 ----------------------
 drivers/power/avs/Kconfig  |   22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 82fcb20..b49cff3 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -47,28 +47,6 @@ config OMAP_DEBUG_LEDS
 	depends on OMAP_DEBUG_DEVICES
 	select LEDS_CLASS
 
-config POWER_AVS_OMAP
-	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
-	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
-	select POWER_SUPPLY
-	help
-	  Say Y to enable AVS(Adaptive Voltage Scaling)
-	  support on OMAP containing the version 1 or
-	  version 2 of the SmartReflex IP.
-	  V1 is the 65nm version used in OMAP3430.
-	  V2 is the update for the 45nm version of the IP used in OMAP3630
-	  and OMAP4430
-
-	  Please note, that by default SmartReflex is only
-	  initialized and not enabled. To enable the automatic voltage
-	  compensation for vdd mpu and vdd core from user space,
-	  user must write 1 to
-		/debug/smartreflex/sr_<X>/autocomp,
-	  where X is mpu_iva or core for OMAP3.
-	  Optionally autocompensation can be enabled in the kernel
-	  by default during system init via the enable_on_init flag
-	  which an be passed as platform data to the smartreflex driver.
-
 config POWER_AVS_OMAP_CLASS3
 	bool "Class 3 mode of Smartreflex Implementation"
 	depends on POWER_AVS_OMAP && TWL4030_CORE
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 2a1008b..466a391 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -10,3 +10,25 @@ menuconfig POWER_AVS
 	  AVS is also called SmartReflex on OMAP devices.
 
 	  Say Y here to enable Adaptive Voltage Scaling class support.
+
+config POWER_AVS_OMAP
+	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
+	depends on POWER_AVS && (ARCH_OMAP3 || ARCH_OMAP4) && PM
+	select POWER_SUPPLY
+	help
+	  Say Y to enable AVS(Adaptive Voltage Scaling)
+	  support on OMAP containing the version 1 or
+	  version 2 of the SmartReflex IP.
+	  V1 is the 65nm version used in OMAP3430.
+	  V2 is the update for the 45nm version of the IP used in OMAP3630
+	  and OMAP4430
+
+	  Please note, that by default SmartReflex is only
+	  initialized and not enabled. To enable the automatic voltage
+	  compensation for vdd mpu and vdd core from user space,
+	  user must write 1 to
+		/debug/smartreflex/sr_<X>/autocomp,
+	  where X is mpu_iva or core for OMAP3.
+	  Optionally autocompensation can be enabled in the kernel
+	  by default during system init via the enable_on_init flag
+	  which an be passed as platform data to the smartreflex driver.
-- 
1.7.9.5

