From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: dts: am335x: Move l4 child devices to probe them
 with ti-sysc
Date: Mon, 24 Sep 2018 17:05:45 -0700
Message-ID: <20180925000545.22931-5-tony@atomide.com>
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
 arch/arm/boot/dts/am335x-shc.dts |   2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi | 613 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi    | 623 +------------------------------
 3 files changed, 614 insertions(+), 624 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -205,7 +205,7 @@
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
 	slaves = <1>;
-	cpsw_emac0: slave@4a100200  {
+	cpsw_emac0: slave@200 {
 		phy-mode = "mii";
 		phy-handle = <&ethernetphy0>;
 	};
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -31,11 +31,13 @@
 			 <0x00082000 0x00182000 0x001000>;	/* ap 7 */
 
 		target-module@0 {			/* 0x44d00000, ap 4 28.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x0 0x4>;
+			reg-names = "rev";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x4000>;
+			status = "disabled";
 		};
 
 		target-module@80000 {			/* 0x44d80000, ap 6 10.0 */
@@ -85,11 +87,28 @@
 			 <0x00080000 0x00280000 0x001000>;	/* ap 39 */
 
 		target-module@0 {			/* 0x44e00000, ap 8 58.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0 0x4>;
+			reg-names = "rev";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x2000>;
+
+			prcm: prcm@0 {
+				compatible = "ti,am3-prcm", "simple-bus";
+				reg = <0 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 0x2000>;
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
 
 		target-module@3000 {			/* 0x44e03000, ap 10 0a.0 */
@@ -130,6 +149,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x7000 0x1000>;
+
+			gpio0: gpio@0 {
+				compatible = "ti,omap4-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x1000>;
+				interrupts = <96>;
+			};
 		};
 
 		target-module@9000 {			/* 0x44e09000, ap 16 04.0 */
@@ -152,6 +181,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9000 0x1000>;
+
+			uart0: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <72>;
+				status = "disabled";
+				dmas = <&edma 26 0>, <&edma 27 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@b000 {			/* 0x44e0b000, ap 18 48.0 */
@@ -176,6 +215,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xb000 0x1000>;
+
+			i2c0: i2c@0 {
+				compatible = "ti,omap4-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x1000>;
+				interrupts = <70>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d000 {			/* 0x44e0d000, ap 20 38.0 */
@@ -195,15 +243,90 @@
 			#size-cells = <1>;
 			ranges = <0x00000000 0x0000d000 0x00001000>,
 				 <0x00001000 0x0000e000 0x00001000>;
+
+				tscadc: tscadc@0 {
+					compatible = "ti,am3359-tscadc";
+					reg = <0x0 0x1000>;
+					interrupts = <16>;
+					status = "disabled";
+					dmas = <&edma 53 0>, <&edma 57 0>;
+					dma-names = "fifo0", "fifo1";
+
+					tsc {
+						compatible = "ti,am3359-tsc";
+					};
+					am335x_adc: adc {
+						#io-channel-cells = <1>;
+						compatible = "ti,am3359-adc";
+					};
+				};
 		};
 
 		target-module@10000 {			/* 0x44e10000, ap 22 0c.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x10000 0x4>;
+			reg-names = "rev";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x00000000 0x00010000 0x00010000>,
 				 <0x00010000 0x00020000 0x00010000>;
+
+			scm: scm@0 {
+				compatible = "ti,am3-scm", "simple-bus";
+				reg = <0x0 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#pinctrl-cells = <1>;
+				ranges = <0 0 0x2000>;
+
+				phy_sel: cpsw-phy-sel@650 {
+					compatible = "ti,am3352-cpsw-phy-sel";
+					reg= <0x650 0x4>;
+					reg-names = "gmii-sel";
+				};
+
+				am33xx_pinmux: pinmux@800 {
+					compatible = "pinctrl-single";
+					reg = <0x800 0x238>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#pinctrl-cells = <1>;
+					pinctrl-single,register-width = <32>;
+					pinctrl-single,function-mask = <0x7f>;
+				};
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon", "simple-bus";
+					reg = <0x0 0x800>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0 0x800>;
+
+					scm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+
+				wkup_m3_ipc: wkup_m3_ipc@1324 {
+					compatible = "ti,am3352-wkup-m3-ipc";
+					reg = <0x1324 0x24>;
+					interrupts = <78>;
+					ti,rproc = <&wkup_m3>;
+					mboxes = <&mailbox &mbox_wkupm3>;
+				};
+
+				edma_xbar: dma-router@f90 {
+					compatible = "ti,am335x-edma-crossbar";
+					reg = <0xf90 0x40>;
+					#dma-cells = <3>;
+					dma-requests = <32>;
+					dma-masters = <&edma>;
+				};
+
+				scm_clockdomains: clockdomains {
+				};
+			};
 		};
 
 		target-module@31000 {			/* 0x44e31000, ap 25 40.0 */
@@ -226,6 +349,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x31000 0x1000>;
+
+			timer1: timer@0 {
+				compatible = "ti,am335x-timer-1ms";
+				reg = <0x0 0x400>;
+				interrupts = <67>;
+				ti,timer-alwon;
+				clocks = <&timer1_fck>;
+				clock-names = "fck";
+			};
 		};
 
 		target-module@33000 {			/* 0x44e33000, ap 27 18.0 */
@@ -256,6 +388,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x35000 0x1000>;
+
+			wdt2: wdt@0 {
+				compatible = "ti,omap3-wdt";
+				reg = <0x0 0x1000>;
+				interrupts = <91>;
+			};
 		};
 
 		target-module@37000 {			/* 0x44e37000, ap 31 08.0 */
@@ -290,6 +428,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3e000 0x1000>;
+
+			rtc: rtc@0 {
+				compatible = "ti,am3352-rtc", "ti,da830-rtc";
+				reg = <0x0 0x1000>;
+				interrupts = <75
+					      76>;
+			};
 		};
 
 		target-module@40000 {			/* 0x44e40000, ap 38 68.0 */
@@ -529,11 +674,72 @@
 			 <0x00380000 0x00380000 0x001000>;	/* ap 10 */
 
 		target-module@100000 {			/* 0x4a100000, ap 3 08.0 */
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
+			clocks = <&cpsw_125mhz_clkctrl AM3_CPSW_125MHZ_CPGMAC0_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x100000 0x8000>;
+
+			mac: ethernet@0 {
+				compatible = "ti,am335x-cpsw","ti,cpsw";
+				clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
+				clock-names = "fck", "cpts";
+				cpdma_channels = <8>;
+				ale_entries = <1024>;
+				bd_ram_size = <0x2000>;
+				mac_control = <0x20>;
+				slaves = <2>;
+				active_slave = <0>;
+				cpts_clock_mult = <0x80000000>;
+				cpts_clock_shift = <29>;
+				reg = <0x0 0x800
+				       0x1200 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				/*
+				 * c0_rx_thresh_pend
+				 * c0_rx_pend
+				 * c0_tx_pend
+				 * c0_misc_pend
+				 */
+				interrupts = <40 41 42 43>;
+				ranges = <0 0 0x8000>;
+				syscon = <&scm_conf>;
+				cpsw-phy-sel = <&phy_sel>;
+				status = "disabled";
+
+				davinci_mdio: mdio@1000 {
+					compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					ti,hwmods = "davinci_mdio";
+					bus_freq = <1000000>;
+					reg = <0x1000 0x100>;
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
 
 		target-module@180000 {			/* 0x4a180000, ap 5 10.0 */
@@ -721,6 +927,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x22000 0x1000>;
+
+			uart1: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <73>;
+				status = "disabled";
+				dmas = <&edma 28 0>, <&edma 29 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@24000 {			/* 0x48024000, ap 12 14.0 */
@@ -743,6 +959,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x24000 0x1000>;
+
+			uart2: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <74>;
+				status = "disabled";
+				dmas = <&edma 30 0>, <&edma 31 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@2a000 {			/* 0x4802a000, ap 14 2a.0 */
@@ -767,6 +993,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x2a000 0x1000>;
+
+			i2c1: i2c@0 {
+				compatible = "ti,omap4-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x1000>;
+				interrupts = <71>;
+				status = "disabled";
+			};
 		};
 
 		target-module@30000 {			/* 0x48030000, ap 77 08.0 */
@@ -789,6 +1024,21 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x30000 0x1000>;
+
+			spi0: spi@0 {
+				compatible = "ti,omap4-mcspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x400>;
+				interrupts = <65>;
+				ti,spi-num-cs = <2>;
+				dmas = <&edma 16 0
+					&edma 17 0
+					&edma 18 0
+					&edma 19 0>;
+				dma-names = "tx0", "rx0", "tx1", "rx1";
+				status = "disabled";
+			};
 		};
 
 		target-module@38000 {			/* 0x48038000, ap 16 02.0 */
@@ -806,6 +1056,19 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x38000 0x2000>;
+
+			mcasp0: mcasp@0 {
+				compatible = "ti,am33xx-mcasp-audio";
+				reg = <0x0 0x2000>,
+				      <0x46000000 0x400000>;
+				reg-names = "mpu", "dat";
+				interrupts = <80>, <81>;
+				interrupt-names = "tx", "rx";
+				status = "disabled";
+				dmas = <&edma 8 2>,
+					<&edma 9 2>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@3c000 {			/* 0x4803c000, ap 20 32.0 */
@@ -823,6 +1086,19 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3c000 0x2000>;
+
+			mcasp1: mcasp@0 {
+				compatible = "ti,am33xx-mcasp-audio";
+				reg = <0x0 0x2000>,
+				      <0x46400000 0x400000>;
+				reg-names = "mpu", "dat";
+				interrupts = <82>, <83>;
+				interrupt-names = "tx", "rx";
+				status = "disabled";
+				dmas = <&edma 10 2>,
+					<&edma 11 2>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		target-module@40000 {			/* 0x48040000, ap 22 1e.0 */
@@ -843,6 +1119,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x40000 0x1000>;
+
+			timer2: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <68>;
+				clocks = <&timer2_fck>;
+				clock-names = "fck";
+			};
 		};
 
 		target-module@42000 {			/* 0x48042000, ap 24 1c.0 */
@@ -863,6 +1147,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x42000 0x1000>;
+
+			timer3: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <69>;
+			};
 		};
 
 		target-module@44000 {			/* 0x48044000, ap 26 26.0 */
@@ -883,6 +1173,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x44000 0x1000>;
+
+			timer4: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <92>;
+				ti,timer-pwm;
+			};
 		};
 
 		target-module@46000 {			/* 0x48046000, ap 28 28.0 */
@@ -903,6 +1200,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x46000 0x1000>;
+
+			timer5: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <93>;
+				ti,timer-pwm;
+			};
 		};
 
 		target-module@48000 {			/* 0x48048000, ap 30 22.0 */
@@ -923,6 +1227,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x48000 0x1000>;
+
+			timer6: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <94>;
+				ti,timer-pwm;
+			};
 		};
 
 		target-module@4a000 {			/* 0x4804a000, ap 85 60.0 */
@@ -943,6 +1254,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4a000 0x1000>;
+
+			timer7: timer@0 {
+				compatible = "ti,am335x-timer";
+				reg = <0x0 0x400>;
+				interrupts = <95>;
+				ti,timer-pwm;
+			};
 		};
 
 		target-module@4c000 {			/* 0x4804c000, ap 32 36.0 */
@@ -967,6 +1285,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4c000 0x1000>;
+
+			gpio1: gpio@0 {
+				compatible = "ti,omap4-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x1000>;
+				interrupts = <98>;
+			};
 		};
 
 		target-module@50000 {			/* 0x48050000, ap 34 2c.0 */
@@ -998,6 +1326,19 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x60000 0x1000>;
+
+			mmc1: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				ti,dual-volt;
+				ti,needs-special-reset;
+				ti,needs-special-hs-handling;
+				dmas = <&edma_xbar 24 0 0
+					&edma_xbar 25 0 0>;
+				dma-names = "tx", "rx";
+				interrupts = <64>;
+				reg = <0x0 0x1000>;
+				status = "disabled";
+			};
 		};
 
 		target-module@80000 {			/* 0x48080000, ap 38 18.0 */
@@ -1020,6 +1361,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x80000 0x10000>;
+
+			elm: elm@0 {
+				compatible = "ti,am3352-elm";
+				reg = <0x0 0x2000>;
+				interrupts = <4>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a0000 {			/* 0x480a0000, ap 40 5e.0 */
@@ -1046,6 +1394,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xc8000 0x1000>;
+
+			mailbox: mailbox@0 {
+				compatible = "ti,omap4-mailbox";
+				reg = <0x0 0x200>;
+				interrupts = <77>;
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
 
 		target-module@ca000 {			/* 0x480ca000, ap 91 40.0 */
@@ -1069,6 +1431,12 @@
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
 
 		target-module@cc000 {			/* 0x480cc000, ap 89 0e.0 */
@@ -1153,6 +1521,15 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9c000 0x1000>;
+
+			i2c2: i2c@0 {
+				compatible = "ti,omap4-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x1000>;
+				interrupts = <30>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a0000 {			/* 0x481a0000, ap 79 24.0 */
@@ -1175,6 +1552,21 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa0000 0x1000>;
+
+			spi1: spi@0 {
+				compatible = "ti,omap4-mcspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x400>;
+				interrupts = <125>;
+				ti,spi-num-cs = <2>;
+				dmas = <&edma 42 0
+					&edma 43 0
+					&edma 44 0
+					&edma 45 0>;
+				dma-names = "tx0", "rx0", "tx1", "rx1";
+				status = "disabled";
+			};
 		};
 
 		target-module@a2000 {			/* 0x481a2000, ap 81 2e.0 */
@@ -1213,6 +1605,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa6000 0x1000>;
+
+			uart3: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <44>;
+				status = "disabled";
+			};
 		};
 
 		target-module@a8000 {			/* 0x481a8000, ap 50 20.0 */
@@ -1235,6 +1635,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xa8000 0x1000>;
+
+			uart4: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <45>;
+				status = "disabled";
+			};
 		};
 
 		target-module@aa000 {			/* 0x481aa000, ap 52 1a.0 */
@@ -1257,6 +1665,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xaa000 0x1000>;
+
+			uart5: serial@0 {
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
+				clock-frequency = <48000000>;
+				reg = <0x0 0x2000>;
+				interrupts = <46>;
+				status = "disabled";
+			};
 		};
 
 		target-module@ac000 {			/* 0x481ac000, ap 54 38.0 */
@@ -1281,6 +1697,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xac000 0x1000>;
+
+			gpio2: gpio@0 {
+				compatible = "ti,omap4-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x1000>;
+				interrupts = <32>;
+			};
 		};
 
 		target-module@ae000 {			/* 0x481ae000, ap 56 3a.0 */
@@ -1305,6 +1731,16 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xae000 0x1000>;
+
+			gpio3: gpio@0 {
+				compatible = "ti,omap4-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x1000>;
+				interrupts = <62>;
+			};
 		};
 
 		target-module@b0000 {			/* 0x481b0000, ap 58 50.0 */
@@ -1316,19 +1752,49 @@
 		};
 
 		target-module@cc000 {			/* 0x481cc000, ap 60 46.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "d_can0";
+			reg = <0xcc000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM3_D_CAN0_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xcc000 0x2000>;
+
+			dcan0: can@0 {
+				compatible = "ti,am3352-d_can";
+				reg = <0x0 0x2000>;
+				clocks = <&dcan0_fck>;
+				clock-names = "fck";
+				syscon-raminit = <&scm_conf 0x644 0>;
+				interrupts = <52>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d0000 {			/* 0x481d0000, ap 62 42.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "d_can1";
+			reg = <0xd0000 0x4>;
+			reg-names = "rev";
+			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
+			clocks = <&l4ls_clkctrl AM3_D_CAN1_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd0000 0x2000>;
+
+			dcan1: can@0 {
+				compatible = "ti,am3352-d_can";
+				reg = <0x0 0x2000>;
+				clocks = <&dcan1_fck>;
+				clock-names = "fck";
+				syscon-raminit = <&scm_conf 0x644 1>;
+				interrupts = <55>;
+				status = "disabled";
+			};
 		};
 
 		target-module@d8000 {			/* 0x481d8000, ap 64 66.0 */
@@ -1352,6 +1818,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xd8000 0x1000>;
+
+			mmc2: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				ti,needs-special-reset;
+				dmas = <&edma 2 0
+					&edma 3 0>;
+				dma-names = "tx", "rx";
+				interrupts = <28>;
+				reg = <0x0 0x1000>;
+				status = "disabled";
+			};
 		};
 	};
 
@@ -1409,6 +1886,39 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x0 0x1000>;
+
+			epwmss0: epwmss@0 {
+				compatible = "ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				status = "disabled";
+				ranges = <0x48300100 0x48300100 0x80   /* ECAP */
+					  0x48300180 0x48300180 0x80   /* EQEP */
+					  0x48300200 0x48300200 0x80>; /* EHRPWM */
+
+				ecap0: ecap@48300100 {
+					compatible = "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x48300100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					interrupts = <31>;
+					interrupt-names = "ecap0";
+					status = "disabled";
+				};
+
+				ehrpwm0: pwm@48300200 {
+					compatible = "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x48300200 0x80>;
+					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@2000 {			/* 0x48302000, ap 68 52.0 */
@@ -1431,6 +1941,39 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x2000 0x1000>;
+
+			epwmss1: epwmss@0 {
+				compatible = "ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				status = "disabled";
+				ranges = <0x48302100 0x48302100 0x80   /* ECAP */
+					  0x48302180 0x48302180 0x80   /* EQEP */
+					  0x48302200 0x48302200 0x80>; /* EHRPWM */
+
+				ecap1: ecap@48302100 {
+					compatible = "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x48302100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					interrupts = <47>;
+					interrupt-names = "ecap1";
+					status = "disabled";
+				};
+
+				ehrpwm1: pwm@48302200 {
+					compatible = "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x48302200 0x80>;
+					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@4000 {			/* 0x48304000, ap 70 44.0 */
@@ -1453,6 +1996,39 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4000 0x1000>;
+
+			epwmss2: epwmss@0 {
+				compatible = "ti,am33xx-pwmss";
+				reg = <0x0 0x10>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				status = "disabled";
+				ranges = <0x48304100 0x48304100 0x80   /* ECAP */
+					  0x48304180 0x48304180 0x80   /* EQEP */
+					  0x48304200 0x48304200 0x80>; /* EHRPWM */
+
+				ecap2: ecap@48304100 {
+					compatible = "ti,am3352-ecap",
+						     "ti,am33xx-ecap";
+					#pwm-cells = <3>;
+					reg = <0x48304100 0x80>;
+					clocks = <&l4ls_gclk>;
+					clock-names = "fck";
+					interrupts = <61>;
+					interrupt-names = "ecap2";
+					status = "disabled";
+				};
+
+				ehrpwm2: pwm@48304200 {
+					compatible = "ti,am3352-ehrpwm",
+						     "ti,am33xx-ehrpwm";
+					#pwm-cells = <3>;
+					reg = <0x48304200 0x80>;
+					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
+					clock-names = "tbclk", "fck";
+					status = "disabled";
+				};
+			};
 		};
 
 		target-module@e000 {			/* 0x4830e000, ap 72 4a.0 */
@@ -1471,6 +2047,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xe000 0x1000>;
+
+			lcdc: lcdc@0 {
+				compatible = "ti,am33xx-tilcdc";
+				reg = <0x0 0x1000>;
+				interrupts = <36>;
+				status = "disabled";
+			};
 		};
 
 		target-module@10000 {			/* 0x48310000, ap 76 4e.1 */
@@ -1488,6 +2071,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x10000 0x2000>;
+
+			rng: rng@0 {
+				compatible = "ti,omap4-rng";
+				reg = <0x0 0x2000>;
+				interrupts = <111>;
+			};
 		};
 
 		target-module@13000 {			/* 0x48313000, ap 97 62.0 */
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/am33xx.h>
 #include <dt-bindings/clock/am3.h>
@@ -166,87 +167,23 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
-		l4_wkup: l4_wkup@44c00000 {
-			compatible = "ti,am3-l4-wkup", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x44c00000 0x280000>;
-
+		l4_wkup: interconnect@44c00000 {
 			wkup_m3: wkup_m3@100000 {
 				compatible = "ti,am3352-wkup-m3";
 				reg = <0x100000 0x4000>,
-				      <0x180000	0x2000>;
+				      <0x180000 0x2000>;
 				reg-names = "umem", "dmem";
 				ti,hwmods = "wkup_m3";
 				ti,pm-firmware = "am335x-pm-firmware.elf";
 			};
-
-			prcm: prcm@200000 {
-				compatible = "ti,am3-prcm", "simple-bus";
-				reg = <0x200000 0x4000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x200000 0x4000>;
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
-				compatible = "ti,am3-scm", "simple-bus";
-				reg = <0x210000 0x2000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				#pinctrl-cells = <1>;
-				ranges = <0 0x210000 0x2000>;
-
-				am33xx_pinmux: pinmux@800 {
-					compatible = "pinctrl-single";
-					reg = <0x800 0x238>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-					#pinctrl-cells = <1>;
-					pinctrl-single,register-width = <32>;
-					pinctrl-single,function-mask = <0x7f>;
-				};
-
-				scm_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
-					reg = <0x0 0x800>;
-					#address-cells = <1>;
-					#size-cells = <1>;
-					ranges = <0 0 0x800>;
-
-					scm_clocks: clocks {
-						#address-cells = <1>;
-						#size-cells = <0>;
-					};
-				};
-
-				wkup_m3_ipc: wkup_m3_ipc@1324 {
-					compatible = "ti,am3352-wkup-m3-ipc";
-					reg = <0x1324 0x24>;
-					interrupts = <78>;
-					ti,rproc = <&wkup_m3>;
-					mboxes = <&mailbox &mbox_wkupm3>;
-				};
-
-				edma_xbar: dma-router@f90 {
-					compatible = "ti,am335x-edma-crossbar";
-					reg = <0xf90 0x40>;
-					#dma-cells = <3>;
-					dma-requests = <32>;
-					dma-masters = <&edma>;
-				};
-
-				scm_clockdomains: clockdomains {
-				};
-			};
+		};
+		l4_per: interconnect@48000000 {
+		};
+		l4_fw: interconnect@47c00000 {
+		};
+		l4_fast: interconnect@4a000000 {
+		};
+		l4_mpuss: interconnect@4b140000 {
 		};
 
 		intc: interrupt-controller@48200000 {
@@ -297,166 +234,6 @@
 			interrupt-names = "edma3_tcerrint";
 		};
 
-		gpio0: gpio@44e07000 {
-			compatible = "ti,omap4-gpio";
-			ti,hwmods = "gpio1";
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x44e07000 0x1000>;
-			interrupts = <96>;
-		};
-
-		gpio1: gpio@4804c000 {
-			compatible = "ti,omap4-gpio";
-			ti,hwmods = "gpio2";
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x4804c000 0x1000>;
-			interrupts = <98>;
-		};
-
-		gpio2: gpio@481ac000 {
-			compatible = "ti,omap4-gpio";
-			ti,hwmods = "gpio3";
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x481ac000 0x1000>;
-			interrupts = <32>;
-		};
-
-		gpio3: gpio@481ae000 {
-			compatible = "ti,omap4-gpio";
-			ti,hwmods = "gpio4";
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x481ae000 0x1000>;
-			interrupts = <62>;
-		};
-
-		uart0: serial@44e09000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart1";
-			clock-frequency = <48000000>;
-			reg = <0x44e09000 0x2000>;
-			interrupts = <72>;
-			status = "disabled";
-			dmas = <&edma 26 0>, <&edma 27 0>;
-			dma-names = "tx", "rx";
-		};
-
-		uart1: serial@48022000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart2";
-			clock-frequency = <48000000>;
-			reg = <0x48022000 0x2000>;
-			interrupts = <73>;
-			status = "disabled";
-			dmas = <&edma 28 0>, <&edma 29 0>;
-			dma-names = "tx", "rx";
-		};
-
-		uart2: serial@48024000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart3";
-			clock-frequency = <48000000>;
-			reg = <0x48024000 0x2000>;
-			interrupts = <74>;
-			status = "disabled";
-			dmas = <&edma 30 0>, <&edma 31 0>;
-			dma-names = "tx", "rx";
-		};
-
-		uart3: serial@481a6000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart4";
-			clock-frequency = <48000000>;
-			reg = <0x481a6000 0x2000>;
-			interrupts = <44>;
-			status = "disabled";
-		};
-
-		uart4: serial@481a8000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart5";
-			clock-frequency = <48000000>;
-			reg = <0x481a8000 0x2000>;
-			interrupts = <45>;
-			status = "disabled";
-		};
-
-		uart5: serial@481aa000 {
-			compatible = "ti,am3352-uart", "ti,omap3-uart";
-			ti,hwmods = "uart6";
-			clock-frequency = <48000000>;
-			reg = <0x481aa000 0x2000>;
-			interrupts = <46>;
-			status = "disabled";
-		};
-
-		i2c0: i2c@44e0b000 {
-			compatible = "ti,omap4-i2c";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c1";
-			reg = <0x44e0b000 0x1000>;
-			interrupts = <70>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@4802a000 {
-			compatible = "ti,omap4-i2c";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c2";
-			reg = <0x4802a000 0x1000>;
-			interrupts = <71>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@4819c000 {
-			compatible = "ti,omap4-i2c";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c3";
-			reg = <0x4819c000 0x1000>;
-			interrupts = <30>;
-			status = "disabled";
-		};
-
-		mmc1: mmc@48060000 {
-			compatible = "ti,omap4-hsmmc";
-			ti,hwmods = "mmc1";
-			ti,dual-volt;
-			ti,needs-special-reset;
-			ti,needs-special-hs-handling;
-			dmas = <&edma_xbar 24 0 0
-				&edma_xbar 25 0 0>;
-			dma-names = "tx", "rx";
-			interrupts = <64>;
-			reg = <0x48060000 0x1000>;
-			status = "disabled";
-		};
-
-		mmc2: mmc@481d8000 {
-			compatible = "ti,omap4-hsmmc";
-			ti,hwmods = "mmc2";
-			ti,needs-special-reset;
-			dmas = <&edma 2 0
-				&edma 3 0>;
-			dma-names = "tx", "rx";
-			interrupts = <28>;
-			reg = <0x481d8000 0x1000>;
-			status = "disabled";
-		};
-
 		mmc3: mmc@47810000 {
 			compatible = "ti,omap4-hsmmc";
 			ti,hwmods = "mmc3";
@@ -466,157 +243,6 @@
 			status = "disabled";
 		};
 
-		hwspinlock: spinlock@480ca000 {
-			compatible = "ti,omap4-hwspinlock";
-			reg = <0x480ca000 0x1000>;
-			ti,hwmods = "spinlock";
-			#hwlock-cells = <1>;
-		};
-
-		wdt2: wdt@44e35000 {
-			compatible = "ti,omap3-wdt";
-			ti,hwmods = "wd_timer2";
-			reg = <0x44e35000 0x1000>;
-			interrupts = <91>;
-		};
-
-		dcan0: can@481cc000 {
-			compatible = "ti,am3352-d_can";
-			ti,hwmods = "d_can0";
-			reg = <0x481cc000 0x2000>;
-			clocks = <&dcan0_fck>;
-			clock-names = "fck";
-			syscon-raminit = <&scm_conf 0x644 0>;
-			interrupts = <52>;
-			status = "disabled";
-		};
-
-		dcan1: can@481d0000 {
-			compatible = "ti,am3352-d_can";
-			ti,hwmods = "d_can1";
-			reg = <0x481d0000 0x2000>;
-			clocks = <&dcan1_fck>;
-			clock-names = "fck";
-			syscon-raminit = <&scm_conf 0x644 1>;
-			interrupts = <55>;
-			status = "disabled";
-		};
-
-		mailbox: mailbox@480c8000 {
-			compatible = "ti,omap4-mailbox";
-			reg = <0x480C8000 0x200>;
-			interrupts = <77>;
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
-			compatible = "ti,am335x-timer-1ms";
-			reg = <0x44e31000 0x400>;
-			interrupts = <67>;
-			ti,hwmods = "timer1";
-			ti,timer-alwon;
-			clocks = <&timer1_fck>;
-			clock-names = "fck";
-		};
-
-		timer2: timer@48040000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x48040000 0x400>;
-			interrupts = <68>;
-			ti,hwmods = "timer2";
-			clocks = <&timer2_fck>;
-			clock-names = "fck";
-		};
-
-		timer3: timer@48042000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x48042000 0x400>;
-			interrupts = <69>;
-			ti,hwmods = "timer3";
-		};
-
-		timer4: timer@48044000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x48044000 0x400>;
-			interrupts = <92>;
-			ti,hwmods = "timer4";
-			ti,timer-pwm;
-		};
-
-		timer5: timer@48046000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x48046000 0x400>;
-			interrupts = <93>;
-			ti,hwmods = "timer5";
-			ti,timer-pwm;
-		};
-
-		timer6: timer@48048000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x48048000 0x400>;
-			interrupts = <94>;
-			ti,hwmods = "timer6";
-			ti,timer-pwm;
-		};
-
-		timer7: timer@4804a000 {
-			compatible = "ti,am335x-timer";
-			reg = <0x4804a000 0x400>;
-			interrupts = <95>;
-			ti,hwmods = "timer7";
-			ti,timer-pwm;
-		};
-
-		rtc: rtc@44e3e000 {
-			compatible = "ti,am3352-rtc", "ti,da830-rtc";
-			reg = <0x44e3e000 0x1000>;
-			interrupts = <75
-				      76>;
-			ti,hwmods = "rtc";
-			clocks = <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
-			clock-names = "int-clk";
-		};
-
-		spi0: spi@48030000 {
-			compatible = "ti,omap4-mcspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x48030000 0x400>;
-			interrupts = <65>;
-			ti,spi-num-cs = <2>;
-			ti,hwmods = "spi0";
-			dmas = <&edma 16 0
-				&edma 17 0
-				&edma 18 0
-				&edma 19 0>;
-			dma-names = "tx0", "rx0", "tx1", "rx1";
-			status = "disabled";
-		};
-
-		spi1: spi@481a0000 {
-			compatible = "ti,omap4-mcspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x481a0000 0x400>;
-			interrupts = <125>;
-			ti,spi-num-cs = <2>;
-			ti,hwmods = "spi1";
-			dmas = <&edma 42 0
-				&edma 43 0
-				&edma 44 0
-				&edma 45 0>;
-			dma-names = "tx0", "rx0", "tx1", "rx1";
-			status = "disabled";
-		};
-
 		usb: usb@47400000 {
 			compatible = "ti,am33xx-usb";
 			reg = <0x47400000 0x1000>;
@@ -747,163 +373,6 @@
 			};
 		};
 
-		epwmss0: epwmss@48300000 {
-			compatible = "ti,am33xx-pwmss";
-			reg = <0x48300000 0x10>;
-			ti,hwmods = "epwmss0";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			status = "disabled";
-			ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-				  0x48300180 0x48300180 0x80   /* EQEP */
-				  0x48300200 0x48300200 0x80>; /* EHRPWM */
-
-			ecap0: ecap@48300100 {
-				compatible = "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48300100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				interrupts = <31>;
-				interrupt-names = "ecap0";
-				status = "disabled";
-			};
-
-			ehrpwm0: pwm@48300200 {
-				compatible = "ti,am3352-ehrpwm",
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
-			compatible = "ti,am33xx-pwmss";
-			reg = <0x48302000 0x10>;
-			ti,hwmods = "epwmss1";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			status = "disabled";
-			ranges = <0x48302100 0x48302100 0x80   /* ECAP */
-				  0x48302180 0x48302180 0x80   /* EQEP */
-				  0x48302200 0x48302200 0x80>; /* EHRPWM */
-
-			ecap1: ecap@48302100 {
-				compatible = "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48302100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				interrupts = <47>;
-				interrupt-names = "ecap1";
-				status = "disabled";
-			};
-
-			ehrpwm1: pwm@48302200 {
-				compatible = "ti,am3352-ehrpwm",
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
-			compatible = "ti,am33xx-pwmss";
-			reg = <0x48304000 0x10>;
-			ti,hwmods = "epwmss2";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			status = "disabled";
-			ranges = <0x48304100 0x48304100 0x80   /* ECAP */
-				  0x48304180 0x48304180 0x80   /* EQEP */
-				  0x48304200 0x48304200 0x80>; /* EHRPWM */
-
-			ecap2: ecap@48304100 {
-				compatible = "ti,am3352-ecap",
-					     "ti,am33xx-ecap";
-				#pwm-cells = <3>;
-				reg = <0x48304100 0x80>;
-				clocks = <&l4ls_gclk>;
-				clock-names = "fck";
-				interrupts = <61>;
-				interrupt-names = "ecap2";
-				status = "disabled";
-			};
-
-			ehrpwm2: pwm@48304200 {
-				compatible = "ti,am3352-ehrpwm",
-					     "ti,am33xx-ehrpwm";
-				#pwm-cells = <3>;
-				reg = <0x48304200 0x80>;
-				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
-				clock-names = "tbclk", "fck";
-				status = "disabled";
-			};
-		};
-
-		mac: ethernet@4a100000 {
-			compatible = "ti,am335x-cpsw","ti,cpsw";
-			ti,hwmods = "cpgmac0";
-			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
-			clock-names = "fck", "cpts";
-			cpdma_channels = <8>;
-			ale_entries = <1024>;
-			bd_ram_size = <0x2000>;
-			mac_control = <0x20>;
-			slaves = <2>;
-			active_slave = <0>;
-			cpts_clock_mult = <0x80000000>;
-			cpts_clock_shift = <29>;
-			reg = <0x4a100000 0x800
-			       0x4a101200 0x100>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			/*
-			 * c0_rx_thresh_pend
-			 * c0_rx_pend
-			 * c0_tx_pend
-			 * c0_misc_pend
-			 */
-			interrupts = <40 41 42 43>;
-			ranges;
-			syscon = <&scm_conf>;
-			status = "disabled";
-
-			davinci_mdio: mdio@4a101000 {
-				compatible = "ti,cpsw-mdio","ti,davinci_mdio";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,hwmods = "davinci_mdio";
-				bus_freq = <1000000>;
-				reg = <0x4a101000 0x100>;
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
-				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x44e10650 0x4>;
-				reg-names = "gmii-sel";
-			};
-		};
-
 		ocmcram: ocmcram@40300000 {
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x10000>; /* 64k */
@@ -924,40 +393,6 @@
 			};
 		};
 
-		elm: elm@48080000 {
-			compatible = "ti,am3352-elm";
-			reg = <0x48080000 0x2000>;
-			interrupts = <4>;
-			ti,hwmods = "elm";
-			status = "disabled";
-		};
-
-		lcdc: lcdc@4830e000 {
-			compatible = "ti,am33xx-tilcdc";
-			reg = <0x4830e000 0x1000>;
-			interrupts = <36>;
-			ti,hwmods = "lcdc";
-			status = "disabled";
-		};
-
-		tscadc: tscadc@44e0d000 {
-			compatible = "ti,am3359-tscadc";
-			reg = <0x44e0d000 0x1000>;
-			interrupts = <16>;
-			ti,hwmods = "adc_tsc";
-			status = "disabled";
-			dmas = <&edma 53 0>, <&edma 57 0>;
-			dma-names = "fifo0", "fifo1";
-
-			tsc {
-				compatible = "ti,am3359-tsc";
-			};
-			am335x_adc: adc {
-				#io-channel-cells = <1>;
-				compatible = "ti,am3359-adc";
-			};
-		};
-
 		emif: emif@4c000000 {
 			compatible = "ti,emif-am3352";
 			reg = <0x4c000000 0x1000000>;
@@ -1005,42 +440,8 @@
 			       <&edma 5 0>;
 			dma-names = "tx", "rx";
 		};
-
-		mcasp0: mcasp@48038000 {
-			compatible = "ti,am33xx-mcasp-audio";
-			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>,
-			      <0x46000000 0x400000>;
-			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
-			interrupt-names = "tx", "rx";
-			status = "disabled";
-			dmas = <&edma 8 2>,
-				<&edma 9 2>;
-			dma-names = "tx", "rx";
-		};
-
-		mcasp1: mcasp@4803c000 {
-			compatible = "ti,am33xx-mcasp-audio";
-			ti,hwmods = "mcasp1";
-			reg = <0x4803C000 0x2000>,
-			      <0x46400000 0x400000>;
-			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
-			interrupt-names = "tx", "rx";
-			status = "disabled";
-			dmas = <&edma 10 2>,
-				<&edma 11 2>;
-			dma-names = "tx", "rx";
-		};
-
-		rng: rng@48310000 {
-			compatible = "ti,omap4-rng";
-			ti,hwmods = "rng";
-			reg = <0x48310000 0x2000>;
-			interrupts = <111>;
-		};
 	};
 };
 
+#include "am33xx-l4.dtsi"
 #include "am33xx-clocks.dtsi"
-- 
2.19.0
