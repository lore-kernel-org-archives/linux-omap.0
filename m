From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Date: Thu, 13 Dec 2018 15:04:09 -0800
Message-ID: <20181213230411.5009-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With wlcore supporting optional wakeirqs, let's configure it for
omap3-evm and update the related pin muxing as some pins are left
unmuxed.

Let's configure a wakeirq both for the wlcore GPIO and the SDIO
dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
some point.

Note that for off-mode, the wlcore reset GPIO will have a glitch
meaning wlcore will reset. The only way to workaround for this
currently is to configure the reset pin with SAFE_MODE + PULL.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi           |  7 +++++--
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 10 +++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -122,6 +122,7 @@
 };
 
 &mmc2 {
+	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
 	vmmc-supply = <&wl12xx_vmmc>;
 	non-removable;
 	bus-width = <4>;
@@ -132,8 +133,10 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 149 */
+		/* gpio_149 with uart1_rts pad as wakeirq */
+		interrupts-extended = <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
+				      <&omap3_pmx_core 0x14e>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
--- a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
@@ -86,6 +86,10 @@
 			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
 			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
 			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat5.sdmmc2_dir_dat1 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat6.sdmmc2_dir_cmd */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)	/* sdmmc2_dat7.sdmmc2_clkin */
 		>;
 	};
 
@@ -127,9 +131,13 @@
 		>;
 	};
 
+	/*
+	 * Note that gpio_150 pulled high with internal pull to prevent wlcore
+	 * reset on return from off mode in idle.
+	 */
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE7)		/* uart1_cts.gpio_150 */
 			OMAP3_CORE1_IOPAD(0x217e, PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
 		>;
 	};
-- 
2.19.2
