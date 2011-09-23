From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 11/11] arm/dts: OMAP3+: Add mpu, dsp and iva nodes
Date: Fri, 23 Sep 2011 22:23:19 +0200
Message-ID: <1316809399-19579-12-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48217 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab1IWUYw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:52 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add nodes for devices used by PM code (mpu, dsp, iva).

Add an empty cpus node as well as recommended in the DT spec.

Remove mpu, dsp, iva devices init if dt is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++++++++++
 Documentation/devicetree/bindings/arm/omap/iva.txt |   19 ++++++++++++++
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   27 ++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   19 ++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   23 +++++++++++++++++
 arch/arm/mach-omap2/pm.c                           |    3 +-
 6 files changed, 104 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dsp.txt b/Documentation/devicetree/bindings/arm/omap/dsp.txt
new file mode 100644
index 0000000..325feef
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dsp.txt
@@ -0,0 +1,14 @@
+* TI - DSP (Digital Signal Processor)
+
+TI DSP included in OMAP SoC
+
+Required properties:
+- compatible : Should be "ti,omap3-c64" for OMAP3 & 4
+- ti,hwmods: "dsp"
+
+Examples:
+
+dsp {
+    compatible = "ti,omap3-c64";
+    ti,hwmods = "dsp";
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/iva.txt b/Documentation/devicetree/bindings/arm/omap/iva.txt
new file mode 100644
index 0000000..b889475
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/iva.txt
@@ -0,0 +1,19 @@
+* TI - IVA (Imaging and Video Accelerator) subsystem
+
+The IVA contain various audio, video or imaging HW accelerator
+depending of the version.
+
+Required properties:
+- compatible : Should be:
+  - "ti,ivahd" for OMAP4
+  - "ti,iva2.2" for OMAP3
+  - "ti,iva2.1" for OMAP2430
+  - "ti,iva1" for OMAP2420
+- ti,hwmods: "iva"
+
+Examples:
+
+iva {
+    compatible = "ti,ivahd", "ti,iva";
+    ti,hwmods = "iva";
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/mpu.txt b/Documentation/devicetree/bindings/arm/omap/mpu.txt
new file mode 100644
index 0000000..5ffbacd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/mpu.txt
@@ -0,0 +1,27 @@
+* TI - MPU (Main Processor Unit) subsystem
+
+The MPU subsystem contain one or several ARM cores
+depending of the version.
+The MPU contain CPUs, GIC, L2 cache and a local PRCM.
+
+Required properties:
+- compatible : Should be "ti,omap3-mpu" for OMAP3
+               Should be "ti,omap4-mpu" for OMAP4
+- ti,hwmods: "mpu"
+
+Examples:
+
+- For an OMAP4 SMP system:
+
+mpu {
+    compatible = "ti,omap4-mpu";
+    ti,hwmods = "mpu";
+};
+
+
+- For an OMAP3 monocore system:
+
+mpu {
+    compatible = "ti,omap3-mpu";
+    ti,hwmods = "mpu";
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d558785..d202bb5 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -13,12 +13,31 @@
 / {
 	compatible = "ti,omap3430", "ti,omap3";
 
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a8";
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
 		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap3-mpu";
+			ti,hwmods = "mpu";
+		};
+
+		iva {
+			compatible = "ti,iva2.2";
+			ti,hwmods = "iva";
+
+			dsp {
+				compatible = "ti,omap3-c64";
+			};
+		};
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index b85a39d..4c61c82 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -23,12 +23,35 @@
 	aliases {
 	};
 
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
 		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap4-mpu";
+			ti,hwmods = "mpu";
+		};
+
+		dsp {
+			compatible = "ti,omap3-c64";
+			ti,hwmods = "dsp";
+		};
+
+		iva {
+			compatible = "ti,ivahd";
+			ti,hwmods = "iva";
+		};
 	};
 
 	/*
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1fd9576..640c266 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -217,7 +217,8 @@ static void __init omap4_init_voltages(void)
 
 static int __init omap2_common_pm_init(void)
 {
-	omap2_init_processor_devices();
+	if (!of_have_populated_dt())
+		omap2_init_processor_devices();
 	omap_pm_if_init();
 
 	return 0;
-- 
1.7.0.4

