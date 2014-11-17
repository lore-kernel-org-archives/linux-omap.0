From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: DRA7: Add node for RTC
Date: Mon, 17 Nov 2014 10:15:09 +0530
Message-ID: <1416199509-3977-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbaKQEqp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Nov 2014 23:46:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>

Add node for RTC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[nm@ti.com: update with rtc crossbar number]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..f98f9f0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1075,6 +1075,15 @@
 			status = "disabled";
 		};
 
+		rtc: rtcss@48838000 {
+			compatible = "ti,am3352-rtc";
+			reg = <0x48838000 0x100>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "rtcss";
+			clocks = <&sys_32k_ck>;
+		};
+
 		omap_control_usb2phy1: control-phy@4a002300 {
 			compatible = "ti,control-phy-usb2";
 			reg = <0x4a002300 0x4>;
-- 
1.9.1

