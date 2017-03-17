From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 9/9] ARM: dts: omap4: convert to use the new clkctrl clocks
 for the drivers
Date: Fri, 17 Mar 2017 11:09:41 +0200
Message-ID: <1489741781-12816-10-git-send-email-t-kristo@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert the drivers to use the new clkctrl clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 164 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3ecf616..c39304a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -94,16 +94,22 @@
 			compatible = "ti,omap4-mpu";
 			ti,hwmods = "mpu";
 			sram = <&ocmcram>;
+			clocks = <&mpuss_clkctrl OMAP4_MPU_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		dsp {
 			compatible = "ti,omap3-c64";
 			ti,hwmods = "dsp";
+			clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		iva {
 			compatible = "ti,ivahd";
 			ti,hwmods = "iva";
+			clocks = <&ivahd_clkctrl OMAP4_IVA_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 	};
 
@@ -125,6 +131,10 @@
 		      <0x45000000 0x1000>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&l3_1_clkctrl OMAP4_L3_MAIN_1_CLKCTRL 0>,
+			 <&l3_2_clkctrl OMAP4_L3_MAIN_2_CLKCTRL 0>,
+			 <&l3_instr_clkctrl OMAP4_L3_MAIN_3_CLKCTRL 0>;
+		clock-names = "clkctrl-0", "clkctrl-1", "clkctrl-2";
 
 		l4_cfg: l4@4a000000 {
 			compatible = "ti,omap4-l4-cfg", "simple-bus";
@@ -230,6 +240,8 @@
 					compatible = "ti,omap-counter32k";
 					reg = <0x4000 0x20>;
 					ti,hwmods = "counter_32k";
+					clocks = <&l4_wkup_clkctrl OMAP4_COUNTER_32K_CLKCTRL 0>;
+					clock-names = "clkctrl";
 				};
 
 				prm: prm@6000 {
@@ -304,6 +316,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_wkup_clkctrl OMAP4_GPIO1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio2: gpio@48055000 {
@@ -315,6 +329,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_per_clkctrl OMAP4_GPIO2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio3: gpio@48057000 {
@@ -326,6 +342,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_per_clkctrl OMAP4_GPIO3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio4: gpio@48059000 {
@@ -337,6 +355,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_per_clkctrl OMAP4_GPIO4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio5: gpio@4805b000 {
@@ -348,6 +368,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_per_clkctrl OMAP4_GPIO5_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio6: gpio@4805d000 {
@@ -359,6 +381,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_per_clkctrl OMAP4_GPIO6_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		elm: elm@48078000 {
@@ -367,6 +391,8 @@
 			interrupts = <4>;
 			ti,hwmods = "elm";
 			status = "disabled";
+			clocks = <&l4_per_clkctrl OMAP4_ELM_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpmc: gpmc@50000000 {
@@ -381,8 +407,9 @@
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
 			ti,no-idle-on-init;
-			clocks = <&l3_div_ck>;
-			clock-names = "fck";
+			clocks = <&l3_div_ck>,
+				 <&l3_2_clkctrl OMAP4_GPMC_CLKCTRL 0>;
+			clock-names = "fck", "clkctrl";
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-controller;
@@ -395,6 +422,8 @@
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+			clocks = <&l4_per_clkctrl OMAP4_UART1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart2: serial@4806c000 {
@@ -403,6 +432,8 @@
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+			clocks = <&l4_per_clkctrl OMAP4_UART2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart3: serial@48020000 {
@@ -411,6 +442,8 @@
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+			clocks = <&l4_per_clkctrl OMAP4_UART3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart4: serial@4806e000 {
@@ -419,6 +452,8 @@
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+			clocks = <&l4_per_clkctrl OMAP4_UART4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		hwspinlock: spinlock@4a0f6000 {
@@ -426,6 +461,8 @@
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
 			#hwlock-cells = <1>;
+			clocks = <&l4_cfg_clkctrl OMAP4_SPINLOCK_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c1: i2c@48070000 {
@@ -435,6 +472,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&l4_per_clkctrl OMAP4_I2C1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c2: i2c@48072000 {
@@ -444,6 +483,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&l4_per_clkctrl OMAP4_I2C2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c3: i2c@48060000 {
@@ -453,6 +494,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&l4_per_clkctrl OMAP4_I2C3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c4: i2c@48350000 {
@@ -462,6 +505,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&l4_per_clkctrl OMAP4_I2C4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcspi1: spi@48098000 {
@@ -482,6 +527,8 @@
 			       <&sdma 42>;
 			dma-names = "tx0", "rx0", "tx1", "rx1",
 				    "tx2", "rx2", "tx3", "rx3";
+			clocks = <&l4_per_clkctrl OMAP4_MCSPI1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -497,6 +544,8 @@
 			       <&sdma 45>,
 			       <&sdma 46>;
 			dma-names = "tx0", "rx0", "tx1", "rx1";
+			clocks = <&l4_per_clkctrl OMAP4_MCSPI2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -509,6 +558,8 @@
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
+			clocks = <&l4_per_clkctrl OMAP4_MCSPI3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -521,6 +572,8 @@
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
+			clocks = <&l4_per_clkctrl OMAP4_MCSPI4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc1: mmc@4809c000 {
@@ -533,6 +586,8 @@
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			pbias-supply = <&pbias_mmc_reg>;
+			clocks = <&l3_init_clkctrl OMAP4_MMC1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc2: mmc@480b4000 {
@@ -543,6 +598,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
+			clocks = <&l3_init_clkctrl OMAP4_MMC2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc3: mmc@480ad000 {
@@ -553,6 +610,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
+			clocks = <&l4_per_clkctrl OMAP4_MMC3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -563,6 +622,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
+			clocks = <&l4_per_clkctrl OMAP4_MMC4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -573,6 +634,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
+			clocks = <&l4_per_clkctrl OMAP4_MMC5_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmu_dsp: mmu@4a066000 {
@@ -581,6 +644,8 @@
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_dsp";
 			#iommu-cells = <0>;
+			clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmu_ipu: mmu@55082000 {
@@ -590,6 +655,8 @@
 			ti,hwmods = "mmu_ipu";
 			#iommu-cells = <0>;
 			ti,iommu-bus-err-back;
+			clocks = <&ducati_clkctrl OMAP4_IPU_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		wdt2: wdt@4a314000 {
@@ -597,6 +664,8 @@
 			reg = <0x4a314000 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
+			clocks = <&l4_wkup_clkctrl OMAP4_WD_TIMER2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcpdm: mcpdm@40132000 {
@@ -610,6 +679,8 @@
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
 			status = "disabled";
+			clocks = <&abe_clkctrl OMAP4_MCPDM_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		dmic: dmic@4012e000 {
@@ -622,6 +693,8 @@
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
 			status = "disabled";
+			clocks = <&abe_clkctrl OMAP4_DMIC_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcbsp1: mcbsp@40122000 {
@@ -637,6 +710,8 @@
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			clocks = <&abe_clkctrl OMAP4_MCBSP1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -652,6 +727,8 @@
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			clocks = <&abe_clkctrl OMAP4_MCBSP2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -667,6 +744,8 @@
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			clocks = <&abe_clkctrl OMAP4_MCBSP3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcbsp4: mcbsp@48096000 {
@@ -681,6 +760,8 @@
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			clocks = <&l4_per_clkctrl OMAP4_MCBSP4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		keypad: keypad@4a31c000 {
@@ -689,6 +770,8 @@
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			reg-names = "mpu";
 			ti,hwmods = "kbd";
+			clocks = <&l4_wkup_clkctrl OMAP4_KBD_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		dmm@4e000000 {
@@ -696,6 +779,8 @@
 			reg = <0x4e000000 0x800>;
 			interrupts = <0 113 0x4>;
 			ti,hwmods = "dmm";
+			clocks = <&l3_emif_clkctrl OMAP4_DMM_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		emif1: emif@4c000000 {
@@ -708,6 +793,8 @@
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
+			clocks = <&l3_emif_clkctrl OMAP4_EMIF1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		emif2: emif@4d000000 {
@@ -720,6 +807,8 @@
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
+			clocks = <&l3_emif_clkctrl OMAP4_EMIF2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		ocp2scp@4a0ad000 {
@@ -729,6 +818,8 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
+			clocks = <&l3_init_clkctrl OMAP4_OCP2SCP_USB_PHY_CLKCTRL 0>;
+			clock-names = "clkctrl";
 			usb2_phy: usb2phy@4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
@@ -747,6 +838,8 @@
 			#mbox-cells = <1>;
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
+			clocks = <&l4_cfg_clkctrl OMAP4_MAILBOX_CLKCTRL 0>;
+			clock-names = "clkctrl";
 			mbox_ipu: mbox_ipu {
 				ti,mbox-tx = <0 0 0>;
 				ti,mbox-rx = <1 0 0>;
@@ -763,6 +856,8 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			clocks = <&dmt1_clk_mux>, <&l4_wkup_clkctrl OMAP4_TIMER1_CLKCTRL 0>;
+			clock-names = "fck", "clkctrl";
 		};
 
 		timer2: timer@48032000 {
@@ -770,6 +865,8 @@
 			reg = <0x48032000 0x80>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
+			clocks = <&l4_per_clkctrl OMAP4_TIMER2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer3: timer@48034000 {
@@ -777,6 +874,8 @@
 			reg = <0x48034000 0x80>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&l4_per_clkctrl OMAP4_TIMER3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer4: timer@48036000 {
@@ -784,6 +883,8 @@
 			reg = <0x48036000 0x80>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
+			clocks = <&l4_per_clkctrl OMAP4_TIMER4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer5: timer@40138000 {
@@ -793,6 +894,8 @@
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
+			clocks = <&abe_clkctrl OMAP4_TIMER5_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer6: timer@4013a000 {
@@ -802,6 +905,8 @@
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
+			clocks = <&abe_clkctrl OMAP4_TIMER6_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer7: timer@4013c000 {
@@ -811,6 +916,8 @@
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
+			clocks = <&abe_clkctrl OMAP4_TIMER7_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer8: timer@4013e000 {
@@ -821,6 +928,8 @@
 			ti,hwmods = "timer8";
 			ti,timer-pwm;
 			ti,timer-dsp;
+			clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer9: timer@4803e000 {
@@ -829,6 +938,8 @@
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
 			ti,timer-pwm;
+			clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer10: timer@48086000 {
@@ -837,6 +948,8 @@
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
 			ti,timer-pwm;
+			clocks = <&l4_per_clkctrl OMAP4_TIMER10_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		timer11: timer@48088000 {
@@ -845,6 +958,8 @@
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
+			clocks = <&l4_per_clkctrl OMAP4_TIMER11_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		usbhstll: usbhstll@4a062000 {
@@ -852,6 +967,8 @@
 			reg = <0x4a062000 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "usb_tll_hs";
+			clocks = <&l3_init_clkctrl OMAP4_USB_TLL_HS_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		usbhshost: usbhshost@4a064000 {
@@ -863,10 +980,12 @@
 			ranges;
 			clocks = <&init_60m_fclk>,
 				 <&xclk60mhsp1_ck>,
-				 <&xclk60mhsp2_ck>;
+				 <&xclk60mhsp2_ck>,
+				 <&l3_init_clkctrl OMAP4_USB_HOST_HS_CLKCTRL 0>;
 			clock-names = "refclk_60m_int",
 				      "refclk_60m_ext_p1",
-				      "refclk_60m_ext_p2";
+				      "refclk_60m_ext_p2",
+				      "clkctrl";
 
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3";
@@ -908,6 +1027,8 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 			ctrl-module = <&omap_control_usbotg>;
+			clocks = <&l3_init_clkctrl OMAP4_USB_OTG_HS_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		aes: aes@4b501000 {
@@ -959,8 +1080,9 @@
 			reg = <0x58000000 0x80>;
 			status = "disabled";
 			ti,hwmods = "dss_core";
-			clocks = <&dss_dss_clk>;
-			clock-names = "fck";
+			clocks = <&dss_dss_clk>,
+				 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+			clock-names = "fck", "clkctrl";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -970,8 +1092,9 @@
 				reg = <0x58001000 0x1000>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				ti,hwmods = "dss_dispc";
-				clocks = <&dss_dss_clk>;
-				clock-names = "fck";
+				clocks = <&dss_dss_clk>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "clkctrl";
 			};
 
 			rfbi: encoder@58002000  {
@@ -979,8 +1102,9 @@
 				reg = <0x58002000 0x1000>;
 				status = "disabled";
 				ti,hwmods = "dss_rfbi";
-				clocks = <&dss_dss_clk>, <&l3_div_ck>;
-				clock-names = "fck", "ick";
+				clocks = <&dss_dss_clk>, <&l3_div_ck>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "ick", "clkctrl";
 			};
 
 			venc: encoder@58003000 {
@@ -988,8 +1112,9 @@
 				reg = <0x58003000 0x1000>;
 				status = "disabled";
 				ti,hwmods = "dss_venc";
-				clocks = <&dss_tv_clk>;
-				clock-names = "fck";
+				clocks = <&dss_tv_clk>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "clkctrl";
 			};
 
 			dsi1: encoder@58004000 {
@@ -1001,8 +1126,9 @@
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi1";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
-				clock-names = "fck", "sys_clk";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "sys_clk", "clkctrl";
 			};
 
 			dsi2: encoder@58005000 {
@@ -1014,8 +1140,9 @@
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi2";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
-				clock-names = "fck", "sys_clk";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "sys_clk", "clkctrl";
 			};
 
 			hdmi: encoder@58006000 {
@@ -1028,8 +1155,9 @@
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_hdmi";
-				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
-				clock-names = "fck", "sys_clk";
+				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 0>;
+				clock-names = "fck", "sys_clk", "clkctrl";
 				dmas = <&sdma 76>;
 				dma-names = "audio_tx";
 			};
-- 
1.9.1
