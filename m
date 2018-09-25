From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe them
 with ti-sysc
Date: Mon, 24 Sep 2018 17:05:43 -0700
Message-ID: <20180925000545.22931-3-tony@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180925000545.22931-1-tony@atomide.com>
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With l4 interconnect hierarchy and ti-sysc interconnect target module
data in place, we can simply move all the related child devices to
their proper location and enable probing using ti-sysc.

In general the first child device address range starts at range 0
from the ti-sysc interconnect target so the move involves adjusting
the child device reg properties for that.

In case of any regressions, problem devices can be reverted to probe
with legacy platform data as needed by moving them back and removing
the related interconnect target module node.

Note that we are not yet moving dss or wkup_m3, those will be moved
later after some related driver changes.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am4372.dtsi    | 876 +------------------------------
 arch/arm/boot/dts/am437x-l4.dtsi | 865 +++++++++++++++++++++++++++++-
 2 files changed, 858 insertions(+), 883 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/am4.h>
@@ -159,12 +160,7 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
-		l4_wkup: l4_wkup@44c00000 {
-			compatible = "ti,am4-l4-wkup", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x44c00000 0x287000>;
-
+		l4_wkup: interconnect@44c00000 {
 			wkup_m3: wkup_m3@100000 {
 				compatible = "ti,am4372-wkup-m3";
 				reg = <0x100000 0x4000>,
@@ -173,75 +169,10 @@
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
 			};
-
-			prcm: prcm@1f0000 {
-				compatible = "ti,am4-prcm", "simple-bus";
-				reg = <0x1f0000 0x11000>;
-				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1f0000 0x11000>;
-
-				prcm_clocks: clocks {
-					#address-cells = <1>;
-					#size-cells = <0>;
-				};
-
-				prcm_clockdomains: clockdomains {
-				};
-			};
-
-			scm: scm@210000 {
-				compatible = "ti,am4-scm", "simple-bus";
-				reg = <0x210000 0x4000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x210000 0x4000>;
-
-				am43xx_pinmux: pinmux@800 {
-					compatible = "ti,am437-padconf",
-						     "pinctrl-single";
-					reg = <0x800 0x31c>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-					#pinctrl-cells = <1>;
-					#interrupt-cells = <1>;
-					interrupt-controller;
-					pinctrl-single,register-width = <32>;
-					pinctrl-single,function-mask = <0xffffffff>;
-				};
-
-				scm_conf: scm_conf@0 {
-					compatible = "syscon";
-					reg = <0x0 0x800>;
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					scm_clocks: clocks {
-						#address-cells = <1>;
-						#size-cells = <0>;
-					};
-				};
-
-				wkup_m3_ipc: wkup_m3_ipc@1324 {
-					compatible = "ti,am4372-wkup-m3-ipc";
-					reg = <0x1324 0x44>;
-					interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-					ti,rproc = <&wkup_m3>;
-					mboxes = <&mailbox &mbox_wkupm3>;
-				};
-
-				edma_xbar: dma-router@f90 {
-					compatible = "ti,am335x-edma-crossbar";
-					reg = <0xf90 0x40>;
-					#dma-cells = <3>;
-					dma-requests = <64>;
-					dma-masters = <&edma>;
-				};
-
-				scm_clockdomains: clockdomains {
-				};
-			};
+		};
+		l4_per: interconnect@48000000 {
+		};
+		l4_fast: interconnect@4a000000 {
 		};
 
 		emif: emif@4c000000 {
@@ -297,333 +228,6 @@
 			interrupt-names = "edma3_tcerrint";
 		};
 
-		uart0: serial@44e09000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x44e09000 0x2000>;
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart1";
-		};
-
-		uart1: serial@48022000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x48022000 0x2000>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart2";
-			status = "disabled";
-		};
-
-		uart2: serial@48024000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x48024000 0x2000>;
-			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart3";
-			status = "disabled";
-		};
-
-		uart3: serial@481a6000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x481a6000 0x2000>;
-			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart4";
-			status = "disabled";
-		};
-
-		uart4: serial@481a8000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x481a8000 0x2000>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart5";
-			status = "disabled";
-		};
-
-		uart5: serial@481aa000 {
-			compatible = "ti,am4372-uart","ti,omap2-uart";
-			reg = <0x481aa000 0x2000>;
-			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "uart6";
-			status = "disabled";
-		};
-
-		mailbox: mailbox@480c8000 {
-			compatible = "ti,omap4-mailbox";
-			reg = <0x480C8000 0x200>;
-			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mailbox";
-			#mbox-cells = <1>;
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <8>;
-			mbox_wkupm3: wkup_m3 {
-				ti,mbox-send-noirq;
-				ti,mbox-tx = <0 0 0>;
-				ti,mbox-rx = <0 0 3>;
-			};
-		};
-
-		timer1: timer@44e31000 {
-			compatible = "ti,am4372-timer-1ms","ti,am335x-timer-1ms";
-			reg = <0x44e31000 0x400>;
-			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-			ti,timer-alwon;
-			ti,hwmods = "timer1";
-			clocks = <&timer1_fck>;
-			clock-names = "fck";
-		};
-
-		timer2: timer@48040000  {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48040000  0x400>;
-			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer2";
-			clocks = <&timer2_fck>;
-			clock-names = "fck";
-		};
-
-		timer3: timer@48042000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48042000 0x400>;
-			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer3";
-			status = "disabled";
-		};
-
-		timer4: timer@48044000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48044000 0x400>;
-			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-			ti,timer-pwm;
-			ti,hwmods = "timer4";
-			status = "disabled";
-		};
-
-		timer5: timer@48046000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48046000 0x400>;
-			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-			ti,timer-pwm;
-			ti,hwmods = "timer5";
-			status = "disabled";
-		};
-
-		timer6: timer@48048000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48048000 0x400>;
-			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			ti,timer-pwm;
-			ti,hwmods = "timer6";
-			status = "disabled";
-		};
-
-		timer7: timer@4804a000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x4804a000 0x400>;
-			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			ti,timer-pwm;
-			ti,hwmods = "timer7";
-			status = "disabled";
-		};
-
-		timer8: timer@481c1000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x481c1000 0x400>;
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer8";
-			status = "disabled";
-		};
-
-		timer9: timer@4833d000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x4833d000 0x400>;
-			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer9";
-			status = "disabled";
-		};
-
-		timer10: timer@4833f000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x4833f000 0x400>;
-			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer10";
-			status = "disabled";
-		};
-
-		timer11: timer@48341000 {
-			compatible = "ti,am4372-timer","ti,am335x-timer";
-			reg = <0x48341000 0x400>;
-			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "timer11";
-			status = "disabled";
-		};
-
-		counter32k: counter@44e86000 {
-			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
-			reg = <0x44e86000 0x40>;
-			ti,hwmods = "counter_32k";
-		};
-
-		rtc: rtc@44e3e000 {
-			compatible = "ti,am4372-rtc", "ti,am3352-rtc",
-				     "ti,da830-rtc";
-			reg = <0x44e3e000 0x1000>;
-			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "rtc";
-			clocks = <&clk_32768_ck>;
-			clock-names = "int-clk";
-			system-power-controller;
-			status = "disabled";
-		};
-
-		wdt: wdt@44e35000 {
-			compatible = "ti,am4372-wdt","ti,omap3-wdt";
-			reg = <0x44e35000 0x1000>;
-			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "wd_timer2";
-		};
-
-		gpio0: gpio@44e07000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x44e07000 0x1000>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio1";
-			status = "disabled";
-		};
-
-		gpio1: gpio@4804c000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x4804c000 0x1000>;
-			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio2";
-			status = "disabled";
-		};
-
-		gpio2: gpio@481ac000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x481ac000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio3";
-			status = "disabled";
-		};
-
-		gpio3: gpio@481ae000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x481ae000 0x1000>;
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio4";
-			status = "disabled";
-		};
-
-		gpio4: gpio@48320000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x48320000 0x1000>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio5";
-			status = "disabled";
-		};
-
-		gpio5: gpio@48322000 {
-			compatible = "ti,am4372-gpio","ti,omap4-gpio";
-			reg = <0x48322000 0x1000>;
-			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ti,hwmods = "gpio6";
-			status = "disabled";
-		};
-
-		hwspinlock: spinlock@480ca000 {
-			compatible = "ti,omap4-hwspinlock";
-			reg = <0x480ca000 0x1000>;
-			ti,hwmods = "spinlock";
-			#hwlock-cells = <1>;
-		};
-
-		i2c0: i2c@44e0b000 {
-			compatible = "ti,am4372-i2c","ti,omap4-i2c";
-			reg = <0x44e0b000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "i2c1";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@4802a000 {
-			compatible = "ti,am4372-i2c","ti,omap4-i2c";
-			reg = <0x4802a000 0x1000>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "i2c2";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@4819c000 {
-			compatible = "ti,am4372-i2c","ti,omap4-i2c";
-			reg = <0x4819c000 0x1000>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "i2c3";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi0: spi@48030000 {
-			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
-			reg = <0x48030000 0x400>;
-			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "spi0";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		mmc1: mmc@48060000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x48060000 0x1000>;
-			ti,hwmods = "mmc1";
-			ti,dual-volt;
-			ti,needs-special-reset;
-			dmas = <&edma 24 0>,
-				<&edma 25 0>;
-			dma-names = "tx", "rx";
-			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		mmc2: mmc@481d8000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x481d8000 0x1000>;
-			ti,hwmods = "mmc2";
-			ti,needs-special-reset;
-			dmas = <&edma 2 0>,
-				<&edma 3 0>;
-			dma-names = "tx", "rx";
-			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
 		mmc3: mmc@47810000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x47810000 0x1000>;
@@ -633,282 +237,6 @@
 			status = "disabled";
 		};
 
-		spi1: spi@481a0000 {
-			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
-			reg = <0x481a0000 0x400>;
-			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "spi1";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi2: spi@481a2000 {
-			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
-			reg = <0x481a2000 0x400>;
-			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "spi2";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi3: spi@481a4000 {
-			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
-			reg = <0x481a4000 0x400>;
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "spi3";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi4: spi@48345000 {
-			compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
-			reg = <0x48345000 0x400>;
-			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "spi4";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		mac: ethernet@4a100000 {
-			compatible = "ti,am4372-cpsw","ti,cpsw";
-			reg = <0x4a100000 0x800
-			       0x4a101200 0x100>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ti,hwmods = "cpgmac0";
-			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>,
-				 <&dpll_clksel_mac_clk>;
-			clock-names = "fck", "cpts", "50mclk";
-			assigned-clocks = <&dpll_clksel_mac_clk>;
-			assigned-clock-rates = <50000000>;
-			status = "disabled";
-			cpdma_channels = <8>;
-			ale_entries = <1024>;
-			bd_ram_size = <0x2000>;
-			mac_control = <0x20>;
-			slaves = <2>;
-			active_slave = <0>;
-			cpts_clock_mult = <0x80000000>;
-			cpts_clock_shift = <29>;
-			ranges;
-			syscon = <&scm_conf>;
-
-			davinci_mdio: mdio@4a101000 {
-				compatible = "ti,am4372-mdio","ti,cpsw-mdio","ti,davinci_mdio";
-				reg = <0x4a101000 0x100>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,hwmods = "davinci_mdio";
-				bus_freq = <1000000>;
-				status = "disabled";
-			};
-
-			cpsw_emac0: slave@4a100200 {
-				/* Filled in by U-Boot */
-				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			cpsw_emac1: slave@4a100300 {
-				/* Filled in by U-Boot */
-				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel@44e10650 {
-				compatible = "ti,am43xx-cpsw-phy-sel";
-				reg= <0x44e10650 0x4>;
-				reg-names = "gmii-sel";
-			};
-		};
-
-		epwmss0: epwmss@48300000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x48300000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss0";
-			status = "disabled";
-
-			ecap0: ecap@48300100 {
-				compatible = "ti,am4372-ecap",
-					     "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48300100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				status = "disabled";
-			};
-
-			ehrpwm0: pwm@48300200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48300200 0x80>;
-				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		epwmss1: epwmss@48302000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x48302000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss1";
-			status = "disabled";
-
-			ecap1: ecap@48302100 {
-				compatible = "ti,am4372-ecap",
-					     "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48302100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				status = "disabled";
-			};
-
-			ehrpwm1: pwm@48302200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48302200 0x80>;
-				clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		epwmss2: epwmss@48304000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x48304000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss2";
-			status = "disabled";
-
-			ecap2: ecap@48304100 {
-				compatible = "ti,am4372-ecap",
-					     "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48304100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				status = "disabled";
-			};
-
-			ehrpwm2: pwm@48304200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48304200 0x80>;
-				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		epwmss3: epwmss@48306000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x48306000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss3";
-			status = "disabled";
-
-			ehrpwm3: pwm@48306200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48306200 0x80>;
-				clocks = <&ehrpwm3_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		epwmss4: epwmss@48308000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x48308000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss4";
-			status = "disabled";
-
-			ehrpwm4: pwm@48308200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48308200 0x80>;
-				clocks = <&ehrpwm4_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		epwmss5: epwmss@4830a000 {
-			compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-			reg = <0x4830a000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "epwmss5";
-			status = "disabled";
-
-			ehrpwm5: pwm@4830a200 {
-				compatible = "ti,am4372-ehrpwm",
-					     "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x4830a200 0x80>;
-				clocks = <&ehrpwm5_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		tscadc: tscadc@44e0d000 {
-			compatible = "ti,am3359-tscadc";
-			reg = <0x44e0d000 0x1000>;
-			ti,hwmods = "adc_tsc";
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&adc_tsc_fck>;
-			clock-names = "fck";
-			status = "disabled";
-			dmas = <&edma 53 0>, <&edma 57 0>;
-			dma-names = "fifo0", "fifo1";
-
-			tsc {
-				compatible = "ti,am3359-tsc";
-			};
-
-			adc {
-				#io-channel-cells = <1>;
-				compatible = "ti,am3359-adc";
-			};
-
-		};
-
 		sham: sham@53100000 {
 			compatible = "ti,omap5-sham";
 			ti,hwmods = "sham";
@@ -938,53 +266,6 @@
 			dma-names = "tx", "rx";
 		};
 
-		rng: rng@48310000 {
-			compatible = "ti,omap4-rng";
-			ti,hwmods = "rng";
-			reg = <0x48310000 0x2000>;
-			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		mcasp0: mcasp@48038000 {
-			compatible = "ti,am33xx-mcasp-audio";
-			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>,
-			      <0x46000000 0x400000>;
-			reg-names = "mpu", "dat";
-			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			status = "disabled";
-			dmas = <&edma 8 2>,
-			       <&edma 9 2>;
-			dma-names = "tx", "rx";
-		};
-
-		mcasp1: mcasp@4803c000 {
-			compatible = "ti,am33xx-mcasp-audio";
-			ti,hwmods = "mcasp1";
-			reg = <0x4803C000 0x2000>,
-			      <0x46400000 0x400000>;
-			reg-names = "mpu", "dat";
-			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			status = "disabled";
-			dmas = <&edma 10 2>,
-			       <&edma 11 2>;
-			dma-names = "tx", "rx";
-		};
-
-		elm: elm@48080000 {
-			compatible = "ti,am3352-elm";
-			reg = <0x48080000 0x2000>;
-			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "elm";
-			clocks = <&l4ls_gclk>;
-			clock-names = "fck";
-			status = "disabled";
-		};
-
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
@@ -1005,102 +286,6 @@
 			status = "disabled";
 		};
 
-		ocp2scp0: ocp2scp@483a8000 {
-			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "ocp2scp0";
-
-			usb2_phy1: phy@483a8000 {
-				compatible = "ti,am437x-usb2";
-				reg = <0x483a8000 0x8000>;
-				syscon-phy-power = <&scm_conf 0x620>;
-				clocks = <&usb_phy0_always_on_clk32k>,
-					 <&l3s_clkctrl AM4_L3S_USB_OTG_SS0_CLKCTRL 8>;
-				clock-names = "wkupclk", "refclk";
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-		};
-
-		ocp2scp1: ocp2scp@483e8000 {
-			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			ti,hwmods = "ocp2scp1";
-
-			usb2_phy2: phy@483e8000 {
-				compatible = "ti,am437x-usb2";
-				reg = <0x483e8000 0x8000>;
-				syscon-phy-power = <&scm_conf 0x628>;
-				clocks = <&usb_phy1_always_on_clk32k>,
-					 <&l3s_clkctrl AM4_L3S_USB_OTG_SS1_CLKCTRL 8>;
-				clock-names = "wkupclk", "refclk";
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-		};
-
-		dwc3_1: omap_dwc3@48380000 {
-			compatible = "ti,am437x-dwc3";
-			ti,hwmods = "usb_otg_ss0";
-			reg = <0x48380000 0x10000>;
-			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			utmi-mode = <1>;
-			ranges;
-
-			usb1: usb@48390000 {
-				compatible = "synopsys,dwc3";
-				reg = <0x48390000 0x10000>;
-				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "peripheral",
-						  "host",
-						  "otg";
-				phys = <&usb2_phy1>;
-				phy-names = "usb2-phy";
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-				status = "disabled";
-				snps,dis_u3_susphy_quirk;
-				snps,dis_u2_susphy_quirk;
-			};
-		};
-
-		dwc3_2: omap_dwc3@483c0000 {
-			compatible = "ti,am437x-dwc3";
-			ti,hwmods = "usb_otg_ss1";
-			reg = <0x483c0000 0x10000>;
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			utmi-mode = <1>;
-			ranges;
-
-			usb2: usb@483d0000 {
-				compatible = "synopsys,dwc3";
-				reg = <0x483d0000 0x10000>;
-				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "peripheral",
-						  "host",
-						  "otg";
-				phys = <&usb2_phy2>;
-				phy-names = "usb2-phy";
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-				status = "disabled";
-				snps,dis_u3_susphy_quirk;
-				snps,dis_u2_susphy_quirk;
-			};
-		};
-
 		qspi: spi@47900000 {
 			compatible = "ti,am4372-qspi";
 			reg = <0x47900000 0x100>,
@@ -1114,16 +299,6 @@
 			status = "disabled";
 		};
 
-		hdq: hdq@48347000 {
-			compatible = "ti,am4372-hdq";
-			reg = <0x48347000 0x1000>;
-			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&func_12m_clk>;
-			clock-names = "fck";
-			ti,hwmods = "hdq1w";
-			status = "disabled";
-		};
-
 		dss: dss@4832a000 {
 			compatible = "ti,omap3-dss";
 			reg = <0x4832a000 0x200>;
@@ -1173,45 +348,8 @@
 				pool;
 			};
 		};
-
-		dcan0: can@481cc000 {
-			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
-			ti,hwmods = "d_can0";
-			clocks = <&dcan0_fck>;
-			clock-names = "fck";
-			reg = <0x481cc000 0x2000>;
-			syscon-raminit = <&scm_conf 0x644 0>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		dcan1: can@481d0000 {
-			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
-			ti,hwmods = "d_can1";
-			clocks = <&dcan1_fck>;
-			clock-names = "fck";
-			reg = <0x481d0000 0x2000>;
-			syscon-raminit = <&scm_conf 0x644 1>;
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		vpfe0: vpfe@48326000 {
-			compatible = "ti,am437x-vpfe";
-			reg = <0x48326000 0x2000>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "vpfe0";
-			status = "disabled";
-		};
-
-		vpfe1: vpfe@48328000 {
-			compatible = "ti,am437x-vpfe";
-			reg = <0x48328000 0x2000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "vpfe1";
-			status = "disabled";
-		};
 	};
 };
 
+#include "am437x-l4.dtsi"
 #include "am43xx-clocks.dtsi"
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -48,11 +48,29 @@
 		};
 
 		target-module@f0000 {			/* 0x44df0000, ap 8 58.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0xf0000 0x4>;
+			reg-names = "rev";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xf0000 0x10000>;
+
+			prcm: prcm@0 {
+				compatible = "ti,am4-prcm", "simple-bus";
+				reg = <0x0 0x11000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x11000>;
+
+				prcm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				prcm_clockdomains: clockdomains {
+				};
+			};
 		};
 	};
 
@@ -134,6 +152,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x7000 0x1000>;
+
+			gpio0: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@9000 {			/* 0x44e09000, ap 16 04.0 */
@@ -156,6 +185,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9000 0x1000>;
+
+			uart0: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		target-module@b000 {			/* 0x44e0b000, ap 18 48.0 */
@@ -180,6 +215,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xb000 0x1000>;
+
+			i2c0: i2c@0 {
+				compatible = "ti,am4372-i2c","ti,omap4-i2c";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d000 {			/* 0x44e0d000, ap 20 38.0 */
@@ -198,14 +242,94 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd000 0x1000>;
+
+			tscadc: tscadc@0 {
+				compatible = "ti,am3359-tscadc";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&adc_tsc_fck>;
+				clock-names = "fck";
+				status = "disabled";
+				dmas = <&edma 53 0>, <&edma 57 0>;
+				dma-names = "fifo0", "fifo1";
+
+				tsc {
+					compatible = "ti,am3359-tsc";
+				};
+
+				adc {
+					#io-channel-cells = <1>;
+					compatible = "ti,am3359-adc";
+				};
+
+			};
 		};
 
 		target-module@10000 {			/* 0x44e10000, ap 22 0c.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x10000 0x4>;
+			reg-names = "rev";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x10000 0x10000>;
+
+			scm: scm@0 {
+				compatible = "ti,am4-scm", "simple-bus";
+				reg = <0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x4000>;
+
+				phy_sel: cpsw-phy-sel@650 {
+					compatible = "ti,am43xx-cpsw-phy-sel";
+					reg= <0x650 0x4>;
+					reg-names = "gmii-sel";
+				};
+
+				am43xx_pinmux: pinmux@800 {
+					compatible = "ti,am437-padconf",
+						     "pinctrl-single";
+					reg = <0x800 0x31c>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#pinctrl-cells = <1>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <32>;
+					pinctrl-single,function-mask = <0xffffffff>;
+				};
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon";
+					reg = <0x0 0x800>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					scm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+
+				wkup_m3_ipc: wkup_m3_ipc@1324 {
+					compatible = "ti,am4372-wkup-m3-ipc";
+					reg = <0x1324 0x44>;
+					interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+					ti,rproc = <&wkup_m3>;
+					mboxes = <&mailbox &mbox_wkupm3>;
+				};
+
+				edma_xbar: dma-router@f90 {
+					compatible = "ti,am335x-edma-crossbar";
+					reg = <0xf90 0x40>;
+					#dma-cells = <3>;
+					dma-requests = <64>;
+					dma-masters = <&edma>;
+				};
+
+				scm_clockdomains: clockdomains {
+				};
+			};
 		};
 
 		target-module@31000 {			/* 0x44e31000, ap 24 40.0 */
@@ -228,6 +352,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x31000 0x1000>;
+
+			timer1: timer@0 {
+				compatible = "ti,am4372-timer-1ms","ti,am335x-timer-1ms";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-alwon;
+				clocks = <&timer1_fck>;
+				clock-names = "fck";
+			};
 		};
 
 		target-module@33000 {			/* 0x44e33000, ap 26 18.0 */
@@ -258,6 +391,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x35000 0x1000>;
+
+			wdt: wdt@0 {
+				compatible = "ti,am4372-wdt","ti,omap3-wdt";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		target-module@37000 {			/* 0x44e37000, ap 30 08.0 */
@@ -292,6 +431,18 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3e000 0x1000>;
+
+			rtc: rtc@0 {
+				compatible = "ti,am4372-rtc", "ti,am3352-rtc",
+					     "ti,da830-rtc";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
+					      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_32768_ck>;
+				clock-names = "int-clk";
+				system-power-controller;
+				status = "disabled";
+			};
 		};
 
 		target-module@40000 {			/* 0x44e40000, ap 36 68.0 */
@@ -316,6 +467,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x86000 0x1000>;
+
+			counter32k: counter@0 {
+				compatible = "ti,am4372-counter32k","ti,omap-counter32k";
+				reg = <0x0 0x40>;
+			};
 		};
 
 		target-module@88000 {			/* 0x44e88000, ap 38 12.0 */
@@ -355,11 +511,74 @@
 			 <0x00280000 0x00280000 0x001000>;	/* ap 8 */
 
 		target-module@100000 {			/* 0x4a100000, ap 3 04.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			ti,hwmods = "cpgmac0";
+			reg = <0x101200 0x4>,
+			      <0x101208 0x4>,
+			      <0x101204 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <0>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>;
+			ti,syss-mask = <1>;
+			clocks = <&cpsw_125mhz_clkctrl AM4_CPSW_125MHZ_CPGMAC0_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x100000 0x8000>;
+
+			mac: ethernet@0 {
+				compatible = "ti,am4372-cpsw","ti,cpsw";
+				reg = <0x0 0x800
+				       0x1200 0x100>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
+					      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
+					      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
+					      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>,
+					 <&dpll_clksel_mac_clk>;
+				clock-names = "fck", "cpts", "50mclk";
+				assigned-clocks = <&dpll_clksel_mac_clk>;
+				assigned-clock-rates = <50000000>;
+				status = "disabled";
+				cpdma_channels = <8>;
+				ale_entries = <1024>;
+				bd_ram_size = <0x2000>;
+				mac_control = <0x20>;
+				slaves = <2>;
+				active_slave = <0>;
+				cpts_clock_mult = <0x80000000>;
+				cpts_clock_shift = <29>;
+				ranges = <0 0 0x8000>;
+				syscon = <&scm_conf>;
+				cpsw-phy-sel = <&phy_sel>;
+
+				davinci_mdio: mdio@1000 {
+					compatible = "ti,am4372-mdio","ti,cpsw-mdio","ti,davinci_mdio";
+					reg = <0x1000 0x100>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&cpsw_125mhz_gclk>;
+					clock-names = "fck";
+					ti,hwmods = "davinci_mdio";
+					bus_freq = <1000000>;
+					status = "disabled";
+				};
+
+				cpsw_emac0: slave@200 {
+					/* Filled in by U-Boot */
+					mac-address = [ 00 00 00 00 00 00 ];
+				};
+
+				cpsw_emac1: slave@300 {
+					/* Filled in by U-Boot */
+					mac-address = [ 00 00 00 00 00 00 ];
+				};
+			};
 		};
 
 		target-module@200000 {			/* 0x4a200000, ap 7 02.0 */
@@ -475,6 +694,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x22000 0x1000>;
+
+			uart1: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@24000 {			/* 0x48024000, ap 10 1c.0 */
@@ -497,6 +723,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x24000 0x1000>;
+
+			uart2: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@2a000 {			/* 0x4802a000, ap 12 22.0 */
@@ -521,6 +754,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x2a000 0x1000>;
+
+			i2c1: i2c@0 {
+				compatible = "ti,am4372-i2c","ti,omap4-i2c";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@30000 {			/* 0x48030000, ap 65 08.0 */
@@ -543,6 +785,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x30000 0x1000>;
+
+			spi0: spi@0 {
+				compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@34000 {			/* 0x48034000, ap 80 56.0 */
@@ -576,6 +827,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x38000 0x2000>;
+
+			mcasp0: mcasp@0 {
+				compatible = "ti,am33xx-mcasp-audio";
+				reg = <0x0 0x2000>,
+				      <0x46000000 0x400000>;
+				reg-names = "mpu", "dat";
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "tx", "rx";
+				status = "disabled";
+				dmas = <&edma 8 2>,
+				       <&edma 9 2>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@3c000 {			/* 0x4803c000, ap 16 2a.0 */
@@ -593,6 +858,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3c000 0x2000>;
+
+			mcasp1: mcasp@0 {
+				compatible = "ti,am33xx-mcasp-audio";
+				reg = <0x0 0x2000>,
+				      <0x46400000 0x400000>;
+				reg-names = "mpu", "dat";
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "tx", "rx";
+				status = "disabled";
+				dmas = <&edma 10 2>,
+				       <&edma 11 2>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@40000 {			/* 0x48040000, ap 18 1e.0 */
@@ -613,6 +892,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x40000 0x1000>;
+
+			timer2: timer@0  {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&timer2_fck>;
+				clock-names = "fck";
+			};
 		};
 
 		target-module@42000 {			/* 0x48042000, ap 20 24.0 */
@@ -633,6 +920,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x42000 0x1000>;
+
+			timer3: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@44000 {			/* 0x48044000, ap 22 26.0 */
@@ -653,6 +947,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x44000 0x1000>;
+
+			timer4: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
+				status = "disabled";
+			};
 		};
 
 		target-module@46000 {			/* 0x48046000, ap 24 28.0 */
@@ -673,6 +975,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x46000 0x1000>;
+
+			timer5: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
+				status = "disabled";
+			};
 		};
 
 		target-module@48000 {			/* 0x48048000, ap 26 1a.0 */
@@ -693,6 +1003,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x48000 0x1000>;
+
+			timer6: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
+				status = "disabled";
+			};
 		};
 
 		target-module@4a000 {			/* 0x4804a000, ap 71 48.0 */
@@ -713,6 +1031,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4a000 0x1000>;
+
+			timer7: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+				ti,timer-pwm;
+				status = "disabled";
+			};
 		};
 
 		target-module@4c000 {			/* 0x4804c000, ap 28 36.0 */
@@ -737,6 +1063,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4c000 0x1000>;
+
+			gpio1: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@60000 {			/* 0x48060000, ap 30 14.0 */
@@ -760,6 +1097,18 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x60000 0x1000>;
+
+			mmc1: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				reg = <0x0 0x1000>;
+				ti,dual-volt;
+				ti,needs-special-reset;
+				dmas = <&edma 24 0>,
+					<&edma 25 0>;
+				dma-names = "tx", "rx";
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@80000 {			/* 0x48080000, ap 32 18.0 */
@@ -782,6 +1131,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x80000 0x10000>;
+
+			elm: elm@0 {
+				compatible = "ti,am3352-elm";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
+				status = "disabled";
+			};
 		};
 
 		target-module@c8000 {			/* 0x480c8000, ap 73 06.0 */
@@ -800,6 +1158,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xc8000 0x1000>;
+
+			mailbox: mailbox@0 {
+				compatible = "ti,omap4-mailbox";
+				reg = <0x0 0x200>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <1>;
+				ti,mbox-num-users = <4>;
+				ti,mbox-num-fifos = <8>;
+				mbox_wkupm3: wkup_m3 {
+					ti,mbox-send-noirq;
+					ti,mbox-tx = <0 0 0>;
+					ti,mbox-rx = <0 0 3>;
+				};
+			};
 		};
 
 		target-module@ca000 {			/* 0x480ca000, ap 77 38.0 */
@@ -823,6 +1195,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xca000 0x1000>;
+
+			hwspinlock: spinlock@0 {
+				compatible = "ti,omap4-hwspinlock";
+				reg = <0x0 0x1000>;
+				#hwlock-cells = <1>;
+			};
 		};
 	};
 
@@ -899,6 +1277,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9c000 0x1000>;
+
+			i2c2: i2c@0 {
+				compatible = "ti,am4372-i2c","ti,omap4-i2c";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a0000 {			/* 0x481a0000, ap 67 2c.0 */
@@ -921,6 +1308,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa0000 0x1000>;
+
+			spi1: spi@0 {
+				compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a2000 {			/* 0x481a2000, ap 69 2e.0 */
@@ -943,6 +1339,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa2000 0x1000>;
+
+			spi2: spi@0 {
+				compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a4000 {			/* 0x481a4000, ap 92 62.0 */
@@ -965,6 +1370,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa4000 0x1000>;
+
+			spi3: spi@0 {
+				compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a6000 {			/* 0x481a6000, ap 40 16.0 */
@@ -987,6 +1401,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa6000 0x1000>;
+
+			uart3: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a8000 {			/* 0x481a8000, ap 42 20.0 */
@@ -1009,6 +1430,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa8000 0x1000>;
+
+			uart4: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@aa000 {			/* 0x481aa000, ap 44 12.0 */
@@ -1031,6 +1459,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xaa000 0x1000>;
+
+			uart5: serial@0 {
+				compatible = "ti,am4372-uart","ti,omap2-uart";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@ac000 {			/* 0x481ac000, ap 46 30.0 */
@@ -1055,6 +1490,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xac000 0x1000>;
+
+			gpio2: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@ae000 {			/* 0x481ae000, ap 48 32.0 */
@@ -1079,6 +1525,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xae000 0x1000>;
+
+			gpio3: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@c1000 {			/* 0x481c1000, ap 94 68.0 */
@@ -1099,22 +1556,55 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xc1000 0x1000>;
+
+			timer8: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@cc000 {			/* 0x481cc000, ap 50 46.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "d_can0";
+			reg = <0xcc000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN0_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xcc000 0x2000>;
+
+			dcan0: can@0 {
+				compatible = "ti,am4372-d_can", "ti,am3352-d_can";
+				reg = <0x0 0x2000>;
+				syscon-raminit = <&scm_conf 0x644 0>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d0000 {			/* 0x481d0000, ap 52 3a.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "d_can1";
+			reg = <0xd0000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM4_L4LS_D_CAN1_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd0000 0x2000>;
+
+			dcan1: can@0 {
+				compatible = "ti,am4372-d_can", "ti,am3352-d_can";
+				reg = <0x0 0x2000>;
+				syscon-raminit = <&scm_conf 0x644 1>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d8000 {			/* 0x481d8000, ap 54 5e.0 */
@@ -1138,6 +1628,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd8000 0x1000>;
+
+			mmc2: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				reg = <0x0 0x1000>;
+				ti,needs-special-reset;
+				dmas = <&edma 2 0>,
+					<&edma 3 0>;
+				dma-names = "tx", "rx";
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 	};
 
@@ -1226,6 +1727,37 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x1000>;
+
+			epwmss0: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ecap0: ecap@100 {
+					compatible = "ti,am4372-ecap",
+						     "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					status = "disabled";
+				};
+
+				ehrpwm0: pwm@200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@2000 {			/* 0x48302000, ap 58 4a.0 */
@@ -1248,6 +1780,37 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x2000 0x1000>;
+
+			epwmss1: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ecap1: ecap@100 {
+					compatible = "ti,am4372-ecap",
+						     "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					status = "disabled";
+				};
+
+				ehrpwm1: pwm@200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@4000 {			/* 0x48304000, ap 60 44.0 */
@@ -1270,6 +1833,37 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4000 0x1000>;
+
+			epwmss2: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ecap2: ecap@100 {
+					compatible = "ti,am4372-ecap",
+						     "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					status = "disabled";
+				};
+
+				ehrpwm2: pwm@200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@6000 {			/* 0x48306000, ap 96 58.0 */
@@ -1292,6 +1886,26 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x6000 0x1000>;
+
+			epwmss3: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ehrpwm3: pwm@200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm3_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@8000 {			/* 0x48308000, ap 98 54.0 */
@@ -1314,6 +1928,26 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x8000 0x1000>;
+
+			epwmss4: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ehrpwm4: pwm@48308200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm4_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@a000 {			/* 0x4830a000, ap 100 60.0 */
@@ -1336,6 +1970,26 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa000 0x1000>;
+
+			epwmss5: epwmss@0 {
+				compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x1000>;
+				status = "disabled";
+
+				ehrpwm5: pwm@200 {
+					compatible = "ti,am4372-ehrpwm",
+						     "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x200 0x80>;
+					clocks = <&ehrpwm5_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@10000 {			/* 0x48310000, ap 64 4e.1 */
@@ -1353,6 +2007,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x10000 0x2000>;
+
+			rng: rng@0 {
+				compatible = "ti,omap4-rng";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		target-module@13000 {			/* 0x48313000, ap 90 50.0 */
@@ -1393,6 +2053,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x20000 0x1000>;
+
+			gpio4: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@22000 {			/* 0x48322000, ap 116 64.0 */
@@ -1417,6 +2088,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x22000 0x1000>;
+
+			gpio5: gpio@0 {
+				compatible = "ti,am4372-gpio","ti,omap4-gpio";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		target-module@26000 {			/* 0x48326000, ap 86 66.0 */
@@ -1437,6 +2119,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x26000 0x1000>;
+
+			vpfe0: vpfe@0 {
+				compatible = "ti,am437x-vpfe";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@28000 {			/* 0x48328000, ap 75 0e.0 */
@@ -1457,6 +2146,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x28000 0x1000>;
+
+			vpfe1: vpfe@0 {
+				compatible = "ti,am437x-vpfe";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@2a000 {			/* 0x4832a000, ap 88 3c.0 */
@@ -1499,6 +2195,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3d000 0x1000>;
+
+			timer9: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@3f000 {			/* 0x4833f000, ap 104 5c.0 */
@@ -1519,6 +2222,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3f000 0x1000>;
+
+			timer10: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@41000 {			/* 0x48341000, ap 106 76.0 */
@@ -1539,6 +2249,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x41000 0x1000>;
+
+			timer11: timer@0 {
+				compatible = "ti,am4372-timer","ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		target-module@45000 {			/* 0x48345000, ap 108 6a.0 */
@@ -1561,6 +2278,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x45000 0x1000>;
+
+			spi4: spi@0 {
+				compatible = "ti,am4372-mcspi","ti,omap4-mcspi";
+				reg = <0x0 0x400>;
+				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		target-module@47000 {			/* 0x48347000, ap 110 70.0 */
@@ -1578,6 +2304,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x47000 0x1000>;
+
+			hdq: hdq@0 {
+				compatible = "ti,am4372-hdq";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&func_12m_clk>;
+				clock-names = "fck";
+				status = "disabled";
+			};
 		};
 
 		target-module@4c000 {			/* 0x4834c000, ap 114 72.0 */
@@ -1609,14 +2344,65 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x80000 0x20000>;
+
+			dwc3_1: omap_dwc3@0 {
+				compatible = "ti,am437x-dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				utmi-mode = <1>;
+				ranges = <0 0 0x20000>;
+
+				usb1: usb@10000 {
+					compatible = "synopsys,dwc3";
+					reg = <0x10000 0x10000>;
+					interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "peripheral",
+							  "host",
+							  "otg";
+					phys = <&usb2_phy1>;
+					phy-names = "usb2-phy";
+					maximum-speed = "high-speed";
+					dr_mode = "otg";
+					status = "disabled";
+					snps,dis_u3_susphy_quirk;
+					snps,dis_u2_susphy_quirk;
+				};
+			};
 		};
 
 		target-module@a8000 {			/* 0x483a8000, ap 125 6c.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "ocp2scp0";
+			reg = <0xa8000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM4_L4LS_OCP2SCP0_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa8000 0x8000>;
+
+			ocp2scp0: ocp2scp@0 {
+				compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x8000>;
+
+				usb2_phy1: phy@8000 {
+					compatible = "ti,am437x-usb2";
+					reg = <0x0 0x8000>;
+					syscon-phy-power = <&scm_conf 0x620>;
+					clocks = <&usb_phy0_always_on_clk32k>,
+						 <&l3s_clkctrl AM4_L3S_USB_OTG_SS0_CLKCTRL 8>;
+					clock-names = "wkupclk", "refclk";
+					#phy-cells = <0>;
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@c0000 {			/* 0x483c0000, ap 127 7a.0 */
@@ -1640,14 +2426,65 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xc0000 0x20000>;
+
+			dwc3_2: omap_dwc3@0 {
+				compatible = "ti,am437x-dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				utmi-mode = <1>;
+				ranges = <0 0 0x20000>;
+
+				usb2: usb@10000 {
+					compatible = "synopsys,dwc3";
+					reg = <0x10000 0x10000>;
+					interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "peripheral",
+							  "host",
+							  "otg";
+					phys = <&usb2_phy2>;
+					phy-names = "usb2-phy";
+					maximum-speed = "high-speed";
+					dr_mode = "otg";
+					status = "disabled";
+					snps,dis_u3_susphy_quirk;
+					snps,dis_u2_susphy_quirk;
+				};
+			};
 		};
 
 		target-module@e8000 {			/* 0x483e8000, ap 129 78.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "ocp2scp1";
+			reg = <0xe8000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM4_L4LS_OCP2SCP1_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xe8000 0x8000>;
+
+			ocp2scp1: ocp2scp@0 {
+				compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x8000>;
+
+				usb2_phy2: phy@8000 {
+					compatible = "ti,am437x-usb2";
+					reg = <0x0 0x8000>;
+					syscon-phy-power = <&scm_conf 0x628>;
+					clocks = <&usb_phy1_always_on_clk32k>,
+						 <&l3s_clkctrl AM4_L3S_USB_OTG_SS1_CLKCTRL 8>;
+					clock-names = "wkupclk", "refclk";
+					#phy-cells = <0>;
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@f2000 {			/* 0x483f2000, ap 112 5a.0 */
-- 
2.19.0
