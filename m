From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 04/10] arm/dts: OMAP4: Add mpu, dsp and iva nodes
Date: Wed, 24 Aug 2011 15:09:10 +0200
Message-ID: <1314191356-10963-5-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51989 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab1HXNLO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 09:11:14 -0400
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add nodes for devices used by PM code (mpu, dsp, iva).

Add an empty cpus node as well as recommended in the DT spec.

Remove mpu, dsp, iva devices init if CONFIG_OF is defined.
Ideally the whole function should be removed. It will be doable as
soon as the OMAP3 DT support will be added.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c     |    5 ++++-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 928a74c..a3efe76 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -25,11 +25,39 @@
 	};
 
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
+			compatible = "ti,omap4-mpu";
+			hwmods = "mpu";
+			cpu@0 {
+				compatible = "arm,cortex-a9";
+			};
+			cpu@1 {
+				compatible = "arm,cortex-a9";
+			};
+		};
+
+		dsp {
+			compatible = "ti,omap4-c64", "ti,c64";
+			hwmods = "dsp";
+		};
+
+		iva {
+			compatible = "ti,ivahd", "ti,iva";
+			hwmods = "iva";
+		};
 	};
 
 	/*
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 832577a..ba4d187 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -49,15 +49,18 @@ static int _init_omap_device(char *name)
  */
 static void omap2_init_processor_devices(void)
 {
-	_init_omap_device("mpu");
 	if (omap3_has_iva())
 		_init_omap_device("iva");
 
 	if (cpu_is_omap44xx()) {
+#ifndef CONFIG_OF
+		_init_omap_device("mpu");
 		_init_omap_device("l3_main_1");
 		_init_omap_device("dsp");
 		_init_omap_device("iva");
+#endif
 	} else {
+		_init_omap_device("mpu");
 		_init_omap_device("l3_main");
 	}
 }
-- 
1.7.0.4

