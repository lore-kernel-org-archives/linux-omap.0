From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 07/10] ARM: dts: omap5-uevm: Use reset-gpios for hsusb2/3_reset
Date: Tue, 24 Sep 2013 11:53:53 +0300
Message-ID: <1380012836-29900-8-git-send-email-rogerq@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380012836-29900-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We no longer need to model the RESET line as a regulator since
the USB phy-nop driver accepts "reset-gpios" property.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 65d7b60..506bdc2 100644
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
@@ -51,21 +40,10 @@
 		clock-frequency = <19200000>;
 	};
 
-	/* HS USB Port 3 RESET */
-	hsusb3_reset: hsusb3_reset_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb3_reset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>; /* gpio3_79 ETH_NRESET */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
 	/* HS USB Host PHY on PORT 3 */
 	hsusb3_phy: hsusb3_phy {
 		compatible = "usb-nop-xceiv";
-		reset-supply = <&hsusb3_reset>;
+		reset-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>; /* gpio3_79 ETH_NRESET */
 	};
 
 	leds {
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
