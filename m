From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
Date: Thu, 1 Sep 2011 19:25:07 +0200
Message-ID: <1314897912-18178-3-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35551 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab1IARZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:25:36 -0400
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Add nodes for devices used by PM code (mpu, iva).
In the case of OMAP3, the dsp was included inside the IVA2.2.

Add an empty cpus node as well as recommended in the DT spec.

Remove mpu and iva devices init if CONFIG_OF is defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c     |    6 ++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1b27925..5a95a69 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -14,11 +14,35 @@
 	compatible = "ti,omap3430", "ti,omap3";
 
 	/*
+	 * XXX: The cpus node is mandatory, but since the CPUs are as well part
+	 * of the mpu subsystem below, it is not clear where the information
+	 * should be. Maybe here with a phandle inside the mpu?
+	 */
+	cpus {
+	};
+
+	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
 		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap3-mpu";
+			hwmods = "mpu";
+			cpu@0 {
+				compatible = "arm,cortex-a8";
+			};
+		};
+
+		iva {
+			compatible = "ti,iva22", "ti,iva";
+			hwmods = "iva";
+
+			dsp {
+				compatible = "ti,omap3-c64", "ti,c64";
+			};
+		};
 	};
 
 	/*
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index ba4d187..1fdde69 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -24,6 +24,7 @@
 #include "clockdomain.h"
 #include "pm.h"
 
+#ifndef CONFIG_OF
 static struct omap_device_pm_latency *pm_lats;
 
 static int _init_omap_device(char *name)
@@ -53,17 +54,18 @@ static void omap2_init_processor_devices(void)
 		_init_omap_device("iva");
 
 	if (cpu_is_omap44xx()) {
-#ifndef CONFIG_OF
 		_init_omap_device("mpu");
 		_init_omap_device("l3_main_1");
 		_init_omap_device("dsp");
 		_init_omap_device("iva");
-#endif
 	} else {
 		_init_omap_device("mpu");
 		_init_omap_device("l3_main");
 	}
 }
+#else
+static void omap2_init_processor_devices(void) {}
+#endif
 
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
-- 
1.7.0.4

