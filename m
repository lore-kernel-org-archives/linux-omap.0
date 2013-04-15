From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 2/6] ARM: dts: OMAP4: add device tree for ABB
Date: Mon, 15 Apr 2013 16:28:07 +0300
Message-ID: <1366032491-4162-3-git-send-email-andrii.tseglytskyi@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3DON2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 09:28:17 -0400
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP44xx family of devices.
Data is based on OMAP44xx TRM document.

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi    |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap443x.dtsi |   23 +++++++++++++++++++++++
 arch/arm/boot/dts/omap446x.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap446x.dtsi

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..8a98002 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -81,6 +81,28 @@
 		};
 	};
 
+	abb_mpu: regulator-abb1 {
+		compatible = "ti,omap4-abb";
+		regulator-name = "abb_mpu";
+		regulator-always-on;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x4a307bd0 0x8>,
+		      <0x4a306014 0x4>;
+		ti,tranxdone_status_mask = <0x80>;
+	};
+
+	abb_iva: regulator-abb2 {
+		compatible = "ti,omap4-abb";
+		regulator-name = "abb_iva";
+		regulator-always-on;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x4a307bd8 0x8>,
+		      <0x4a306010 0x4>;
+		ti,tranxdone_status_mask = <0x80000000>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the OMAP4 interconnect.
 	 * The real OMAP interconnect network is quite complex.
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cccf39a..044b54c 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,4 +24,27 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+
+	abb_mpu: regulator-abb1 {
+		regulator-min-microvolt = <1025000>;
+		regulator-max-microvolt = <1375000>;
+		operating-points = <
+			/* uV   ABB */
+			1025000	0
+			1200000	0
+			1313000	0
+			1375000	1
+		>;
+	};
+
+	abb_iva: regulator-abb2 {
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1291000>;
+		operating-points = <
+			/* uV   ABB */
+			950000	0
+			1114000	0
+			1291000	0
+		>;
+	};
 };
diff --git a/arch/arm/boot/dts/omap446x.dtsi b/arch/arm/boot/dts/omap446x.dtsi
new file mode 100644
index 0000000..3c81d3b
--- /dev/null
+++ b/arch/arm/boot/dts/omap446x.dtsi
@@ -0,0 +1,39 @@
+/*
+ * Device Tree Source for OMAP446x SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "omap4.dtsi"
+
+/ {
+	abb_mpu: regulator-abb1 {
+		regulator-min-microvolt = <1025000>;
+		regulator-max-microvolt = <1390000>;
+		operating-points = <
+			/* uV   ABB */
+			1025000	0
+			1203000	0
+			1317000	0
+			1380000	1
+			1390000	1
+		>;
+	};
+
+	abb_iva: regulator-abb2 {
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1376000>;
+		operating-points = <
+			/* uV   ABB */
+			950000	0
+			1140000	0
+			1291000	0
+			1375000	1
+			1376000	1
+		>;
+	};
+};
-- 
1.7.9.5

