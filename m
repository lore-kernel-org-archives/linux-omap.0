From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/9] omap4: sdp: Pass regulator data from dt
Date: Tue, 27 Sep 2011 15:42:46 +0530
Message-ID: <1317118372-17052-4-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1I0KNp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 06:13:45 -0400
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

Pass adjustable regulator information for omap4sdp from device tree so the
regulator driver can then use the regulator helper
routine to extract and use them during the driver probe().

Also add documentation for TWL regulator specific bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../bindings/regulator/twl-regulator.txt           |   60 ++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   64 ++++++++++++++++++++
 2 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
new file mode 100644
index 0000000..7b809ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -0,0 +1,60 @@
+TWL family of regulators
+
+Required properties:
+- compatible:
+  - "ti,twl4030" for twl4030 regulators
+  - "ti,twl6025" for twl6025 regulators
+  - "ti,twl6030" for twl6030 regulators
+
+Additionally compatible can be used to specify the
+exact regulator/ldo instance like
+For twl6030 regulators/LDO's
+- compatible:
+  - "ti,twl6030-vaux1" for VAUX1 LDO
+  - "ti,twl6030-vaux2" for VAUX2 LDO
+  - "ti,twl6030-vaux3" for VAUX3 LDO
+  - "ti,twl6030-vmmc" for VMMC LDO
+  - "ti,twl6030-vpp" for VPP LDO
+  - "ti,twl6030-vusim" for VUSIM LDO
+For twl6025 regulators/LDO's
+- compatible:
+  - "ti,twl6025-ldo1" for LDO1 LDO
+  - "ti,twl6025-ldo2" for LDO2 LDO
+  - "ti,twl6025-ldo3" for LDO3 LDO
+  - "ti,twl6025-ldo4" for LDO4 LDO
+  - "ti,twl6025-ldo5" for LDO5 LDO
+  - "ti,twl6025-ldo6" for LDO6 LDO
+  - "ti,twl6025-ldo7" for LDO7 LDO
+  - "ti,twl6025-ldoln" for LDOLN LDO
+  - "ti,twl6025-ldousb" for LDOUSB LDO
+For twl4030 regulators/LDO's
+- compatible:
+  - "ti,twl4030-vaux1" for VAUX1 LDO
+  - "ti,twl4030-vaux2" for VAUX2 LDO
+  - "ti,twl5030-vaux2" for VAUX2 LDO
+  - "ti,twl4030-vaux3" for VAUX3 LDO
+  - "ti,twl4030-vaux4" for VAUX4 LDO
+  - "ti,twl4030-vmmc1" for VMMC1 LDO
+  - "ti,twl4030-vmmc2" for VMMC2 LDO
+  - "ti,twl4030-vpll1" for VPLL1 LDO
+  - "ti,twl4030-vpll2" for VPLL2 LDO
+  - "ti,twl4030-vsim" for VSIM LDO
+  - "ti,twl4030-vdac" for VDAC LDO
+  - "ti,twl4030-vintana2" for VINTANA2 LDO
+  - "ti,twl4030-vio" for VIO LDO
+  - "ti,twl4030-vdd1" for VDD1 LDO
+  - "ti,twl4030-vdd2" for VDD2 LDO
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+	xyz: regulator@0 {
+		compatible = "ti,twl6030-vaux1","ti,twl6030";
+		regulator-min_uV  = <1000000>;
+		regulator-max_uV  = <3000000>;
+		regulator-more-normal;
+		regulator-mode-standby;
+		regulator-change-voltage;
+	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 2990841..edbf77e 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -48,6 +48,70 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vaux1: regulator@0 {
+			compatible = "ti,twl6030-vaux1","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-voltage;
+			regulator-change-mode;
+		};
+
+		vaux2: regulator@1 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2800000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vaux3: regulator@2 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vmmc: regulator@3 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <3000000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vpp: regulator@4 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-uV = <1800000>;
+			regulator-max-uV = <2500000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vusim: regulator@5 {
+			compatible = "ti,twl6030-vusim","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2900000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-voltage;
+			regulator-change-mode;
+		};
 	};
 };
 
-- 
1.7.1

