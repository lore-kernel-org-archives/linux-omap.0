From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 3/4] ARM: dts: omap5-uevm: Provide USB PHY clock
Date: Tue, 7 Jan 2014 17:44:48 +0530
Message-ID: <1389096889-22179-4-git-send-email-rogerq@ti.com>
References: <1389096889-22179-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbaAGMQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jan 2014 07:16:41 -0500
In-Reply-To: <1389096889-22179-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The HS USB 2 PHY gets its clock from AUXCLK1. Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 002fa70..3b99ec2 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -31,12 +31,8 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio3 16 GPIO_ACTIVE_LOW>; /* gpio3_80 HUB_NRESET */
-	/**
-	  * FIXME
-	  * Put the right clock phandle here when available
-	  *	clocks = <&auxclk1>;
-	  *	clock-names = "main_clk";
-	  */
+		clocks = <&auxclk1_ck>;
+		clock-names = "main_clk";
 		clock-frequency = <19200000>;
 	};
 
-- 
1.8.3.2

