From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 4/4] arm/dts: AM33XX: Add D_CAN device tree data
Date: Thu, 16 Aug 2012 17:50:10 +0530
Message-ID: <1345119610-5247-5-git-send-email-anilkumar@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48756 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab2HPMU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:20:57 -0400
In-Reply-To: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add Bosch D_CAN controller device tree data to AM33XX dtsi
file by adding d_can device nodes with all the necessary
parameters.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    4 ++++
 arch/arm/boot/dts/am33xx.dtsi    |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index a64c30a..1e1fc15 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -34,5 +34,9 @@
 		uart1: serial@44E09000 {
 			status = "okay";
 		};
+
+		dcan1: d_can@481D0000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dfe9c559..d965137 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -177,5 +177,23 @@
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
 		};
+
+		dcan0: d_can@481CC000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can0";
+			reg = <0x481CC000 0x2000>;
+			interrupts = <52>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
+
+		dcan1: d_can@481D0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can1";
+			reg = <0x481D0000 0x2000>;
+			interrupts = <55>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5

