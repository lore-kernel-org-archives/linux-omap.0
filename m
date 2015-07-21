From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] ARM: dts: omap3-pandora: add support for usb host and 32k buffer
Date: Tue, 21 Jul 2015 04:11:59 +0300
Message-ID: <1437441121-31658-2-git-send-email-notasas@gmail.com>
References: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437441121-31658-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This adds missing bits for EHCI HS USB host support and 32k clock
buffer control for the wg7210 bt+wifi module.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f6363bc..6e82c4a 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -199,6 +199,38 @@
 			gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;   /* GPIO_108 */
 		};
 	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>; /* GPIO_16 */
+		vcc-supply = <&vaux2>;
+	};
+
+	/* HS USB Host VBUS supply
+	 * disabling this regulator causes current leakage, and LCD flicker
+	 * on earlier (CC) board revisions, so keep it always on */
+	usb_host_5v: fixed-regulator-usb_host_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_host_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio6 4 0>;	/* GPIO_164 */
+	};
+
+	/* wg7210 (wifi+bt module) 32k clock buffer */
+	wg7210_32k: fixed-regulator-wg7210_32k {
+		compatible = "regulator-fixed";
+		regulator-name = "wg7210_32k";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		enable-active-high;
+		gpio = <&twl_gpio 13 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &omap3_pmx_core {
@@ -501,6 +533,10 @@
 	port2-mode = "ehci-phy";
 };
 
+&usbhsehci {
+	phys = <0 &hsusb2_phy>;
+};
+
 &gpmc {
 	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
