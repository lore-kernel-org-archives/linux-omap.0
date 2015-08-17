From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/2] ARM: dts: AM437x: Add the internal and external clock nodes for rtc
Date: Mon, 17 Aug 2015 10:25:37 +0530
Message-ID: <1439787338-27396-2-git-send-email-j-keerthy@ti.com>
References: <1439787338-27396-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439787338-27396-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

rtc can either be supplied from internal 32k clock or external crystal
generated 32k clock. Internal clock is SOC specific and the external
clock is board dependent. Adding the corresponding nodes.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi        |  2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts  | 13 +++++++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts |  9 +++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts  |  9 +++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d99b2ee..484f092 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -336,6 +336,8 @@
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "rtc";
+			clocks = <&clk_32768_ck>;
+			clock-names = "int-clk";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 215775d..22038f2 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -112,6 +112,13 @@
 		clock-frequency = <12000000>;
 	};
 
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	sound0: sound@0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM437x-GP-EVM";
@@ -941,3 +948,9 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 37834427..af25801 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -110,6 +110,13 @@
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
 };
 
 &am43xx_pinmux {
@@ -394,6 +401,8 @@
 };
 
 &rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 22af448..7da7c2d 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -24,6 +24,13 @@
 		display0 = &lcd0;
 	};
 
+	/* fixed 32k external oscillator clock */
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
@@ -697,6 +704,8 @@
 };
 
 &rtc {
+	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
