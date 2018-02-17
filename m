From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: omap4-droid4: Configure MDM6600 USB PHY
Date: Sat, 17 Feb 2018 13:33:01 -0800
Message-ID: <20180217213301.21849-2-tony@atomide.com>
References: <20180217213301.21849-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180217213301.21849-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Configure MDM6600 USB PHY.

Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -71,6 +71,25 @@
 		regulator-always-on;
 	};
 
+	/* FS USB Host PHY on port 1 for mdm6600 */
+	fsusb1_phy: fsusb1_phy {
+		compatible = "motorola,mapphone-mdm6600";
+		pinctrl-0 = <&usb_mdm6600_pins>;
+		pinctrl-names = "default";
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;     /* gpio_95 */
+		power-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;	/* gpio_54 */
+		reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;	/* gpio_49 */
+		mode-gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>,	/* gpio_148 */
+			     <&gpio5 21 GPIO_ACTIVE_HIGH>;	/* gpio_149 */
+		status-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>,	/* gpio_55 */
+			       <&gpio2 21 GPIO_ACTIVE_HIGH>,	/* gpio_53 */
+			       <&gpio2 20 GPIO_ACTIVE_HIGH>;	/* gpio_52 */
+		cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,	/* gpio_103 */
+			    <&gpio4 8 GPIO_ACTIVE_HIGH>,	/* gpio_104 */
+			    <&gpio5 14 GPIO_ACTIVE_HIGH>;	/* gpio_142 */
+		#phy-cells = <0>;
+	};
+
 	/* HS USB host TLL nop-phy on port 2 for w3glte */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
@@ -459,6 +478,43 @@
 		>;
 	};
 
+	usb_mdm6600_pins: pinmux_usb_mdm6600_pins {
+		pinctrl-single,pins = <
+		/* enable 0x4a1000d8 usbb1_ulpitll_dat7.gpio_95 ag16 */
+		OMAP4_IOPAD(0x0d8, PIN_INPUT | MUX_MODE3)
+
+		/* power 0x4a10007c gpmc_nwp.gpio_54 c25 */
+		OMAP4_IOPAD(0x07c, PIN_OUTPUT | MUX_MODE3)
+
+		/* reset 0x4a100072 gpmc_a25.gpio_49 d20 */
+		OMAP4_IOPAD(0x072, PIN_OUTPUT | MUX_MODE3)
+
+		/* mode0/bpwake 0x4a10014e sdmmc5_dat1.gpio_148 af4 */
+		OMAP4_IOPAD(0x14e, PIN_OUTPUT | MUX_MODE3)
+
+		/* mode1/apwake 0x4a100150 sdmmc5_dat2.gpio_149 ag3 */
+		OMAP4_IOPAD(0x150, PIN_OFF_OUTPUT_LOW | PIN_INPUT | MUX_MODE3)
+
+		/* status0 0x4a10007e gpmc_clk.gpio_55 b22 */
+		OMAP4_IOPAD(0x07e, PIN_INPUT | MUX_MODE3)
+
+		/* status1 0x4a10007a gpmc_ncs3.gpio_53 c22 */
+		OMAP4_IOPAD(0x07a, PIN_INPUT | MUX_MODE3)
+
+		/* status2 0x4a100078 gpmc_ncs2.gpio_52 d21 */
+		OMAP4_IOPAD(0x078, PIN_INPUT | MUX_MODE3)
+
+		/* cmd0 0x4a100094 gpmc_ncs6.gpio_103 c24 */
+		OMAP4_IOPAD(0x094, PIN_OUTPUT | MUX_MODE3)
+
+		/* cmd1 0x4a100096 gpmc_ncs7.gpio_104 d24 */
+		OMAP4_IOPAD(0x096, PIN_OUTPUT | MUX_MODE3)
+
+		/* cmd2 0x4a100142 uart3_rts_sd.gpio_142 f28 */
+		OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE3)
+		>;
+	};
+
 	usb_ulpi_pins: pinmux_usb_ulpi_pins {
 		pinctrl-single,pins = <
 		OMAP4_IOPAD(0x196, MUX_MODE7)
@@ -583,6 +639,11 @@
 	};
 };
 
+&usbhsohci {
+	phys = <&fsusb1_phy>;
+	phy-names = "usb";
+};
+
 &usbhsehci {
 	phys = <&hsusb2_phy>;
 };
-- 
2.16.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
