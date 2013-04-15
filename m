From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 1/6] ARM: dts: OMAP36xx: add device tree for ABB
Date: Mon, 15 Apr 2013 16:28:06 +0300
Message-ID: <1366032491-4162-2-git-send-email-andrii.tseglytskyi@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46171 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3DON2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 09:28:16 -0400
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP36xx family of devices.
Data is based on OMAP36XX TRM document.

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 Documentation/devicetree/bindings/power/abb.txt |   38 +++++++++++++++++++++++
 arch/arm/boot/dts/omap36xx.dtsi                 |   20 ++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/abb.txt

diff --git a/Documentation/devicetree/bindings/power/abb.txt b/Documentation/devicetree/bindings/power/abb.txt
new file mode 100644
index 0000000..3f6c17c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/abb.txt
@@ -0,0 +1,38 @@
+ABB regulator for OMAP platforms
+
+Required properties :
+- compatible:
+  - "ti,omap36xx-abb" for OMAP36XX
+  - "ti,omap4-abb" for OMAP4
+  - "ti,omap5-abb" for OMAP5
+
+- regulator-min-microvolt: lowest OPP voltage
+- regulator-max-microvolt: highest OPP voltage
+- regulator-always-on: ABB should be always on
+- reg: addres range defined in TRM
+- ti,tranxdone_status_mask: ABB transition state mask
+- operating-points: An array of 2-tuples items, and each item consists
+  of voltage and ABB opp_sel, like <volt-uV opp_sel>.
+	volt: voltage in uV
+	opp_sel: 0-bypass, 1-FBB, 2-RBB
+
+Examples :
+abb_mpu_iva: regulator-abb1 {
+	compatible = "ti,omap36xx-abb";
+	regulator-name = "abb_mpu_iva";
+	regulator-min-microvolt = <1012500>;
+	regulator-max-microvolt = <1375000>;
+	regulator-always-on;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x483072f0 0x8>,
+	      <0x48306818 0x4>;
+	ti,tranxdone_status_mask = <0x4000000>;
+	operating-points = <
+		/* uV   ABB */
+		1012500 0
+		1200000 0
+		1325000 0
+		1375000 1
+	>;
+};
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index b89233e..5e917ca 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -28,6 +28,26 @@
 		};
 	};
 
+	abb_mpu_iva: regulator-abb1 {
+		compatible = "ti,omap36xx-abb";
+		regulator-name = "abb_mpu_iva";
+		regulator-min-microvolt = <1012500>;
+		regulator-max-microvolt = <1375000>;
+		regulator-always-on;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x483072f0 0x8>,
+		      <0x48306818 0x4>;
+		ti,tranxdone_status_mask = <0x4000000>;
+		operating-points = <
+			/* uV   ABB */
+			1012500	0
+			1200000	0
+			1325000	0
+			1375000	1
+		>;
+	};
+
 	ocp {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
-- 
1.7.9.5

