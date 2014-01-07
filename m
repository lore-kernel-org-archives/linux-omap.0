From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/4] ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
Date: Tue, 7 Jan 2014 17:44:46 +0530
Message-ID: <1389096889-22179-2-git-send-email-rogerq@ti.com>
References: <1389096889-22179-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37569 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbaAGMQc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jan 2014 07:16:32 -0500
In-Reply-To: <1389096889-22179-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>

USB Host driver (drivers/mfd/omap-usb-host.c) expects the 60MHz
reference clock to be named "init_60m_fclk". Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 2f12a47..e0ab379 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -765,6 +765,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&l3init_60m_fclk>;
+			clock-names = "init_60m_fclk";
 
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
-- 
1.8.3.2

