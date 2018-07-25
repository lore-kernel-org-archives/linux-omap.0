From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
Date: Wed, 25 Jul 2018 11:25:35 +0530
Message-ID: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

RTC alarm2 is connected to pmic_en line and hence can be used to control
the pmic enabling/disabling. Hence add the system-power-controller for rtc
node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index f0cbd86..d4b7c59 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -469,6 +469,7 @@
 			ti,hwmods = "rtc";
 			clocks = <&clk_32768_ck>;
 			clock-names = "int-clk";
+			system-power-controller;
 			status = "disabled";
 		};
 
-- 
1.9.1
