From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Fri, 18 Sep 2015 09:29:05 -0700
Message-ID: <1442593745-16725-3-git-send-email-tony@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442593745-16725-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 99f84cae43df ("ARM: dts: add wl12xx/wl18xx bindings") added
device tree bindings for the TI WLAN SDIO on many omap variants.

I recall wondering how come omap5-uevm did not have the WLAN
added and this issue has been bugging me for a while now, and
I finally tracked it down to a bad pinmux regression, and a missing
deferred probe handling for the 32k clock from palmas that's
requested by twl6040.

Basically 392adaf796b9 ("ARM: dts: omap5-evm: Add mcspi data")
added pin muxing for mcspi4 that conflicts with the onboard
WLAN. While the omap5-uevm docs say the WLAN is not populated,
this was probably only the case for initial prototypes. Both
omap5-uevm boards I have have WLAN populated.

Let's fix the regression and add the WLAN configuration as
done for the other boards in 99f84cae43df ("ARM: dts: add
wl12xx/wl18xx bindings").

Note that without a related deferred probe fix for twl6040,
the 32k clock is not initialized if palmas-clk is a module
and twl6040 is built-in. And we should probably also request
the 32k clock from palmas directly for MMC3 eventually, but
that's another patch not related to this regression.

Let's also use the generic "non-removable" instead of the
legacy "ti,non-removable" property while at it.

Fixes: 392adaf796b9 ("ARM: dts: omap5-evm: Add mcspi data")
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 51 +++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 11 deletions(-)

--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -31,6 +31,18 @@
 		regulator-max-microvolt = <3000000>;
 	};
 
+	vmmcsdio_fixed: fixedregulator-mmcsdio {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsdio_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;	/* gpio140 WLAN_EN */
+		enable-active-high;
+		startup-delay-us = <70000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_pins>;
+	};
+
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
@@ -197,12 +209,20 @@
 		>;
 	};
 
-	mcspi4_pins: pinmux_mcspi4_pins {
+	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_clk */
-			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_simo */
-			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi4_somi */
-			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi4_cs0 */
+			OMAP5_IOPAD(0x01a4, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_clk */
+			OMAP5_IOPAD(0x01a6, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_cmd */
+			OMAP5_IOPAD(0x01a8, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data0 */
+			OMAP5_IOPAD(0x01aa, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data1 */
+			OMAP5_IOPAD(0x01ac, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data2 */
+			OMAP5_IOPAD(0x01ae, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data3 */
+		>;
+	};
+
+	wlan_pins: pinmux_wlan_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x1bc, PIN_OUTPUT | MUX_MODE6) /* mcspi1_clk.gpio5_140 */
 		>;
 	};
 
@@ -290,8 +310,22 @@
 };
 
 &mmc3 {
+	vmmc-supply = <&vmmcsdio_fixed>;
 	bus-width = <4>;
-	ti,non-removable;
+	non-removable;
+	cap-power-off-card;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1271";
+		reg = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;	/* gpio 14 */
+		ref-clock-frequency = <26000000>;
+	};
 };
 
 &mmc4 {
@@ -598,11 +632,6 @@
 	pinctrl-0 = <&mcspi3_pins>;
 };
 
-&mcspi4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi4_pins>;
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
-- 
2.1.4
