From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] ARM: OMAP2+: clean up some cppcheck warnings
Date: Mon, 12 Mar 2012 16:43:04 -0600
Message-ID: <20120312224257.4103.11096.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37695 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757723Ab2CLWnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 18:43:41 -0400
In-Reply-To: <20120312224006.4103.29464.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Charulatha Varadarajan <charu@ti.com>

Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:

    [arch/arm/mach-omap2/usb-tusb6010.c:129]: (style) Checking if unsigned variable 'tmp' is less than zero.
    [arch/arm/mach-omap2/prm_common.c:241]: (error) Possible null pointer dereference: irq_setup - otherwise it is redundant to check if irq_setup is null at line 247
    [arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'per_clkdm' is assigned a value that is never used
    [arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'core_clkdm' is assigned a value that is never used
    [arch/arm/mach-omap2/pm24xx.c:185]: (style) Variable 'only_idle' is assigned a value that is never used
    [arch/arm/mach-omap2/mux.c:254]: (error) Possible null pointer dereference: mux
    [arch/arm/mach-omap2/mux.c:258]: (error) Possible null pointer dereference: mux
    [arch/arm/mach-omap2/mcbsp.c:133]: (warning) scanf without field width limits can crash with huge input data
    [arch/arm/mach-omap2/gpmc-onenand.c:178]: (style) Variable 'tick_ns' is assigned a value that is never used
    [arch/arm/mach-omap2/gpio.c:43]: (warning) scanf without field width limits can crash with huge input data
    [arch/arm/mach-omap2/gpio.c:56]: (error) Possible null pointer dereference: pdata - otherwise it is redundant to check if pdata is null at line 57
    [arch/arm/mach-omap2/devices.c:45]: (style) Variable 'l' is assigned a value that is never used
    [arch/arm/mach-omap2/board-am3517evm.c:134]: (style) Variable 'regval' is assigned a value that is never used

Some of them are pretty good catches, such the gpio.c:56 and
usb-tusb6010.c:129.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    6 +-----
 arch/arm/mach-omap2/board-omap3evm.c  |    8 ++++----
 arch/arm/mach-omap2/devices.c         |    3 +--
 arch/arm/mach-omap2/gpio.c            |    4 ++--
 arch/arm/mach-omap2/gpmc-onenand.c    |    3 +--
 arch/arm/mach-omap2/mcbsp.c           |    2 +-
 arch/arm/mach-omap2/mux.c             |    2 +-
 arch/arm/mach-omap2/pm24xx.c          |    3 ---
 arch/arm/mach-omap2/pm34xx.c          |    4 +---
 arch/arm/mach-omap2/prm_common.c      |    4 +++-
 arch/arm/mach-omap2/usb-tusb6010.c    |    2 +-
 11 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4b1cfe3..24b1f9a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -150,13 +150,9 @@ static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 	regval = regval & (~(AM35XX_CPGMACSS_SW_RST));
 	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-	return ;
+	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 }
 
-
-
 #define LCD_PANEL_PWR		176
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c877236..becf41d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -634,12 +634,12 @@ static void __init omap3_evm_wl12xx_init(void)
 
 static void __init omap3_evm_init(void)
 {
+	static struct omap_board_mux *obm;
+
 	omap3_evm_get_revision();
 
-	if (cpu_is_omap3630())
-		omap3_mux_init(omap36x_board_mux, OMAP_PACKAGE_CBB);
-	else
-		omap3_mux_init(omap35x_board_mux, OMAP_PACKAGE_CBB);
+	obm = (cpu_is_omap3630()) ? omap36x_board_mux : omap35x_board_mux;
+	omap3_mux_init(obm, OMAP_PACKAGE_CBB);
 
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..b52cd16 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -42,7 +42,6 @@
 
 static int __init omap3_l3_init(void)
 {
-	int l;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 	char oh_name[L3_MODULES_MAX_LEN];
@@ -54,7 +53,7 @@ static int __init omap3_l3_init(void)
 	if (!(cpu_is_omap34xx()))
 		return -ENODEV;
 
-	l = snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
+	snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
 
 	oh = omap_hwmod_lookup(oh_name);
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..f64fcb2 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -40,7 +40,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	 * not change. If changed, make corresponding change here
 	 * or make use of static variable mechanism to handle this.
 	 */
-	sscanf(oh->name, "gpio%d", &id);
+	sscanf(oh->name, "gpio%1d", &id);
 
 	pdata = kzalloc(sizeof(struct omap_gpio_platform_data), GFP_KERNEL);
 	if (!pdata) {
@@ -54,7 +54,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
 
 	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
-	if (!pdata) {
+	if (!pdata->regs) {
 		pr_err("gpio%d: Memory allocation failed\n", id);
 		return -ENOMEM;
 	}
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 5cdce10..6ab726f 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -175,7 +175,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	const int t_wpl  = 40;
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
-	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
+	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
 	int first_time = 0, hf = 0, vhf = 0, sync_read = 0, sync_write = 0;
 	int err, ticks_cez;
 	int cs = cfg->cs, freq = *freq_ptr;
@@ -239,7 +239,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		break;
 	}
 
-	tick_ns = gpmc_ticks_to_ns(1);
 	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
 	if (gpmc_clk_ns < 15) /* >66Mhz */
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index fb4bcf8..efe59c7 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -130,7 +130,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	struct omap_mcbsp_platform_data *pdata = NULL;
 	struct platform_device *pdev;
 
-	sscanf(oh->name, "mcbsp%d", &id);
+	sscanf(oh->name, "mcbsp%1d", &id);
 
 	pdata = kzalloc(sizeof(struct omap_mcbsp_platform_data), GFP_KERNEL);
 	if (!pdata) {
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 611a0e3..552225a 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -248,7 +248,7 @@ int omap_mux_init_signal(const char *muxname, int val)
 	int mux_mode;
 
 	mux_mode = omap_mux_get_by_name(muxname, &partition, &mux);
-	if (mux_mode < 0)
+	if (mux_mode < 0 || !mux)
 		return mux_mode;
 
 	old_mode = omap_mux_read(partition, mux->reg_offset);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 23de98d..b3a4765 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -182,8 +182,6 @@ static int omap2_allow_mpu_retention(void)
 
 static void omap2_enter_mpu_retention(void)
 {
-	int only_idle = 0;
-
 	/* Putting MPU into the WFI state while a transfer is active
 	 * seems to cause the I2C block to timeout. Why? Good question. */
 	if (omap2_i2c_active())
@@ -206,7 +204,6 @@ static void omap2_enter_mpu_retention(void)
 
 		omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 						 OMAP2_PM_PWSTCTRL);
-		only_idle = 1;
 	}
 
 	omap2_sram_idle();
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..0b65785 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -787,7 +787,7 @@ static void __init pm_errata_configure(void)
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
-	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
+	struct clockdomain *neon_clkdm, *mpu_clkdm;
 	int ret;
 
 	if (!cpu_is_omap34xx())
@@ -841,8 +841,6 @@ static int __init omap3_pm_init(void)
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-	per_clkdm = clkdm_lookup("per_clkdm");
-	core_clkdm = clkdm_lookup("core_clkdm");
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 860118a..c7c7373 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -238,7 +238,7 @@ void omap_prcm_irq_complete(void)
  */
 int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 {
-	int nr_regs = irq_setup->nr_regs;
+	int nr_regs;
 	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
 	int offset, i;
 	struct irq_chip_generic *gc;
@@ -247,6 +247,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 	if (!irq_setup)
 		return -EINVAL;
 
+	nr_regs = irq_setup->nr_regs;
+
 	if (prcm_irq_setup) {
 		pr_err("PRCM: already initialized; won't reinitialize\n");
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 994d8f5..db84a46 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -126,7 +126,7 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = (t.sync_clk + fclk_ps - 1) / fclk_ps;
 	if (tmp > 4)
 		return -ERANGE;
-	if (tmp <= 0)
+	if (tmp == 0)
 		tmp = 1;
 	t.page_burst_access = (fclk_ps * tmp) / 1000;
 


