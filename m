From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v5 3/3] arm/dts: AM33XX: Add D_CAN device tree data
Date: Wed, 5 Sep 2012 17:11:00 +0530
Message-ID: <1346845260-10978-4-git-send-email-anilkumar@ti.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43940 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223Ab2IELlt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 07:41:49 -0400
In-Reply-To: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add Bosch D_CAN controller device tree data to AM33XX dtsi
file by adding d_can device nodes with all the necessary
parameters.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bf5f713..ab744d6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -177,5 +177,23 @@
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
 		};
+
+		dcan0: d_can@481cc000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can0";
+			reg = <0x481cc000 0x2000>;
+			interrupts = <52>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
+
+		dcan1: d_can@481d0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can1";
+			reg = <0x481d0000 0x2000>;
+			interrupts = <55>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5

