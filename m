From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH] ARM: dts: am335x-baltos-ir5221: use dedicated RTS/CTS signals
Date: Tue, 29 Mar 2016 12:08:08 +0200
Message-ID: <1459246088-17768-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Before "tty: Add software emulated RS485 support for 8250" patch Baltos devices
relied on MCTRL_GPIO framework to handle both modem signals and RS485 mode.

With emulated RS485 support for 8250 we can now use these pins as dedicated
RTS/CTS signals taking advantage of hardware flow control etc. when operating
in RS232 mode.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 4e28d87..7fd2bb6 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -109,8 +109,8 @@
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
 			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* uart1_ctsn, INPUT | MODE0 */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* uart1_rtsn, OUTPUT | MODE0 */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
 			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
 			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
 			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
@@ -122,8 +122,8 @@
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
 			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* i2c0_sda.uart2_ctsn_mux0 */
-			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
 			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
 			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
@@ -287,8 +287,6 @@
 	dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
 	dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
 	rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
-	cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
-	rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 
 	status = "okay";
 };
@@ -300,8 +298,6 @@
 	dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 	dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 	rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
-	rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 
 	status = "okay";
 };
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
