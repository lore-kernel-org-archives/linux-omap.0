From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/5] arm: dts: omap5-evm: Add I2c pinctrl data
Date: Wed, 13 Feb 2013 14:58:22 +0530
Message-ID: <1360747702-1501-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Booting 3.8-rc6 on omap 5430evm results in the following error

omap_i2c 48070000.i2c: did not get pins for i2c error: -19
[    1.024261] omap_i2c 48070000.i2c: bus 0 rev0.12 at 100 kHz
[    1.030181] omap_i2c 48072000.i2c: did not get pins for i2c error: -19
[    1.037384] omap_i2c 48072000.i2c: bus 1 rev0.12 at 400 kHz
[    1.043762] omap_i2c 48060000.i2c: did not get pins for i2c error: -19
[    1.050964] omap_i2c 48060000.i2c: bus 2 rev0.12 at 100 kHz
[    1.056823] omap_i2c 4807a000.i2c: did not get pins for i2c error: -19
[    1.064025] omap_i2c 4807a000.i2c: bus 3 rev0.12 at 400 kHz

This happens because omap5 dts file is not adapted to use i2c through pinctrl
framework. Populating i2c pinctrl data to get rid of the error.

Tested on omap5430 evm with 3.8-rc6 kernel.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5-evm.dts |   62 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 8722c15..a4784be 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -80,6 +80,41 @@
 			0x15a 0x100	/* abemcbsp2_clkx.abemcbsp2_clkx INPUT | MODE0 */
 		>;
 	};
+
+        i2c1_pins: pinmux_i2c1_pins {
+                pinctrl-single,pins = <
+                        0x1b2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
+                        0x1b4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
+                >;
+        };
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x178 0x100        /* i2c2_scl INPUTENABLE | MODE0 */
+			0x17a 0x100        /* i2c2_sda INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x13a 0x100        /* i2c3_scl INPUTENABLE | MODE0 */
+			0x13c 0x100     /* i2c3_sda INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins = <
+			0xb8 0x100        /* i2c4_scl INPUTENABLE | MODE0 */
+			0xba 0x100     /* i2c4_sda INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c5_pins: pinmux_i2c5_pins {
+		pinctrl-single,pins = <
+			0x184 0x100        /* i2c5_scl INPUTENABLE | MODE0 */
+			0x186 0x100     /* i2c5_sda INPUTENABLE | MODE0 */
+		>;
+	};
 };
 
 &mmc1 {
@@ -106,7 +141,17 @@
 	status = "disabled";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+};
+
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
 	clock-frequency = <400000>;
 
 	/* Pressure Sensor */
@@ -116,7 +161,17 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	clock-frequency = <400000>;
+};
+
 &i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+
 	clock-frequency = <400000>;
 
 	/* Temperature Sensor */
@@ -126,6 +181,13 @@
 	};
 };
 
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+
+	clock-frequency = <400000>;
+};
+
 &keypad {
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
-- 
1.7.1
