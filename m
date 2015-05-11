From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Show proper respect for Heinrich Hertz by using the correct
 unit for frequency
Date: Mon, 11 May 2015 14:19:52 +0100
Message-ID: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
given the symbol "Hz" to denote this.  "hz" is not the unit of frequency,
and is in fact meaningless.

Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich Hertz
contribution to the modern world.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

There are other instances in drivers/ that really need to be fixed as well.

 arch/arm/boot/dts/exynos5260-xyref5260.dts   | 2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts         | 2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h   | 2 +-
 arch/arm/mach-imx/clk-imx6sx.c               | 4 ++--
 arch/arm/mach-iop13xx/include/mach/time.h    | 2 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h | 2 +-
 arch/arm/mach-ks8695/include/mach/hardware.h | 2 +-
 arch/arm/mach-omap2/gpmc-onenand.c           | 4 ++--
 arch/arm/mach-omap2/hsmmc.c                  | 2 +-
 arch/arm/mach-omap2/opp2430_data.c           | 4 ++--
 arch/arm/mach-omap2/sdrc2xxx.c               | 2 +-
 arch/arm/mach-omap2/sram242x.S               | 2 +-
 arch/arm/mach-omap2/sram243x.S               | 2 +-
 arch/arm/mach-pxa/mp900.c                    | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index a803b605051b..3daef94bee38 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -70,7 +70,7 @@
 	broken-cd;
 	bypass-smu;
 	cap-mmc-highspeed;
-	supports-hs200-mode; /* 200 Mhz */
+	supports-hs200-mode; /* 200 MHz */
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index f5b5a1d96cd7..53ae04f9104d 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -66,7 +66,7 @@
 
 	otg_drv_vbus: pinmux_otg_drv_vbus {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50Mhz_clk.usb0_drvvbus */
+			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50MHz_clk.usb0_drvvbus */
 		>;
 	};
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 39e58b48e826..f9f9713aacdd 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -36,7 +36,7 @@ extern void __iomem *da8xx_syscfg1_base;
 
 /*
  * If the DA850/OMAP-L138/AM18x SoC on board is of a higher speed grade
- * (than the regular 300Mhz variant), the board code should set this up
+ * (than the regular 300MHz variant), the board code should set this up
  * with the supported speed before calling da850_register_cpufreq().
  */
 extern unsigned int da850_max_speed;
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 5a3e5a159e70..87c5b0911ddd 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -216,7 +216,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_USBPHY1_GATE] = imx_clk_gate("usbphy1_gate", "dummy", base + 0x10, 6);
 	clks[IMX6SX_CLK_USBPHY2_GATE] = imx_clk_gate("usbphy2_gate", "dummy", base + 0x20, 6);
 
-	/* FIXME 100Mhz is used for pcie ref for all imx6 pcie, excepted imx6q */
+	/* FIXME 100MHz is used for pcie ref for all imx6 pcie, excepted imx6q */
 	clks[IMX6SX_CLK_PCIE_REF] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 5);
 	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
 
@@ -520,7 +520,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 		pr_err("Failed to set pcie parent clk.\n");
 
 	/*
-	 * Init enet system AHB clock, set to 200Mhz
+	 * Init enet system AHB clock, set to 200MHz
 	 * pll2_pfd2_396m-> ENET_PODF-> ENET_AHB
 	 */
 	clk_set_parent(clks[IMX6SX_CLK_ENET_PRE_SEL], clks[IMX6SX_CLK_PLL2_PFD2]);
diff --git a/arch/arm/mach-iop13xx/include/mach/time.h b/arch/arm/mach-iop13xx/include/mach/time.h
index 15bc9bb78a6b..c871e6874594 100644
--- a/arch/arm/mach-iop13xx/include/mach/time.h
+++ b/arch/arm/mach-iop13xx/include/mach/time.h
@@ -42,7 +42,7 @@ static inline unsigned long iop13xx_core_freq(void)
 	case IOP13XX_CORE_FREQ_1200:
 		return 1200000000;
 	default:
-		printk("%s: warning unknown frequency, defaulting to 800Mhz\n",
+		printk("%s: warning unknown frequency, defaulting to 800MHz\n",
 			__func__);
 	}
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 75c4c6572ad0..34b3d3f3f131 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -74,7 +74,7 @@ extern unsigned long ixp4xx_exp_bus_size;
 /*
  * Clock Speed Definitions.
  */
-#define IXP4XX_PERIPHERAL_BUS_CLOCK 	(66) /* 66Mhzi APB BUS   */ 
+#define IXP4XX_PERIPHERAL_BUS_CLOCK 	(66) /* 66MHzi APB BUS   */ 
 #define IXP4XX_UART_XTAL        	14745600
 
 /*
diff --git a/arch/arm/mach-ks8695/include/mach/hardware.h b/arch/arm/mach-ks8695/include/mach/hardware.h
index 5090338c0db2..959c748ee8bb 100644
--- a/arch/arm/mach-ks8695/include/mach/hardware.h
+++ b/arch/arm/mach-ks8695/include/mach/hardware.h
@@ -17,7 +17,7 @@
 #include <asm/sizes.h>
 
 /*
- * Clocks are derived from MCLK, which is 25Mhz
+ * Clocks are derived from MCLK, which is 25MHz
  */
 #define KS8695_CLOCK_RATE	25000000
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index f899e77ff5e6..17a6f752a436 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -216,11 +216,11 @@ static void omap2_onenand_calc_sync_timings(struct gpmc_timings *t,
 
 	div = gpmc_calc_divider(min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
-	if (gpmc_clk_ns < 15) /* >66Mhz */
+	if (gpmc_clk_ns < 15) /* >66MHz */
 		onenand_flags |= ONENAND_FLAG_HF;
 	else
 		onenand_flags &= ~ONENAND_FLAG_HF;
-	if (gpmc_clk_ns < 12) /* >83Mhz */
+	if (gpmc_clk_ns < 12) /* >83MHz */
 		onenand_flags |= ONENAND_FLAG_VHF;
 	else
 		onenand_flags &= ~ONENAND_FLAG_VHF;
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9a8611ab5dfa..cff079e563f4 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -70,7 +70,7 @@ static void omap_hsmmc1_before_set_reg(struct device *dev,
 
 		reg = omap_ctrl_readl(control_pbias_offset);
 		if (cpu_is_omap3630()) {
-			/* Set MMC I/O to 52Mhz */
+			/* Set MMC I/O to 52MHz */
 			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
 			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
 			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
index 0e75ec3e114b..b2233b72b24d 100644
--- a/arch/arm/mach-omap2/opp2430_data.c
+++ b/arch/arm/mach-omap2/opp2430_data.c
@@ -116,7 +116,7 @@ const struct prcm_config omap2430_rate_table[] = {
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
-	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13Mhz */
+	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13MHz */
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
@@ -124,7 +124,7 @@ const struct prcm_config omap2430_rate_table[] = {
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
-	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12Mhz */
+	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12MHz */
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index ae3f1553158d..339b0ecb7c32 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -164,6 +164,6 @@ void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode)
 	mem_timings.slow_dll_ctrl |=
 		((mem_timings.fast_dll_ctrl & 0xF) | (1 << 2));
 
-	/* 90 degree phase for anything below 133Mhz + disable DLL filter */
+	/* 90 degree phase for anything below 133MHz + disable DLL filter */
 	mem_timings.slow_dll_ctrl |= ((1 << 1) | (3 << 8));
 }
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 2c88ff2d0236..53a2537cd75a 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -64,7 +64,7 @@ ENTRY(omap242x_sram_ddr_init)
 	mvn	r9, #0x4		@ mask to get clear bit2
 	and	r10, r10, r9		@ clear bit2 for lock mode.
 	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
-	orr	r10, r10, #0x2		@ 90 degree phase for all below 133Mhz
+	orr	r10, r10, #0x2		@ 90 degree phase for all below 133MHz
 	str	r10, [r11]		@ commit to DLLA_CTRL
 	bl	i_dll_wait		@ wait for dll to lock
 
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index d5deb9761fc7..b3edd6f7f7db 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -64,7 +64,7 @@ ENTRY(omap243x_sram_ddr_init)
 	mvn	r9, #0x4		@ mask to get clear bit2
 	and	r10, r10, r9		@ clear bit2 for lock mode.
 	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
-	orr	r10, r10, #0x2		@ 90 degree phase for all below 133Mhz
+	orr	r10, r10, #0x2		@ 90 degree phase for all below 133MHz
 	str	r10, [r11]		@ commit to DLLA_CTRL
 	bl	i_dll_wait		@ wait for dll to lock
 
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 854f1f562d6b..14f6aaf8fcc9 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -28,7 +28,7 @@
 static void isp116x_pfm_delay(struct device *dev, int delay)
 {
 
-	/* 400Mhz PXA2 = 2.5ns / instruction */
+	/* 400MHz PXA2 = 2.5ns / instruction */
 
 	int cyc = delay / 10;
 


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
