From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 06/14] ARM: dts: am437x: cm-t43: add dual emac support
Date: Tue,  1 Dec 2015 15:55:01 +0200
Message-ID: <1448978109-5614-7-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448978109-5614-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CM-T43 comes with 2 ethernet ports connected to the cpsw subsystem, which
has 2 modes of operation: switch mode and dual emac mode.
Add the relevant muxing and set it up to work in dual emac mode by
default.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
Changes in V2:
	- No changes.

 arch/arm/boot/dts/am437x-cm-t43.dts | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index efabb31..fd97a89 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -73,6 +73,47 @@
 			AM4372_IOPAD(0x89c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM4372_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_txen */
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rxctl */
+			AM4372_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd3 */
+			AM4372_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd2 */
+			AM4372_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
+			AM4372_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
+			AM4372_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd3 */
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd2 */
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM4372_IOPAD(0xa74, MUX_MODE3)
+			/* Slave 2 */
+			AM4372_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.txen */
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a1.rxctl */
+			AM4372_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.txd3 */
+			AM4372_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.txd2 */
+			AM4372_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.txd1 */
+			AM4372_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.txd0 */
+			AM4372_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.tclk */
+			AM4372_IOPAD(0x85c, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a7.rclk */
+			AM4372_IOPAD(0x860, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a8.rxd3 */
+			AM4372_IOPAD(0x864, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a9.rxd2 */
+			AM4372_IOPAD(0x868, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a10.rxd1 */
+			AM4372_IOPAD(0x86c, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a11.rxd0 */
+			AM4372_IOPAD(0xa38, MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			AM4372_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM4372_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
 };
 
 &gpmc {
@@ -261,6 +302,31 @@
 	};
 };
 
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default>;
+	dual_emac = <1>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&davinci_mdio_default>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <2>;
+};
+
 &elm {
 	status = "okay";
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
