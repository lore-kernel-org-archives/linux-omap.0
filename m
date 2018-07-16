From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 3/4] ARM: dts: dm816x: Add all fck timer clocks
Date: Mon, 16 Jul 2018 22:39:01 +0200
Message-ID: <1531773542-15736-4-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

Add the missing fck clock to all timer nodes of the DM816X dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 1edc2b4..0cc7f17 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -352,6 +352,8 @@
 			reg = <0x48042000 0x2000>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48044000 {
@@ -359,6 +361,8 @@
 			reg = <0x48044000 0x2000>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -367,6 +371,8 @@
 			reg = <0x48046000 0x2000>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -375,6 +381,8 @@
 			reg = <0x48048000 0x2000>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -383,6 +391,8 @@
 			reg = <0x4804a000 0x2000>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
-- 
2.7.4
