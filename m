From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 2/2] arm/dts: twl: Pass regulator data from dt
Date: Mon, 27 Feb 2012 16:06:01 +0530
Message-ID: <1330338961-31765-3-git-send-email-rnayak@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40601 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab2B0Kgo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 05:36:44 -0500
In-Reply-To: <1330338961-31765-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Pass all the voltage regulator information for
twl6030/twl4030 PMIC from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    6 +++
 arch/arm/boot/dts/twl4030.dtsi     |   18 +++++++++++
 arch/arm/boot/dts/twl6030.dtsi     |   60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 714ba5d..54556b1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -26,6 +26,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		vsim: regulator@10 {
+			compatible = "ti,twl4030-vsim";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 8be5223..a94654c 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -18,4 +18,22 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vdac: regulator@0 {
+		compatible = "ti,twl4030-vdac";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vpll2: regulator@1 {
+		compatible = "ti,twl4030-vpll2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vmmc1: regulator@2 {
+		compatible = "ti,twl4030-vmmc1";
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <3150000>;
+	};
 };
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index b7b4e5e..efa19e8 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -19,4 +19,64 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vaux1: regulator@0 {
+		compatible = "ti,twl6030-vaux1";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vaux2: regulator@1 {
+		compatible = "ti,twl6030-vaux2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	vaux3: regulator@2 {
+		compatible = "ti,twl6030-vaux3";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vmmc: regulator@3 {
+		compatible = "ti,twl6030-vmmc";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vpp: regulator@4 {
+		compatible = "ti,twl6030-vpp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	vusim: regulator@5 {
+		compatible = "ti,twl6030-vusim";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	vdac: regulator@6 {
+		compatible = "ti,twl6030-vdac";
+	};
+
+	vana: regulator@7 {
+		compatible = "ti,twl6030-vana";
+	};
+
+	vcxio: regulator@8 {
+		compatible = "ti,twl6030-vcxio";
+	};
+
+	vusb: regulator@9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	vusb: regulator@9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	clk32kg: regulator@10 {
+		compatible = "ti,twl6030-clk32kg";
+	};
 };
-- 
1.7.1

