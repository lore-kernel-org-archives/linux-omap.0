From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 5/5] ARM: OMAP2+: clean up some cppcheck warnings
Date: Tue, 13 Mar 2012 02:44:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203130243030.22211@utopia.booyaka.com>
References: <20120312224006.4103.29464.stgit@dusk> <20120312224257.4103.11096.stgit@dusk> <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-732684543-1331628261=:22211"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37606 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab2CMIoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 04:44:22 -0400
In-Reply-To: <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, =?ISO-8859-15?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Charulatha Varadarajan <charu@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-732684543-1331628261=:22211
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:

    [arch/arm/mach-omap2/usb-tusb6010.c:129]: (style) Checking if unsigned =
variable 'tmp' is less than zero.
    [arch/arm/mach-omap2/prm_common.c:241]: (error) Possible null pointer d=
ereference: irq_setup - otherwise it is redundant to check if irq_setup is =
null at line 247
    [arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'per_clkdm' is ass=
igned a value that is never used
    [arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'core_clkdm' is as=
signed a value that is never used
    [arch/arm/mach-omap2/pm24xx.c:185]: (style) Variable 'only_idle' is ass=
igned a value that is never used
    [arch/arm/mach-omap2/mux.c:254]: (error) Possible null pointer derefere=
nce: mux
    [arch/arm/mach-omap2/mux.c:258]: (error) Possible null pointer derefere=
nce: mux
    [arch/arm/mach-omap2/gpmc-onenand.c:178]: (style) Variable 'tick_ns' is=
 assigned a value that is never used
    [arch/arm/mach-omap2/gpio.c:56]: (error) Possible null pointer derefere=
nce: pdata - otherwise it is redundant to check if pdata is null at line 57
    [arch/arm/mach-omap2/devices.c:45]: (style) Variable 'l' is assigned a =
value that is never used
    [arch/arm/mach-omap2/board-am3517evm.c:134]: (style) Variable 'regval' =
is assigned a value that is never used
    [arch/arm/mach-omap2/board-omap3evm.c:641] -> [arch/arm/mach-omap2/boar=
d-omap3evm.c:639]: (style) Found duplicate branches for if and else.

Some of them are pretty good catches, such the gpio.c:56 and
usb-tusb6010.c:129.

Thanks to Jarkko Nikula for some comments on the sscanf() warnings.
It seems that the kernel sscanf() ignores the field width anyway for the
%d format, so those changes have been dropped from this second version.

Thanks to Daniel Marjam=E4ki <daniel.marjamaki@gmail.com> for pointing
out that a variable was unnecessarily marked static in the=20
board-omap3evm.c change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Charulatha Varadarajan <charu@ti.com>
Cc: Daniel Marjam=E4ki <daniel.marjamaki@gmail.com>
Reviewed-by: Charulatha Varadarajan <charu@ti.com> # for gpio.c
---
 arch/arm/mach-omap2/board-am3517evm.c |    6 +-----
 arch/arm/mach-omap2/board-omap3evm.c  |    8 ++++----
 arch/arm/mach-omap2/devices.c         |    3 +--
 arch/arm/mach-omap2/gpio.c            |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c    |    3 +--
 arch/arm/mach-omap2/mux.c             |    2 +-
 arch/arm/mach-omap2/pm24xx.c          |    3 ---
 arch/arm/mach-omap2/pm34xx.c          |    4 +---
 arch/arm/mach-omap2/prm_common.c      |    4 +++-
 arch/arm/mach-omap2/usb-tusb6010.c    |    2 +-
 10 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/bo=
ard-am3517evm.c
index 4b1cfe3..24b1f9a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -150,13 +150,9 @@ static void am3517_evm_ethernet_init(struct emac_platf=
orm_data *pdata)
 =09regval =3D omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 =09regval =3D regval & (~(AM35XX_CPGMACSS_SW_RST));
 =09omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-=09regval =3D omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-=09return ;
+=09omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 }
=20
-
-
 #define LCD_PANEL_PWR=09=09176
 #define LCD_PANEL_BKLIGHT_PWR=09182
 #define LCD_PANEL_PWM=09=09181
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/boa=
rd-omap3evm.c
index c877236..7a45d1e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -634,12 +634,12 @@ static void __init omap3_evm_wl12xx_init(void)
=20
 static void __init omap3_evm_init(void)
 {
+=09struct omap_board_mux *obm;
+
 =09omap3_evm_get_revision();
=20
-=09if (cpu_is_omap3630())
-=09=09omap3_mux_init(omap36x_board_mux, OMAP_PACKAGE_CBB);
-=09else
-=09=09omap3_mux_init(omap35x_board_mux, OMAP_PACKAGE_CBB);
+=09obm =3D (cpu_is_omap3630()) ? omap36x_board_mux : omap35x_board_mux;
+=09omap3_mux_init(obm, OMAP_PACKAGE_CBB);
=20
 =09omap_board_config =3D omap3_evm_config;
 =09omap_board_config_size =3D ARRAY_SIZE(omap3_evm_config);
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..b52cd16 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -42,7 +42,6 @@
=20
 static int __init omap3_l3_init(void)
 {
-=09int l;
 =09struct omap_hwmod *oh;
 =09struct platform_device *pdev;
 =09char oh_name[L3_MODULES_MAX_LEN];
@@ -54,7 +53,7 @@ static int __init omap3_l3_init(void)
 =09if (!(cpu_is_omap34xx()))
 =09=09return -ENODEV;
=20
-=09l =3D snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
+=09snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
=20
 =09oh =3D omap_hwmod_lookup(oh_name);
=20
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..2803ff8 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -54,7 +54,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, voi=
d *unused)
 =09pdata->virtual_irq_start =3D IH_GPIO_BASE + 32 * (id - 1);
=20
 =09pdata->regs =3D kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
-=09if (!pdata) {
+=09if (!pdata->regs) {
 =09=09pr_err("gpio%d: Memory allocation failed\n", id);
 =09=09return -ENOMEM;
 =09}
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-=
onenand.c
index 5cdce10..6ab726f 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -175,7 +175,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onen=
and_platform_data *cfg,
 =09const int t_wpl  =3D 40;
 =09const int t_wph  =3D 30;
 =09int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
-=09int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
+=09int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
 =09int first_time =3D 0, hf =3D 0, vhf =3D 0, sync_read =3D 0, sync_write =
=3D 0;
 =09int err, ticks_cez;
 =09int cs =3D cfg->cs, freq =3D *freq_ptr;
@@ -239,7 +239,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onen=
and_platform_data *cfg,
 =09=09break;
 =09}
=20
-=09tick_ns =3D gpmc_ticks_to_ns(1);
 =09div =3D gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
 =09gpmc_clk_ns =3D gpmc_ticks_to_ns(div);
 =09if (gpmc_clk_ns < 15) /* >66Mhz */
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 611a0e3..552225a 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -248,7 +248,7 @@ int omap_mux_init_signal(const char *muxname, int val)
 =09int mux_mode;
=20
 =09mux_mode =3D omap_mux_get_by_name(muxname, &partition, &mux);
-=09if (mux_mode < 0)
+=09if (mux_mode < 0 || !mux)
 =09=09return mux_mode;
=20
 =09old_mode =3D omap_mux_read(partition, mux->reg_offset);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 23de98d..b3a4765 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -182,8 +182,6 @@ static int omap2_allow_mpu_retention(void)
=20
 static void omap2_enter_mpu_retention(void)
 {
-=09int only_idle =3D 0;
-
 =09/* Putting MPU into the WFI state while a transfer is active
 =09 * seems to cause the I2C block to timeout. Why? Good question. */
 =09if (omap2_i2c_active())
@@ -206,7 +204,6 @@ static void omap2_enter_mpu_retention(void)
=20
 =09=09omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 =09=09=09=09=09=09 OMAP2_PM_PWSTCTRL);
-=09=09only_idle =3D 1;
 =09}
=20
 =09omap2_sram_idle();
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..0b65785 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -787,7 +787,7 @@ static void __init pm_errata_configure(void)
 static int __init omap3_pm_init(void)
 {
 =09struct power_state *pwrst, *tmp;
-=09struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
+=09struct clockdomain *neon_clkdm, *mpu_clkdm;
 =09int ret;
=20
 =09if (!cpu_is_omap34xx())
@@ -841,8 +841,6 @@ static int __init omap3_pm_init(void)
=20
 =09neon_clkdm =3D clkdm_lookup("neon_clkdm");
 =09mpu_clkdm =3D clkdm_lookup("mpu_clkdm");
-=09per_clkdm =3D clkdm_lookup("per_clkdm");
-=09core_clkdm =3D clkdm_lookup("core_clkdm");
=20
 #ifdef CONFIG_SUSPEND
 =09suspend_set_ops(&omap_pm_ops);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_com=
mon.c
index 860118a..c7c7373 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -238,7 +238,7 @@ void omap_prcm_irq_complete(void)
  */
 int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup=
)
 {
-=09int nr_regs =3D irq_setup->nr_regs;
+=09int nr_regs;
 =09u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
 =09int offset, i;
 =09struct irq_chip_generic *gc;
@@ -247,6 +247,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_i=
rq_setup *irq_setup)
 =09if (!irq_setup)
 =09=09return -EINVAL;
=20
+=09nr_regs =3D irq_setup->nr_regs;
+
 =09if (prcm_irq_setup) {
 =09=09pr_err("PRCM: already initialized; won't reinitialize\n");
 =09=09return -EINVAL;
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-t=
usb6010.c
index 994d8f5..db84a46 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -126,7 +126,7 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsig=
ned fclk_ps)
 =09tmp =3D (t.sync_clk + fclk_ps - 1) / fclk_ps;
 =09if (tmp > 4)
 =09=09return -ERANGE;
-=09if (tmp <=3D 0)
+=09if (tmp =3D=3D 0)
 =09=09tmp =3D 1;
 =09t.page_burst_access =3D (fclk_ps * tmp) / 1000;
=20
--=20
1.7.9.1

--155748971-732684543-1331628261=:22211--
