From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: OMAP4: dts: Add main and optional clock data into DT
Date: Sat, 14 Dec 2013 19:40:29 -0800
Message-ID: <20131215034029.23538.70910@quantum>
References: <1386848309-14076-1-git-send-email-rnayak@ti.com>
 <1386848309-14076-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:48974 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab3LODke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Dec 2013 22:40:34 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2733345yhz.22
        for <linux-omap@vger.kernel.org>; Sat, 14 Dec 2013 19:40:34 -0800 (PST)
In-Reply-To: <1386848309-14076-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, nm@ti.com
Cc: mark.rutland@arm.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Quoting Rajendra Nayak (2013-12-12 03:38:29)
> With support to parse clock data from DT, move all main and optional
> clock information from hwmod to DT.
> 
> We still retain clocks in hwmod for devices which do not have a DT node.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  122 ----------------------------
>  2 files changed, 100 insertions(+), 122 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index c2e3993..7eb7920 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -139,6 +139,8 @@
>                         compatible = "ti,omap-counter32k";
>                         reg = <0x4a304000 0x20>;
>                         ti,hwmods = "counter_32k";
> +                       clocks = <&sys_32k_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 omap4_pmx_core: pinmux@4a100040 {
> @@ -172,6 +174,8 @@
>                         #dma-cells = <1>;
>                         #dma-channels = <32>;
>                         #dma-requests = <127>;
> +                       clocks = <&l3_div_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 gpio1: gpio@4a310000 {
> @@ -184,6 +188,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_wkup_clk_mux_ck>, <&gpio1_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpio2: gpio@48055000 {
> @@ -195,6 +201,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_div_ck>, <&gpio2_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpio3: gpio@48057000 {
> @@ -206,6 +214,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_div_ck>, <&gpio3_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpio4: gpio@48059000 {
> @@ -217,6 +227,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_div_ck>, <&gpio4_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpio5: gpio@4805b000 {
> @@ -228,6 +240,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_div_ck>, <&gpio5_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpio6: gpio@4805d000 {
> @@ -239,6 +253,8 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       clocks = <&l4_div_ck>, <&gpio6_dbclk>;
> +                       clock-names = "fck", "dbclk";
>                 };
>  
>                 gpmc: gpmc@50000000 {
> @@ -259,6 +275,8 @@
>                         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "uart1";
>                         clock-frequency = <48000000>;
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 uart2: serial@4806c000 {
> @@ -267,6 +285,8 @@
>                         interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "uart2";
>                         clock-frequency = <48000000>;
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 uart3: serial@48020000 {
> @@ -275,6 +295,8 @@
>                         interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "uart3";
>                         clock-frequency = <48000000>;
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 uart4: serial@4806e000 {
> @@ -283,6 +305,8 @@
>                         interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "uart4";
>                         clock-frequency = <48000000>;
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 hwspinlock: spinlock@4a0f6000 {
> @@ -298,6 +322,8 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c1";
> +                       clocks = <&func_96m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 i2c2: i2c@48072000 {
> @@ -307,6 +333,8 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c2";
> +                       clocks = <&func_96m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 i2c3: i2c@48060000 {
> @@ -316,6 +344,8 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c3";
> +                       clocks = <&func_96m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 i2c4: i2c@48350000 {
> @@ -325,6 +355,8 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c4";
> +                       clocks = <&func_96m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcspi1: spi@48098000 {
> @@ -345,6 +377,8 @@
>                                <&sdma 42>;
>                         dma-names = "tx0", "rx0", "tx1", "rx1",
>                                     "tx2", "rx2", "tx3", "rx3";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcspi2: spi@4809a000 {
> @@ -360,6 +394,8 @@
>                                <&sdma 45>,
>                                <&sdma 46>;
>                         dma-names = "tx0", "rx0", "tx1", "rx1";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcspi3: spi@480b8000 {
> @@ -372,6 +408,8 @@
>                         ti,spi-num-cs = <2>;
>                         dmas = <&sdma 15>, <&sdma 16>;
>                         dma-names = "tx0", "rx0";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcspi4: spi@480ba000 {
> @@ -384,6 +422,8 @@
>                         ti,spi-num-cs = <1>;
>                         dmas = <&sdma 70>, <&sdma 71>;
>                         dma-names = "tx0", "rx0";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mmc1: mmc@4809c000 {
> @@ -395,6 +435,8 @@
>                         ti,needs-special-reset;
>                         dmas = <&sdma 61>, <&sdma 62>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&hsmmc1_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mmc2: mmc@480b4000 {
> @@ -405,6 +447,8 @@
>                         ti,needs-special-reset;
>                         dmas = <&sdma 47>, <&sdma 48>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&hsmmc2_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mmc3: mmc@480ad000 {
> @@ -415,6 +459,8 @@
>                         ti,needs-special-reset;
>                         dmas = <&sdma 77>, <&sdma 78>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mmc4: mmc@480d1000 {
> @@ -425,6 +471,8 @@
>                         ti,needs-special-reset;
>                         dmas = <&sdma 57>, <&sdma 58>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mmc5: mmc@480d5000 {
> @@ -435,6 +483,8 @@
>                         ti,needs-special-reset;
>                         dmas = <&sdma 59>, <&sdma 60>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_48m_fclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 wdt2: wdt@4a314000 {
> @@ -442,6 +492,8 @@
>                         reg = <0x4a314000 0x80>;
>                         interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "wd_timer2";
> +                       clocks = <&sys_32k_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcpdm: mcpdm@40132000 {
> @@ -454,6 +506,8 @@
>                         dmas = <&sdma 65>,
>                                <&sdma 66>;
>                         dma-names = "up_link", "dn_link";
> +                       clocks = <&pad_clks_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 dmic: dmic@4012e000 {
> @@ -465,6 +519,8 @@
>                         ti,hwmods = "dmic";
>                         dmas = <&sdma 67>;
>                         dma-names = "up_link";
> +                       clocks = <&func_dmic_abe_gfclk>;
> +                       clock-names = "fck";
>                 };
>  
>                 mcbsp1: mcbsp@40122000 {
> @@ -479,6 +535,8 @@
>                         dmas = <&sdma 33>,
>                                <&sdma 34>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_mcbsp1_gfclk>, <&pad_clks_ck>, <&mcbsp1_sync_mux_ck>;
> +                       clock-names = "fck", "pad_fck", "prcm_fck";
>                 };
>  
>                 mcbsp2: mcbsp@40124000 {
> @@ -493,6 +551,8 @@
>                         dmas = <&sdma 17>,
>                                <&sdma 18>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_mcbsp2_gfclk>, <&pad_clks_ck>, <&mcbsp2_sync_mux_ck>;
> +                       clock-names = "fck", "pad_fck", "prcm_fck";
>                 };
>  
>                 mcbsp3: mcbsp@40126000 {
> @@ -507,6 +567,8 @@
>                         dmas = <&sdma 19>,
>                                <&sdma 20>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&func_mcbsp3_gfclk>, <&pad_clks_ck>, <&mcbsp3_sync_mux_ck>;
> +                       clock-names = "fck", "pad_fck", "prcm_fck";
>                 };
>  
>                 mcbsp4: mcbsp@48096000 {
> @@ -520,6 +582,8 @@
>                         dmas = <&sdma 31>,
>                                <&sdma 32>;
>                         dma-names = "tx", "rx";
> +                       clocks = <&per_mcbsp4_gfclk>, <&pad_clks_ck>, <&mcbsp4_sync_mux_ck>;
> +                       clock-names = "fck", "pad_fck", "prcm_fck";
>                 };
>  
>                 keypad: keypad@4a31c000 {
> @@ -528,6 +592,8 @@
>                         interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>                         reg-names = "mpu";
>                         ti,hwmods = "kbd";
> +                       clocks = <&sys_32k_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 emif1: emif@4c000000 {
> @@ -540,6 +606,8 @@
>                         hw-caps-read-idle-ctrl;
>                         hw-caps-ll-interface;
>                         hw-caps-temp-alert;
> +                       clocks = <&ddrphy_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 emif2: emif@4d000000 {
> @@ -552,6 +620,8 @@
>                         hw-caps-read-idle-ctrl;
>                         hw-caps-ll-interface;
>                         hw-caps-temp-alert;
> +                       clocks = <&ddrphy_ck>;
> +                       clock-names = "fck";
>                 };
>  
>                 ocp2scp@4a0ad000 {
> @@ -561,6 +631,8 @@
>                         #size-cells = <1>;
>                         ranges;
>                         ti,hwmods = "ocp2scp_usb_phy";
> +                       clocks = <&ocp2scp_usb_phy_phy_48m>;
> +                       clock-names = "fck";
>                         usb2_phy: usb2phy@4a0ad080 {
>                                 compatible = "ti,omap-usb2";
>                                 reg = <0x4a0ad080 0x58>;
> @@ -575,6 +647,8 @@
>                         interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer1";
>                         ti,timer-alwon;
> +                       clocks = <&dmt1_clk_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer2: timer@48032000 {
> @@ -582,6 +656,8 @@
>                         reg = <0x48032000 0x80>;
>                         interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer2";
> +                       clocks = <&cm2_dm2_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer3: timer@48034000 {
> @@ -589,6 +665,8 @@
>                         reg = <0x48034000 0x80>;
>                         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer3";
> +                       clocks = <&cm2_dm3_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer4: timer@48036000 {
> @@ -596,6 +674,8 @@
>                         reg = <0x48036000 0x80>;
>                         interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer4";
> +                       clocks = <&cm2_dm4_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer5: timer@40138000 {
> @@ -605,6 +685,8 @@
>                         interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer5";
>                         ti,timer-dsp;
> +                       clocks = <&timer5_sync_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer6: timer@4013a000 {
> @@ -614,6 +696,8 @@
>                         interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer6";
>                         ti,timer-dsp;
> +                       clocks = <&timer6_sync_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer7: timer@4013c000 {
> @@ -623,6 +707,8 @@
>                         interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer7";
>                         ti,timer-dsp;
> +                       clocks = <&timer7_sync_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer8: timer@4013e000 {
> @@ -633,6 +719,8 @@
>                         ti,hwmods = "timer8";
>                         ti,timer-pwm;
>                         ti,timer-dsp;
> +                       clocks = <&timer8_sync_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer9: timer@4803e000 {
> @@ -641,6 +729,8 @@
>                         interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer9";
>                         ti,timer-pwm;
> +                       clocks = <&cm2_dm9_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer10: timer@48086000 {
> @@ -649,6 +739,8 @@
>                         interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer10";
>                         ti,timer-pwm;
> +                       clocks = <&cm2_dm10_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 timer11: timer@48088000 {
> @@ -657,6 +749,8 @@
>                         interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "timer11";
>                         ti,timer-pwm;
> +                       clocks = <&cm2_dm11_mux>;
> +                       clock-names = "fck";
>                 };
>  
>                 usbhstll: usbhstll@4a062000 {
> @@ -664,6 +758,8 @@
>                         reg = <0x4a062000 0x1000>;
>                         interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>                         ti,hwmods = "usb_tll_hs";
> +                       clocks = <&usb_tll_hs_ick>;
> +                       clock-names = "fck";
>                 };
>  
>                 usbhshost: usbhshost@4a064000 {
> @@ -673,6 +769,8 @@
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> +                       clocks = <&usb_host_hs_fck>;
> +                       clock-names = "fck";
>  
>                         usbhsohci: ohci@4a064800 {
>                                 compatible = "ti,ohci-omap3", "usb-ohci";
> @@ -714,6 +812,8 @@
>                         num-eps = <16>;
>                         ram-bits = <12>;
>                         ctrl-module = <&omap_control_usbotg>;
> +                       clocks = <&usb_otg_hs_ick>;
> +                       clock-names = "fck";
>                 };
>  
>                 aes: aes@4b501000 {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 1e5b12c..aeda9e6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -334,7 +334,6 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>         .class          = &omap44xx_counter_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
>         .flags          = HWMOD_SWSUP_SIDLE,
> -       .main_clk       = "sys_32k_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
> @@ -479,7 +478,6 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
>         .class          = &omap44xx_dma_hwmod_class,
>         .clkdm_name     = "l3_dma_clkdm",
>         .mpu_irqs       = omap44xx_dma_system_irqs,
> -       .main_clk       = "l3_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
> @@ -514,7 +512,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
>         .name           = "dmic",
>         .class          = &omap44xx_dmic_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "func_dmic_abe_gfclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
> @@ -915,7 +912,6 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
>         .class          = &omap44xx_emif_hwmod_class,
>         .clkdm_name     = "l3_emif_clkdm",
>         .flags          = HWMOD_INIT_NO_IDLE,
> -       .main_clk       = "ddrphy_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
> @@ -931,7 +927,6 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
>         .class          = &omap44xx_emif_hwmod_class,
>         .clkdm_name     = "l3_emif_clkdm",
>         .flags          = HWMOD_INIT_NO_IDLE,
> -       .main_clk       = "ddrphy_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
> @@ -1014,16 +1009,10 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
>         .dbck_flag      = true,
>  };
>  
> -/* gpio1 */
> -static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio1_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio1_hwmod = {
>         .name           = "gpio1",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
> -       .main_clk       = "l4_wkup_clk_mux_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
> @@ -1031,22 +1020,14 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio1_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio1_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> -/* gpio2 */
> -static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio2_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio2_hwmod = {
>         .name           = "gpio2",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -       .main_clk       = "l4_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
> @@ -1054,22 +1035,14 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio2_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio2_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> -/* gpio3 */
> -static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio3_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio3_hwmod = {
>         .name           = "gpio3",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -       .main_clk       = "l4_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
> @@ -1077,22 +1050,14 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio3_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio3_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> -/* gpio4 */
> -static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio4_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio4_hwmod = {
>         .name           = "gpio4",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -       .main_clk       = "l4_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
> @@ -1100,22 +1065,14 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio4_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio4_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> -/* gpio5 */
> -static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio5_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio5_hwmod = {
>         .name           = "gpio5",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -       .main_clk       = "l4_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
> @@ -1123,22 +1080,14 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio5_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio5_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> -/* gpio6 */
> -static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
> -       { .role = "dbclk", .clk = "gpio6_dbclk" },
> -};
> -
>  static struct omap_hwmod omap44xx_gpio6_hwmod = {
>         .name           = "gpio6",
>         .class          = &omap44xx_gpio_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -       .main_clk       = "l4_div_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
> @@ -1146,8 +1095,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
>                         .modulemode   = MODULEMODE_HWCTRL,
>                 },
>         },
> -       .opt_clks       = gpio6_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(gpio6_opt_clks),
>         .dev_attr       = &gpio_dev_attr,
>  };
>  
> @@ -1337,7 +1284,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
>         .class          = &omap44xx_i2c_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "func_96m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
> @@ -1354,7 +1300,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
>         .class          = &omap44xx_i2c_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "func_96m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
> @@ -1371,7 +1316,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
>         .class          = &omap44xx_i2c_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "func_96m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
> @@ -1388,7 +1332,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
>         .class          = &omap44xx_i2c_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "func_96m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
> @@ -1542,7 +1485,6 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
>         .name           = "kbd",
>         .class          = &omap44xx_kbd_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
> -       .main_clk       = "sys_32k_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
> @@ -1642,17 +1584,10 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
>         .rev    = MCBSP_CONFIG_TYPE4,
>  };
>  
> -/* mcbsp1 */
> -static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
> -       { .role = "pad_fck", .clk = "pad_clks_ck" },
> -       { .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
> -};
> -
>  static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
>         .name           = "mcbsp1",
>         .class          = &omap44xx_mcbsp_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "func_mcbsp1_gfclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
> @@ -1660,21 +1595,12 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
>                         .modulemode   = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .opt_clks       = mcbsp1_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(mcbsp1_opt_clks),
> -};
> -
> -/* mcbsp2 */
> -static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] = {
> -       { .role = "pad_fck", .clk = "pad_clks_ck" },
> -       { .role = "prcm_fck", .clk = "mcbsp2_sync_mux_ck" },
>  };
>  
>  static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
>         .name           = "mcbsp2",
>         .class          = &omap44xx_mcbsp_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "func_mcbsp2_gfclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
> @@ -1682,21 +1608,12 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
>                         .modulemode   = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .opt_clks       = mcbsp2_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(mcbsp2_opt_clks),
> -};
> -
> -/* mcbsp3 */
> -static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] = {
> -       { .role = "pad_fck", .clk = "pad_clks_ck" },
> -       { .role = "prcm_fck", .clk = "mcbsp3_sync_mux_ck" },
>  };
>  
>  static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
>         .name           = "mcbsp3",
>         .class          = &omap44xx_mcbsp_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "func_mcbsp3_gfclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
> @@ -1704,21 +1621,12 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
>                         .modulemode   = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .opt_clks       = mcbsp3_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(mcbsp3_opt_clks),
> -};
> -
> -/* mcbsp4 */
> -static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] = {
> -       { .role = "pad_fck", .clk = "pad_clks_ck" },
> -       { .role = "prcm_fck", .clk = "mcbsp4_sync_mux_ck" },
>  };
>  
>  static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
>         .name           = "mcbsp4",
>         .class          = &omap44xx_mcbsp_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
> -       .main_clk       = "per_mcbsp4_gfclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
> @@ -1726,8 +1634,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
>                         .modulemode   = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .opt_clks       = mcbsp4_opt_clks,
> -       .opt_clks_cnt   = ARRAY_SIZE(mcbsp4_opt_clks),
>  };
>  
>  /*
> @@ -1823,7 +1729,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
>         .class          = &omap44xx_mcspi_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mcspi1_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
> @@ -1853,7 +1758,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
>         .class          = &omap44xx_mcspi_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mcspi2_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
> @@ -1883,7 +1787,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
>         .class          = &omap44xx_mcspi_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mcspi3_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
> @@ -1911,7 +1814,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
>         .class          = &omap44xx_mcspi_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mcspi4_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
> @@ -1961,7 +1863,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
>         .class          = &omap44xx_mmc_hwmod_class,
>         .clkdm_name     = "l3_init_clkdm",
>         .sdma_reqs      = omap44xx_mmc1_sdma_reqs,
> -       .main_clk       = "hsmmc1_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
> @@ -1984,7 +1885,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
>         .class          = &omap44xx_mmc_hwmod_class,
>         .clkdm_name     = "l3_init_clkdm",
>         .sdma_reqs      = omap44xx_mmc2_sdma_reqs,
> -       .main_clk       = "hsmmc2_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
> @@ -2006,7 +1906,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
>         .class          = &omap44xx_mmc_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mmc3_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
> @@ -2028,7 +1927,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
>         .class          = &omap44xx_mmc_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mmc4_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
> @@ -2050,7 +1948,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
>         .class          = &omap44xx_mmc_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .sdma_reqs      = omap44xx_mmc5_sdma_reqs,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
> @@ -2261,7 +2158,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
>          * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
>          * to be the best workaround.
>          */
> -       .main_clk       = "ocp2scp_usb_phy_phy_48m",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
> @@ -2646,7 +2542,6 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
>         .class          = &omap44xx_timer_1ms_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "cm2_dm2_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
> @@ -2661,7 +2556,6 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
>         .name           = "timer3",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
> -       .main_clk       = "cm2_dm3_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
> @@ -2676,7 +2570,6 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
>         .name           = "timer4",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
> -       .main_clk       = "cm2_dm4_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
> @@ -2691,7 +2584,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
>         .name           = "timer5",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "timer5_sync_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
> @@ -2707,7 +2599,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
>         .name           = "timer6",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "timer6_sync_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
> @@ -2723,7 +2614,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
>         .name           = "timer7",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "timer7_sync_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
> @@ -2739,7 +2629,6 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
>         .name           = "timer8",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "abe_clkdm",
> -       .main_clk       = "timer8_sync_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
> @@ -2755,7 +2644,6 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
>         .name           = "timer9",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
> -       .main_clk       = "cm2_dm9_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
> @@ -2772,7 +2660,6 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
>         .class          = &omap44xx_timer_1ms_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_SET_DEFAULT_CLOCKACT,
> -       .main_clk       = "cm2_dm10_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
> @@ -2788,7 +2675,6 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
>         .name           = "timer11",
>         .class          = &omap44xx_timer_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
> -       .main_clk       = "cm2_dm11_mux",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
> @@ -2827,7 +2713,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
>         .class          = &omap44xx_uart_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_SWSUP_SIDLE_ACT,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
> @@ -2843,7 +2728,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
>         .class          = &omap44xx_uart_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = HWMOD_SWSUP_SIDLE_ACT,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
> @@ -2859,7 +2743,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
>         .class          = &omap44xx_uart_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = DEBUG_OMAP4UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
> @@ -2875,7 +2758,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
>         .class          = &omap44xx_uart_hwmod_class,
>         .clkdm_name     = "l4_per_clkdm",
>         .flags          = DEBUG_OMAP4UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
> -       .main_clk       = "func_48m_fclk",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
> @@ -2954,7 +2836,6 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
>         .name           = "usb_host_hs",
>         .class          = &omap44xx_usb_host_hs_hwmod_class,
>         .clkdm_name     = "l3_init_clkdm",
> -       .main_clk       = "usb_host_hs_fck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
> @@ -3045,7 +2926,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
>         .class          = &omap44xx_usb_otg_hs_hwmod_class,
>         .clkdm_name     = "l3_init_clkdm",
>         .flags          = HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> -       .main_clk       = "usb_otg_hs_ick",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
> @@ -3082,7 +2962,6 @@ static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
>         .name           = "usb_tll_hs",
>         .class          = &omap44xx_usb_tll_hs_hwmod_class,
>         .clkdm_name     = "l3_init_clkdm",
> -       .main_clk       = "usb_tll_hs_ick",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET,
> @@ -3121,7 +3000,6 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
>         .name           = "wd_timer2",
>         .class          = &omap44xx_wd_timer_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
> -       .main_clk       = "sys_32k_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
> -- 
> 1.7.9.5
> 
