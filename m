From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/6] ARM: dts: omap4-panda: Use reset-gpio driver for
 hsusb1_reset
Date: Thu, 18 Jul 2013 11:53:07 +0300
Message-ID: <1374137590-17865-4-git-send-email-rogerq@ti.com>
References: <1374137590-17865-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374137590-17865-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We no longer need to model a RESET line as a regulator since
we have the reset-gpio driver available.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..e9b0a91 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -60,20 +60,13 @@
 			"AFMR", "Line In";
 	};
 
-	/*
-	 * Temp hack: Need to be replaced with the proper gpio-controlled
-	 * reset driver as soon it will be merged.
-	 * http://thread.gmane.org/gmane.linux.drivers.devicetree/36830
-	 */
 	/* HS USB Port 1 RESET */
-	hsusb1_reset: hsusb1_reset_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb1_reset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 30 0>;	/* gpio_62 */
-		startup-delay-us = <70000>;
-		enable-active-high;
+	hsusb1_reset: hsusb1_reset {
+		compatible = "gpio-reset";
+		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>; /* gpio_62 */
+		reset-delay-us = <70000>;
+		initially-in-reset;
+		#reset-cells = <0>;
 	};
 
 	/* HS USB Port 1 Power */
@@ -97,7 +90,8 @@
 	/* HS USB Host PHY on PORT 1 */
 	hsusb1_phy: hsusb1_phy {
 		compatible = "usb-nop-xceiv";
-		reset-supply = <&hsusb1_reset>;
+		resets = <&hsusb1_reset>;
+		reset-names = "reset";
 		vcc-supply = <&hsusb1_power>;
 	/**
 	 * FIXME:
-- 
1.7.4.1
