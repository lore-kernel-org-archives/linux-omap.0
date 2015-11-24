From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 3/6] ARM: OMAP2+: dts: cm-t335: add support for NAND flash
Date: Tue, 24 Nov 2015 16:02:10 +0200
Message-ID: <1448373733-5839-4-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Add pinmux configuration for NAND specific GPMC pins.
Add description for GPMC controller. Add child node for NAND flash
including CM-T335 specific partition table to GPMC node.
Enable error-location module (ELM).

Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 arch/arm/boot/dts/am335x-cm-t335.dts | 106 +++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 02b6679..431b6dd 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -62,6 +62,41 @@
 		>;
 	};
 
+	nandflash_pins: pinmux_nandflash_pins {
+		pinctrl-single,pins = <
+			/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)
+			/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_ben0_cle.gpmc_ben0_cle */
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			/* uart0_rxd.uart0_rxd */
@@ -98,3 +133,74 @@
 	};
 };
 
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		/* MTD partition table */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "spl";
+			reg = <0x00000000 0x00200000>;
+		};
+		partition@1 {
+			label = "uboot";
+			reg = <0x00200000 0x00100000>;
+		};
+		partition@2 {
+			label = "uboot environment";
+			reg = <0x00300000 0x00100000>;
+		};
+		partition@3 {
+			label = "dtb";
+			reg = <0x00400000 0x00100000>;
+		};
+		partition@4 {
+			label = "splash";
+			reg = <0x00500000 0x00400000>;
+		};
+		partition@5 {
+			label = "linux";
+			reg = <0x00900000 0x00600000>;
+		};
+		partition@6 {
+			label = "rootfs";
+			reg = <0x00F00000 0>;
+		};
+	};
+};
+
+&elm {
+	status = "okay";
+};
+
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
