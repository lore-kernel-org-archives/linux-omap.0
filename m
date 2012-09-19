From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v7 2/5] ARM: dts: AM33XX: Add D_CAN device tree data
Date: Thu, 20 Sep 2012 02:49:27 +0530
Message-ID: <1348089570-16161-3-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49388 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2ISVUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:20:05 -0400
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Add Bosch D_CAN controller device tree data to AM33XX dtsi
file by adding d_can device nodes with all the necessary
parameters.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 894fec6..64c2efe 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -234,5 +234,23 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
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

