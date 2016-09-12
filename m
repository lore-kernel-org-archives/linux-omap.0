From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: dts: ARM: dts: Fix omap5 SDIO dat1 interrupt
Date: Sun, 11 Sep 2016 21:01:02 -0700
Message-ID: <20160912040100.llah4hxy2faoflk7@atomide.com>
References: <20160909210243.19296-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160909210243.19296-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160909 14:02]:
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -332,7 +332,7 @@
>  
>  	wlcore_irq_pin: pinmux_wlcore_irq_pin {
>  		pinctrl-single,pins = <
> -			OMAP5_IOPAD(0x40, PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
> +			OMAP5_IOPAD(0x40, PIN_INPUT | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
>  		>;
>  	};
>  };
> @@ -355,15 +355,17 @@
>  	non-removable;
>  	cap-power-off-card;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc3_pins &wlcore_irq_pin>;
> +	pinctrl-0 = <&mmc3_pins>;
>  	interrupts-extended = <&gic GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
> -			       &omap5_pmx_core 0x168>;
> +			       &omap5_pmx_core 0x16a>;
>  

And the &gic is wrong here, it should be &wakeupgen. That seems to
make things a bit better on omap5-uevm. Updated patch below.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 8 Sep 2016 09:04:50 -0700
Subject: [PATCH] ARM: dts: ARM: dts: Fix omap5 SDIO dat1 interrupt

Few changes to fix issues I've noticed while debugging omap5-uevm
wl18xx issues:

1. Move wlcore irq pin muxing under wlcore. This irq could be
   different from gpio_wk14 on some board variants

2. Don't configure pull on wlcore irq pin. There is a 10k
   pull up resistor R105 on the device to VDDS_1v8_MAIN

3. The padconf register for wlsdio_data1 is wrong, it's really
   at 0x1a8 + 2 - 0x40 = 0x16a offset, not at 0x168 as that's
   for wlsdio_data0

4. Mark the omap5-uevm wlan as compatible with ti,wl1837 as
   that's what the TDK R078 part seems to be

5. The MMC interrupt for WLAN musb be wakeupgen, not gic

Looks like omap5-uevm WLAN behaves better now, but I still seem
to have issues with some access points.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 10 ++++++----
 arch/arm/boot/dts/omap5-uevm.dts          |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -332,7 +332,7 @@
 
 	wlcore_irq_pin: pinmux_wlcore_irq_pin {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x40, PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
+			OMAP5_IOPAD(0x40, PIN_INPUT | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
 		>;
 	};
 };
@@ -355,15 +355,17 @@
 	non-removable;
 	cap-power-off-card;
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins &wlcore_irq_pin>;
-	interrupts-extended = <&gic GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
-			       &omap5_pmx_core 0x168>;
+	pinctrl-0 = <&mmc3_pins>;
+	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+			       &omap5_pmx_core 0x16a>;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlcore_irq_pin>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;	/* gpio 14 */
 		ref-clock-frequency = <26000000>;
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -61,3 +61,7 @@
 		OMAP5_IOPAD(0x1be, PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_141 */
 	>;
 };
+
+&wlcore {
+	compatible = "ti,wl1837";
+};
-- 
2.9.3
