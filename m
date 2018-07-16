From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 2/4] ARM: dts: am4372: Add all fck timer clocks
Date: Mon, 16 Jul 2018 22:39:00 +0200
Message-ID: <1531773542-15736-3-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

Add the missing fck clock to all timer nodes of the AM4372 dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index f0cbd86..254c0e6 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -383,6 +383,8 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -392,6 +394,8 @@
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -401,6 +405,8 @@
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -410,6 +416,8 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -419,6 +427,8 @@
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -427,6 +437,8 @@
 			reg = <0x481c1000 0x400>;
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			clocks = <&timer8_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -435,6 +447,8 @@
 			reg = <0x4833d000 0x400>;
 			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			clocks = <&timer9_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -443,6 +457,8 @@
 			reg = <0x4833f000 0x400>;
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			clocks = <&timer10_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -451,6 +467,8 @@
 			reg = <0x48341000 0x400>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			clocks = <&timer11_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
-- 
2.7.4
