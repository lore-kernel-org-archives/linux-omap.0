From: Adam Ford <aford173@gmail.com>
Subject: [RFC 5/5] ARM: dts: am3517-evm: Enable MUSB on AM3517-evm
Date: Sun, 24 Jun 2018 19:12:33 -0500
Message-ID: <20180625001233.9785-6-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adam.ford@logicpd.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With AM35x now supported in device tree and the pdata-quirks
configuring the AM3517 clocks and some of the pin-mux,
this patch enables the MUSB and configures the rest of the pin-
mux options

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 56fdec33afc1..4aeadaca915f 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -243,6 +243,12 @@
 	phys = <&hsusb1_phy>;
 };
 
+&am35x_otg_hs {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&otg_drv_vbus>;
+};
+
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hsusb1_rst_pins>;
@@ -273,6 +279,12 @@
 		>;
 	};
 
+	otg_drv_vbus: pinmux_otg_drv_vbus {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50MHz_clk.usb0_drvvbus */
+		>;
+	};
+
 	backlight_pins: pinmux_backlight_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21de, PIN_OUTPUT | MUX_MODE4)       /* mcspi2_cs1.gpio_182 */
-- 
2.17.1
