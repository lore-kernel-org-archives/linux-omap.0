From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap5: dts: fix reg property size
Date: Fri, 12 Jul 2013 14:58:05 +0300
Message-ID: <1373630285-17389-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52797 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab3GLL6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 07:58:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>

USB3 block has a 64KiB space, another 64KiB is
used for the wrapper.

Without this change, resource_size() will get
confused and driver won't probe because size
will be negative.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

does anybody know Benoit's knew email address ?

 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..5c99f19 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -637,7 +637,7 @@
 		omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
-			reg = <0x4a020000 0x1000>;
+			reg = <0x4a020000 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -645,7 +645,7 @@
 			ranges;
 			dwc3@4a030000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x4a030000 0x1000>;
+				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
 				tx-fifo-resize;
-- 
1.8.2.1

