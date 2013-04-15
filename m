From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 3/6] ARM: dts: OMAP5: add device tree for ABB
Date: Mon, 15 Apr 2013 16:28:08 +0300
Message-ID: <1366032491-4162-4-git-send-email-andrii.tseglytskyi@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39382 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab3DON2S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 09:28:18 -0400
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP543x family of devices.
Data is based on OMAP543x TRM document.

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3dd7ff8..e1b2c92 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -74,6 +74,45 @@
 		};
 	};
 
+	abb_mpu: regulator-abb1 {
+		compatible = "ti,omap5-abb";
+		regulator-name = "abb_mpu";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <1260000>;
+		regulator-always-on;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x4ae07cdc 0x8>,
+		      <0x4ae06014 0x4>;
+		ti,tranxdone_status_mask = <0x80>;
+		operating-points = <
+			/* uV   ABB */
+			880000	0
+			1060000	1
+			1250000	1
+			1260000	1
+		>;
+	};
+
+	abb_iva: regulator-abb2 {
+		compatible = "ti,omap5-abb";
+		regulator-name = "abb_iva";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <1120000>;
+		regulator-always-on;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x4ae07ce4 0x8>,
+		      <0x4ae06010 0x4>;
+		ti,tranxdone_status_mask = <0x80000000>;
+		operating-points = <
+			/* uV   ABB */
+			880000	0
+			1025000	0
+			1120000	0
+		>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the OMAP3 interconnect.
 	 * The real OMAP interconnect network is quite complex.
-- 
1.7.9.5

