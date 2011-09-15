From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 04/11] omap4: SDP: Pass regulator_init_data from DT
Date: Thu, 15 Sep 2011 16:52:00 +0530
Message-ID: <1316085727-15023-5-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933338Ab1IOLWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:38 -0400
In-Reply-To: <1316085727-15023-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Pass regulator_init_data information for omap4sdp from device tree so the
regulator driver can then use the regulator helper
routine to extract and use them during the driver probe().

Add documentation for TWL regulator specific bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../bindings/regulator/twl-regulator.txt           |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   16 ++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
new file mode 100644
index 0000000..59df44b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -0,0 +1,18 @@
+TWL family of regulators
+
+Required properties:
+- compatible: Must be "regulator","ti,twl-reg";
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+- ti,reg-id: Identifier for a TWL regulator, defined in linux/i2c/twl.h file.
+
+Example:
+
+	xyz-regulator: regulator@0 {
+		compatible = "regulator","ti,twl-reg";
+		ti,reg-id = <37>; /* TWL6030_REG_VAUX1_6030 */
+		min-uV  = <1000000>;
+		max-uV  = <3000000>;
+		apply-uV;
+	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 14faf92..2a613e2 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -52,6 +52,22 @@
 			interrupts = <11>;
 			reg = <0>;
 		};
+
+		vaux1-regulator: regulator@0 {
+			compatible = "regulator","ti,twl-reg";
+			ti,reg-id = <37>;  /* TWL6030_REG_VAUX1_6030 */
+			min-uV = <1000000>;
+			max-uV = <3000000>;
+			apply-uV;
+		};
+
+		vusim-regulator: regulator@1 {
+			compatible = "regulator","ti,twl-reg";
+			ti,reg-id = <42>; /* TWL6030_REG_VUSIM */
+			min-uV = <1200000>;
+			max-uV = <2900000>;
+			apply_uV;
+		};
 	};
 };
 
-- 
1.7.1

