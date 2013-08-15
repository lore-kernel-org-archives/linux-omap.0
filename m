From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 7/9] ARM: dts: omap5-uevm: Use reset-gpios for hsusb2_reset
Date: Thu, 15 Aug 2013 13:18:27 +0300
Message-ID: <1376561909-4406-8-git-send-email-rogerq@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39993 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab3HOKTZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Aug 2013 06:19:25 -0400
In-Reply-To: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: p.zabel@pengutronix.de, broonie@kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

We no longer need to model the RESET line as a regulator since
the USB phy-nop driver accepts "reset-gpios" property.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 65d7b60..c087762 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -27,21 +27,10 @@
 		regulator-max-microvolt = <3000000>;
 	};
 
-	/* HS USB Port 2 RESET */
-	hsusb2_reset: hsusb2_reset_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb2_reset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>; /* gpio3_80 HUB_NRESET */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
-		reset-supply = <&hsusb2_reset>;
+		reset-gpios = <&gpio3 16 GPIO_ACTIVE_LOW>; /* gpio3_80 HUB_NRESET */
 	/**
 	  * FIXME
 	  * Put the right clock phandle here when available
-- 
1.7.4.1

