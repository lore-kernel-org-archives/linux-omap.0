From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 1/6] PM / AVS / OMAP: move Kconfig definition of smartreflex to avs directory
Date: Tue, 23 Oct 2012 16:43:56 -0500
Message-ID: <1351028641-20832-2-git-send-email-nm@ti.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46625 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2JWVoH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 17:44:07 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NLi6EU019276
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NLi6cV028643
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
In-Reply-To: <1351028641-20832-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>

Don't see why the source should be in drivers/power/avs, but not
config option

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/Kconfig |   22 ----------------------
 drivers/power/avs/Kconfig  |   22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 7cd56ed..e5e7520 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -46,28 +46,6 @@ config OMAP_DEBUG_LEDS
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

