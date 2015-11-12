From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/5] arm: dts: add dm816x pwm property to timers
Date: Thu, 12 Nov 2015 15:07:40 +0100
Message-ID: <56449D2C.6010307@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Adds ti,timer-pwm property to timers 4 to 7 to permit usage of their
PWM output fonctionnality via the dmtimer driver.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index eee636d..51ad4a9 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -323,6 +323,7 @@
 			reg = <0x48044000 0x2000>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			ti,timer-pwm;
 		};

 		timer5: timer@48046000 {
@@ -330,6 +331,7 @@
 			reg = <0x48046000 0x2000>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			ti,timer-pwm;
 		};

 		timer6: timer@48048000 {
@@ -337,6 +339,7 @@
 			reg = <0x48048000 0x2000>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			ti,timer-pwm;
 		};

 		timer7: timer@4804a000 {
@@ -344,6 +347,7 @@
 			reg = <0x4804a000 0x2000>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			ti,timer-pwm;
 		};

 		uart1: uart@48020000 {
-- 
1.9.1
