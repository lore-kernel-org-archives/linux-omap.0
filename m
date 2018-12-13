From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
Date: Thu, 13 Dec 2018 15:58:45 +0200
Message-ID: <20181213135845.3965-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

The ethernet works in kernel only if we use some binary u-boot from the
past which have support for KS8851.

The u-boot sources are not available for this mysterious u-boot image
people tends to hold on... Mainline u-bott does not have ethernet support
for sdp4430 and if we use that the ethernet is not working.

After some debugging I have managed to get the ethernet working with
mainline u-boot while not breaking the networking with the case when we
boot with the mysterious binary u-boot.

Basically we were missing bunch of pinmux settings and the 'magic'
gpio_138 handling in kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 9dc7ec7655cb..c88817bdcc56 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -26,6 +26,9 @@
 	};
 
 	vdd_eth: fixedregulator-vdd-eth {
+		pinctrl-names = "default";
+		pinctrl-0 = <&enet_enable_gpio>;
+
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_ETH";
 		regulator-min-microvolt = <3300000>;
@@ -352,6 +355,29 @@
 			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
 		>;
 	};
+
+	/* gpio_48 for ENET_ENABLE */
+	enet_enable_gpio: pinmux_enet_enable_gpio {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x070, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a24.gpio_48 */
+		>;
+	};
+
+	ks8851_pins: pinmux_ks8851_pins {
+		pinctrl-single,pins = <
+			/* ENET_INT */
+			OMAP4_IOPAD(0x054, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad10.gpio_34 */
+			/*
+			 * Misterious pin which makes the ethernet working
+			 * The legacy board file requested this pin on boot
+			 * (ETH_KS8851_QUART) and set it to high, similarly to
+			 * the ENET_ENABLE pin.
+			 * We could use gpio-hog to keep it high, but let's use
+			 * it as a reset GPIO for ks8851.
+			 */
+			OMAP4_IOPAD(0x13a, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.gpio_138 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -452,12 +478,16 @@
 	pinctrl-0 = <&mcspi1_pins>;
 
 	eth@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ks8851_pins>;
+
 		compatible = "ks8851";
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>; /* gpio line 34 */
 		vdd-supply = <&vdd_eth>;
+		reset-gpios = <&gpio5 10 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
