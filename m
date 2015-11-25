From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 06/18] ARM: am57xx: cl-som-am57x: dts: add spi-flash support
Date: Wed, 25 Nov 2015 08:39:38 +0200
Message-ID: <1448433590-1399-7-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On-board spi-flash chip is used as a main boot device.
Add spi-flash chip support (over QSPI bus).

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index ed50a75..cf2328d 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -93,6 +93,17 @@
 			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
+
+	qspi1_pins: pinmux_qspi1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)	/* gpmc_a13.qspi1_rtclk */
+			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_d0 */
+			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_d1 */
+			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)	/* qpmc_a18.qspi1_sclk */
+			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs3.qspi1_cs1 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -331,3 +342,33 @@
 	cap-mmc-dual-data-rate;
 };
 
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_pins>;
+
+	spi_flash: spi_flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;				/* CS0 */
+		spi-max-frequency = <20000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition@c0000 {
+			label = "uboot environment";
+			reg = <0xc0000 0x40000>;
+		};
+
+		partition@100000 {
+			label = "reserved";
+			reg = <0x100000 0x0>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
