From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Date: Mon, 16 Jul 2018 22:38:59 +0200
Message-ID: <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

Add the missing fck clock to all timer nodes of the AM33XX dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2..e8e665d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -541,6 +541,8 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48044000 {
@@ -548,6 +550,8 @@
 			reg = <0x48044000 0x400>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -556,6 +560,8 @@
 			reg = <0x48046000 0x400>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -564,6 +570,8 @@
 			reg = <0x48048000 0x400>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -572,6 +580,8 @@
 			reg = <0x4804a000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
-- 
2.7.4
