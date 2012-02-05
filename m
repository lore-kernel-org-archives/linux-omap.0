From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 12:59:04 +0000
Message-ID: <20120205125904.GB11372@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34360 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2BEM7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 07:59:13 -0500
Content-Disposition: inline
In-Reply-To: <20120205012556.GG1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Feb 04, 2012 at 05:25:57PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> > 
> > Another problem (some build errors for OMAP3) do seem to be solved, but
> > not the section mismatch warnings.  They're easy to verify before code
> > gets pushed anywhere upstream, especially if you're doing one giant OMAP
> > build - just enable CONFIG_DEBUG_SECTION_MISMATCH in your build
> > configuration.  Refuse patches which introduce section mismatches - at
> > least without an explanation backing up why they do.
> >
> > My OMAP3 and OMAP4 configurations spit out these - I've not even tried
> > my OMAP2 configuration yet:
> 
> Weird. The warnings you're seeing all seem valid to me, but I'm not seeing
> any the section warnings with the following compilers I have:
> 
> gcc version 4.3.5 (Debian 4.3.5-4)
> gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203)
> gcc version 4.6.1 (Sourcery CodeBench Lite 2011.09-70)
> 
> I see _different_ warnings if I compile with an older gcc:
> gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)
> 
> Any ideas why that would be?

Different inlining behaviour maybe?  I'm using stock gcc 4.3.5 here.

> The only warnings I see are:
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19a4): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19a8): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19ac): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19b0): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19b4): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x12b70): Section mismatch in reference from the function cm_t35_init_usbh() to the (unknown reference) .init.data:(unknown)
> The function cm_t35_init_usbh() references
> the (unknown reference) __initdata (unknown).
> This is often because cm_t35_init_usbh lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x1c424): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x1c428): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x1c42c): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x1c430): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x1c434): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
> The function omap_serial_fill_default_pads() references
> the (unknown reference) __initdata (unknown).
> This is often because omap_serial_fill_default_pads lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x2d5f0): Section mismatch in reference from the function cm_t35_init_usbh() to the (unknown reference) .init.data:(unknown)
> The function cm_t35_init_usbh() references
> the (unknown reference) __initdata (unknown).
> This is often because cm_t35_init_usbh lacks a __initdata 
> annotation or the annotation of (unknown) is wrong.

If I look at this warning:

WARNING: vmlinux.o(.text+0x1c434): Section mismatch in reference from the fun$> The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata
annotation or the annotation of (unknown) is wrong.

on OMAP3, where CONFIG_OMAP_MUX=y and CONFIG_CC_OPTIMIZE_FOR_SIZE=y,
then, the reason I don't get that warning is because
omap_serial_fill_default_pads() gets folded into omap_serial_board_init()
for me.  There's not much which can be done to stop that thing happening.

However, the fact that you're not finding stuff like the reference from

static int __devinit
twl_probe(struct i2c_client *client, const struct i2c_device_id *id)

to:

void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)

between two separate files is very worrying, and does indicate that
something is broken - there's no way that the compiler could 'optimize'
this by folding twl4030_power_init() into twl_probe() between the two
files.

In any case, here's my current (tested) patch unbreaking OMAP as a whole,
not only for all these section mismatches but the more fundamental issues
like the broken serial ports on OMAP3 and the irq domain buggeration too.

This leaves one section mismatch for me in the OMAP hotplug code.

 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c   |    2 ++
 arch/arm/mach-omap2/hsmmc.c         |    8 ++++----
 arch/arm/mach-omap2/mux.c           |   22 +++++++++++-----------
 arch/arm/mach-omap2/omap-headsmp.S  |    1 +
 arch/arm/mach-omap2/pm34xx.c        |    2 +-
 arch/arm/mach-omap2/prm44xx.c       |    1 +
 drivers/mfd/Kconfig                 |    2 +-
 drivers/mfd/twl-core.c              |    6 ++++--
 drivers/mfd/twl4030-power.c         |   20 ++++++++++----------
 10 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 39fba9d..0049587 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -808,7 +808,7 @@ static struct omap_dss_board_info sdp4430_dss_data = {
 	.default_device	= &sdp4430_lcd_device,
 };
 
-static void omap_4430sdp_display_init(void)
+static void __init omap_4430sdp_display_init(void)
 {
 	int r;
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..1e9256c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -259,6 +259,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx;
 	int ret;
 
+	{ new_state_idx = drv->safe_state_index; goto select_state; }
+
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index ad0adb5..b40c288 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -293,8 +293,8 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
-					struct omap_mmc_platform_data *mmc)
+static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
+				 struct omap_mmc_platform_data *mmc)
 {
 	char *hc_name;
 
@@ -430,7 +430,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
-void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
+void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -487,7 +487,7 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 	kfree(mmc_data);
 }
 
-void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index e1cc75d..fb8bc9f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -100,8 +100,8 @@ void omap_mux_write_array(struct omap_mux_partition *partition,
 
 static char *omap_mux_options;
 
-static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
-				      int gpio, int val)
+static int _omap_mux_init_gpio(struct omap_mux_partition *partition,
+			       int gpio, int val)
 {
 	struct omap_mux_entry *e;
 	struct omap_mux *gpio_mux = NULL;
@@ -145,7 +145,7 @@ static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
 	return 0;
 }
 
-int __init omap_mux_init_gpio(int gpio, int val)
+int omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_partition *partition;
 	int ret;
@@ -159,9 +159,9 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return -ENODEV;
 }
 
-static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
-					const char *muxname,
-					struct omap_mux **found_mux)
+static int _omap_mux_get_by_name(struct omap_mux_partition *partition,
+				 const char *muxname,
+				 struct omap_mux **found_mux)
 {
 	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
@@ -240,7 +240,7 @@ omap_mux_get_by_name(const char *muxname,
 	return -ENODEV;
 }
 
-int __init omap_mux_init_signal(const char *muxname, int val)
+int omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_partition *partition = NULL;
 	struct omap_mux *mux = NULL;
@@ -1094,8 +1094,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 		omap_mux_package_init_balls(package_balls, superset);
 }
 
-static void omap_mux_init_signals(struct omap_mux_partition *partition,
-				  struct omap_board_mux *board_mux)
+static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
+					 struct omap_board_mux *board_mux)
 {
 	omap_mux_set_cmdline_signals();
 	omap_mux_write_array(partition, board_mux);
@@ -1109,8 +1109,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 {
 }
 
-static void omap_mux_init_signals(struct omap_mux_partition *partition,
-				  struct omap_board_mux *board_mux)
+static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
+					 struct omap_board_mux *board_mux)
 {
 }
 
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index b13ef7e..503ac77 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -18,6 +18,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+	__CPUINIT
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b77df73..4b76c4c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -420,7 +420,7 @@ static void omap3_pm_idle(void)
 {
 	local_fiq_disable();
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || 1)
 		goto out;
 
 	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 33dd655..a1d6154 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -19,6 +19,7 @@
 
 #include "common.h"
 #include <plat/cpu.h>
+#include <plat/irqs.h>
 #include <plat/prcm.h>
 
 #include "vp.h"
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 28a301b..bd60ce0 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -200,7 +200,7 @@ config MENELAUS
 
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
-	depends on I2C=y && GENERIC_HARDIRQS && IRQ_DOMAIN
+	depends on I2C=y && GENERIC_HARDIRQS
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
 	  This core driver provides register access and IRQ handling
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e04e04d..8ce3959 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -263,7 +263,9 @@ struct twl_client {
 
 static struct twl_client twl_modules[TWL_NUM_SLAVES];
 
+#ifdef CONFIG_IRQ_DOMAIN
 static struct irq_domain domain;
+#endif
 
 /* mapping the module id to slave id and base address */
 struct twl_mapping {
@@ -1226,13 +1228,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	pdata->irq_base = status;
 	pdata->irq_end = pdata->irq_base + nr_irqs;
 
+#ifdef CONFIG_IRQ_DOMAIN
 	domain.irq_base = pdata->irq_base;
 	domain.nr_irq = nr_irqs;
-#ifdef CONFIG_OF_IRQ
 	domain.of_node = of_node_get(node);
 	domain.ops = &irq_domain_simple_ops;
-#endif
 	irq_domain_add(&domain);
+#endif
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d905f51..79ca33d 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -124,7 +124,7 @@ static u8 res_config_addrs[] = {
 	[RES_MAIN_REF]	= 0x94,
 };
 
-static int __init twl4030_write_script_byte(u8 address, u8 byte)
+static int __devinit twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
@@ -138,7 +138,7 @@ static int __init twl4030_write_script_byte(u8 address, u8 byte)
 	return err;
 }
 
-static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
+static int __devinit twl4030_write_script_ins(u8 address, u16 pmb_message,
 					   u8 delay, u8 next)
 {
 	int err;
@@ -158,7 +158,7 @@ static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
 	return err;
 }
 
-static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
+static int __devinit twl4030_write_script(u8 address, struct twl4030_ins *script,
 				       int len)
 {
 	int err;
@@ -183,7 +183,7 @@ static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
 	return err;
 }
 
-static int __init twl4030_config_wakeup3_sequence(u8 address)
+static int __devinit twl4030_config_wakeup3_sequence(u8 address)
 {
 	int err;
 	u8 data;
@@ -208,7 +208,7 @@ static int __init twl4030_config_wakeup3_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_wakeup12_sequence(u8 address)
+static int __devinit twl4030_config_wakeup12_sequence(u8 address)
 {
 	int err = 0;
 	u8 data;
@@ -262,7 +262,7 @@ static int __init twl4030_config_wakeup12_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_sleep_sequence(u8 address)
+static int __devinit twl4030_config_sleep_sequence(u8 address)
 {
 	int err;
 
@@ -276,7 +276,7 @@ static int __init twl4030_config_sleep_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_warmreset_sequence(u8 address)
+static int __devinit twl4030_config_warmreset_sequence(u8 address)
 {
 	int err;
 	u8 rd_data;
@@ -324,7 +324,7 @@ static int __init twl4030_config_warmreset_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
+static int __devinit twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 {
 	int rconfig_addr;
 	int err;
@@ -416,7 +416,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	return 0;
 }
 
-static int __init load_twl4030_script(struct twl4030_script *tscript,
+static int __devinit load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
@@ -527,7 +527,7 @@ void twl4030_power_off(void)
 		pr_err("TWL4030 Unable to power off\n");
 }
 
-void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
+void __devinit twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
 	int i;

