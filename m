From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V3 07/19] ARM: dts: am57xx: cl-som-am57x: add dual EMAC support
Date: Tue,  1 Dec 2015 20:03:09 +0200
Message-ID: <1448993001-19495-8-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add dual EMAC support.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
  v3: 
 
   * No fuctional changes 
   * Reformat subject 

  v2: 

   * Fix pinmux comments for RGMII0/1 clock/data lines
   * Fix pinmux for MDIO bus clock/data lines
   * Fix PHYs addresses

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 105 ++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index f7e163a..fe4baba 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -104,6 +104,85 @@
 			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs3.qspi1_cs1 */
 		>;
 	};
+
+	cpsw_pins_default: cpsw_pins_default {
+		pinctrl-single,pins = <
+			/* Slave at addr 0x0 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_tclk */
+			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_tctl */
+			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3 */
+			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td2 */
+			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td1 */
+			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td0 */
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rclk */
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rctl */
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rd3 */
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rd2 */
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rd1 */
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rgmii0_rd0 */
+
+			/* Slave at addr 0x1 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_tclk */
+			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d18.rgmii1_rclk */
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d19.rgmii1_rctl */
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d20.rgmii1_rd3 */
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d21.rgmii1_rd2 */
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d22.rgmii1_rd1 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT_PULLUP | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+		>;
+	};
+
+	cpsw_pins_sleep: cpsw_pins_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3654, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3658, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x365c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3660, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3664, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE15)
+
+			/* Slave 2 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x359c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE15)
+		>;
+	};
+
+	davinci_mdio_pins_default: davinci_mdio_pins_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			DRA7XX_CORE_IOPAD(0x3590, PIN_OUTPUT_PULLUP | MUX_MODE3)/* vin2a_d10.mdio_mclk */
+			DRA7XX_CORE_IOPAD(0x3594, PIN_INPUT_PULLUP | MUX_MODE3)	/* vin2a_d11.mdio_d */
+		>;
+	};
+
+	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3590, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3594, PIN_INPUT | MUX_MODE15)
+		>;
+	};
 };
 
 &i2c1 {
@@ -373,3 +452,29 @@
 		};
 	};
 };
+
+&mac {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_pins_default>;
+	pinctrl-1 = <&cpsw_pins_sleep>;
+	dual_emac;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <0>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_pins_default>;
+	pinctrl-1 = <&davinci_mdio_pins_sleep>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
