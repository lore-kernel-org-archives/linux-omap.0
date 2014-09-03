From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: boot: dts: am4372: fix USB regs size
Date: Wed, 3 Sep 2014 16:22:24 -0500
Message-ID: <1409779344-27823-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42385 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756778AbaICVW7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 17:22:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Size should be 64KiB instead of 92KiB.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 9b3d2ba..8689949 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -804,7 +804,7 @@
 
 			usb1: usb@48390000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x48390000 0x17000>;
+				reg = <0x48390000 0x10000>;
 				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb2-phy";
@@ -826,7 +826,7 @@
 
 			usb2: usb@483d0000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x483d0000 0x17000>;
+				reg = <0x483d0000 0x10000>;
 				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
-- 
2.0.1.563.g66f467c

