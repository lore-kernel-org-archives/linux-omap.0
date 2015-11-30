From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 12/18] ARM: am57xx: cl-som-am57x: dts: add MMC1 support
Date: Mon, 30 Nov 2015 16:28:18 +0200
Message-ID: <1448893698-807-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-13-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-13-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add MMC1 support, used for SD/MMC card.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 v2:

   * Fix duplicate SD Card Detect pinmux

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 804ad72..93852e2 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -24,6 +24,19 @@
 			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1)	/* uart2_rtsn.uart3_txd */
 		>;
 	};
+
+	mmc1_pins_default: mmc1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1_sdcd.gpio6_27 */
+			DRA7XX_CORE_IOPAD(0x377c, PIN_INPUT | MUX_MODE14)	/* mmc1_sdwp.gpio6_28 */
+		>;
+	};
 };
 
 &uart3 {
@@ -34,3 +47,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins_default>;
 };
+
+&mmc1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_default>;
+
+	vmmc-supply = <&ldo1_reg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 28 GPIO_ACTIVE_HIGH>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
