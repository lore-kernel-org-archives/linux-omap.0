From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Thu, 03 Jun 2010 11:58:25 -0700
Message-ID: <87aarcq6y6.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<1274194260-16401-2-git-send-email-charu@ti.com>
	<1274194260-16401-3-git-send-email-charu@ti.com>
	<1274194260-16401-4-git-send-email-charu@ti.com>
	<1274194260-16401-5-git-send-email-charu@ti.com>
	<1274194260-16401-6-git-send-email-charu@ti.com>
	<1274194260-16401-7-git-send-email-charu@ti.com>
	<1274194260-16401-8-git-send-email-charu@ti.com>
	<1274194260-16401-9-git-send-email-charu@ti.com>
	<1274194260-16401-10-git-send-email-charu@ti.com>
	<1274194260-16401-11-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35670 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0FCS6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:58:31 -0400
Received: by pvg16 with SMTP id 16so208230pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:58:29 -0700 (PDT)
In-Reply-To: <1274194260-16401-11-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 18 May 2010 20\:20\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This patch implements GPIO as a platform device. Also it
> implements OMAP2PLUS specific GPIO as HWMOD FW adapted device.
>
> GPIO APIs are used in machine_init functions. Hence it is
> required to complete GPIO probe before machine_init. Therefore
> GPIO device register and driver register are implemented as
> postcore_initcalls.
>
> Inorder to convert GPIO as platform device, modifications are
> required in clockxxxx_data.c files so that device names can be
> used to obtain clock instead of getting clocks by name/NULL ptr.
>
> GPIO driver uses runtime APIs.Clock FW APIs are used to enable
> iclk and fclk when CONFIG_PM_RUNTIME is not defined.

Something to discuss, and is not specific to your patch...

I handled the #ifndef CONFIG_PM_RUNTIME case as well when I did MMC,
but I'm starting to second guess that.

Rather, I think what we should do is leave the handling of that out of
the driver and instead just enable all hwmods at boot time if runtime
PM is enabled.

> omap_gpio_init() does nothing now and this function would be
> removed in the next patch as it's usage is spread across most of
> the board files.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Also, one other general comment.  In the driver, you should use
dev_dbg() and dev_err() instead of pr_dbg() and pr_err().  Using these
will include the device name and be more useful.

> ---
>  arch/arm/mach-omap1/Makefile         |    6 +
>  arch/arm/mach-omap1/clock_data.c     |    2 +-
>  arch/arm/mach-omap2/Makefile         |    2 +-
>  arch/arm/mach-omap2/clock2420_data.c |   10 +-
>  arch/arm/mach-omap2/clock2430_data.c |   14 +-
>  arch/arm/mach-omap2/clock3xxx_data.c |   24 +-
>  arch/arm/mach-omap2/clock44xx_data.c |   24 +-
>  arch/arm/plat-omap/gpio.c            |  389 +++++++++++-----------------------
>  8 files changed, 178 insertions(+), 293 deletions(-)

small(er) is beautiful.   I like the look of that diffstat. :)

>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index b6a537c..dabd2be 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -45,6 +45,12 @@ ifeq ($(CONFIG_ARCH_OMAP15XX),y)
>  obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= fpga.o
>  endif
>  
> +# GPIO
> +obj-$(CONFIG_ARCH_OMAP730)		+= gpio7xx.o
> +obj-$(CONFIG_ARCH_OMAP850)		+= gpio7xx.o
> +obj-$(CONFIG_ARCH_OMAP15XX)		+= gpio15xx.o
> +obj-$(CONFIG_ARCH_OMAP16XX)		+= gpio16xx.o
> +
>  # LEDs support
>  led-$(CONFIG_MACH_OMAP_H2)		+= leds-h2p2-debug.o
>  led-$(CONFIG_MACH_OMAP_H3)		+= leds-h2p2-debug.o
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> index aa8558a..9bc2aa1 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -589,7 +589,7 @@ static struct omap_clk omap_clks[] = {
>  	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
>  	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
>  	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
> -	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
> +	CLK("omap-gpio.0", "arm_gpio_ck", &arm_gpio_ck,	CK_1510 | CK_310),

This doesn't look right for OMAP1.  With a device name, you should
just drop the "arm_cpio_ck" part, so you can do a clk_get(dev, NULL).

>  	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
>  	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
>  	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 58a0474..d2d63ca 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o gpio.o
>  
>  omap-2-3-common				= irq.o sdrc.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index d932b14..a693403 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1802,8 +1802,14 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
>  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
>  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
> -	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
> -	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
> +	CLK("omap-gpio.0",	"ick",	&gpios_ick,	CK_242X),
> +	CLK("omap-gpio.1",	"ick",	&gpios_ick,	CK_242X),
> +	CLK("omap-gpio.2",	"ick",	&gpios_ick,	CK_242X),
> +	CLK("omap-gpio.3",	"ick",	&gpios_ick,	CK_242X),
> +	CLK("omap-gpio.0",	"fck",	&gpios_fck,	CK_242X),
> +	CLK("omap-gpio.1",	"fck",	&gpios_fck,	CK_242X),
> +	CLK("omap-gpio.2",	"fck",	&gpios_fck,	CK_242X),
> +	CLK("omap-gpio.3",	"fck",	&gpios_fck,	CK_242X),
>  	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
>  	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
>  	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
> diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
> index 0438b6e..56bbcbc 100644
> --- a/arch/arm/mach-omap2/clock2430_data.c
> +++ b/arch/arm/mach-omap2/clock2430_data.c
> @@ -1896,8 +1896,14 @@ static struct omap_clk omap2430_clks[] = {
>  	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X),
>  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X),
>  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X),
> -	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X),
> -	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
> +	CLK("omap-gpio.0",	"ick",	&gpios_ick,	CK_243X),
> +	CLK("omap-gpio.1",	"ick",	&gpios_ick,	CK_243X),
> +	CLK("omap-gpio.2",	"ick",	&gpios_ick,	CK_243X),
> +	CLK("omap-gpio.3",	"ick",	&gpios_ick,	CK_243X),
> +	CLK("omap-gpio.0",	"fck",	&gpios_fck,	CK_243X),
> +	CLK("omap-gpio.1",	"fck",	&gpios_fck,	CK_243X),
> +	CLK("omap-gpio.2",	"fck",	&gpios_fck,	CK_243X),
> +	CLK("omap-gpio.3",	"fck",	&gpios_fck,	CK_243X),
>  	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
>  	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
>  	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
> @@ -1934,8 +1940,8 @@ static struct omap_clk omap2430_clks[] = {
>  	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
>  	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
>  	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
> -	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
> -	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
> +	CLK("omap-gpio.4",	"ick",	&gpio5_ick,	CK_243X),
> +	CLK("omap-gpio.4",	"fck",	&gpio5_fck,	CK_243X),
>  	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
>  	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
>  	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 9cba556..3962234 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3407,13 +3407,13 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
>  	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
>  	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
> -	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
> +	CLK("omap-gpio.0",	"dbck",	&gpio1_dbck,	CK_3XXX),
>  	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
>  	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
>  	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
>  	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
>  	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
> +	CLK("omap-gpio.0",	"ick",	&gpio1_ick,	CK_3XXX),
>  	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
>  	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
>  	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
> @@ -3429,18 +3429,18 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
>  	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
> -	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
> -	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
> -	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_3XXX),
> -	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_3XXX),
> -	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_3XXX),
> +	CLK("omap-gpio.5",	"dbck",	&gpio6_dbck,	CK_3XXX),
> +	CLK("omap-gpio.4",	"dbck",	&gpio5_dbck,	CK_3XXX),
> +	CLK("omap-gpio.3",	"dbck",	&gpio4_dbck,	CK_3XXX),
> +	CLK("omap-gpio.2",	"dbck",	&gpio3_dbck,	CK_3XXX),
> +	CLK("omap-gpio.1",	"dbck",	&gpio2_dbck,	CK_3XXX),
>  	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_3XXX),
>  	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_3XXX),
> -	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
> +	CLK("omap-gpio.5",	"ick",	&gpio6_ick,	CK_3XXX),
> +	CLK("omap-gpio.4",	"ick",	&gpio5_ick,	CK_3XXX),
> +	CLK("omap-gpio.3",	"ick",	&gpio4_ick,	CK_3XXX),
> +	CLK("omap-gpio.2",	"ick",	&gpio3_ick,	CK_3XXX),
> +	CLK("omap-gpio.1",	"ick",	&gpio2_ick,	CK_3XXX),
>  	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
>  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
>  	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index a5c0c9c..4d76598 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2566,12 +2566,12 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
>  	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
>  	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
> -	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
> -	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
> -	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
> -	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
> -	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
> -	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
> +	CLK("omap-gpio.0",	"ick",			&gpio1_ick,	CK_443X),
> +	CLK("omap-gpio.1",	"ick",			&gpio2_ick,	CK_443X),
> +	CLK("omap-gpio.2",	"ick",			&gpio3_ick,	CK_443X),
> +	CLK("omap-gpio.3",	"ick",			&gpio4_ick,	CK_443X),
> +	CLK("omap-gpio.4",	"ick",			&gpio5_ick,	CK_443X),
> +	CLK("omap-gpio.5",	"ick",			&gpio6_ick,	CK_443X),
>  	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
>  	CLK(NULL,	"gpt1_fck",			&gpt1_fck,	CK_443X),
>  	CLK(NULL,	"gpt10_fck",			&gpt10_fck,	CK_443X),
> @@ -2645,12 +2645,12 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
>  	CLK(NULL,	"utmi_p1_gfclk_ck",		&utmi_p1_gfclk_ck,	CK_443X),
>  	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
> -	CLK(NULL,	"gpio1_dbck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpio2_dbck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpio3_dbck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpio4_dbck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpio5_dbck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpio6_dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.0",	"dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.1",	"dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.2",	"dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.3",	"dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.4",	"dbck",			&dummy_ck,	CK_443X),
> +	CLK("omap-gpio.5",	"dbck",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 70deebc..55a5796 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -21,6 +21,8 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> @@ -147,102 +149,11 @@ struct gpio_bank {
>  	struct gpio_chip chip;
>  	struct clk *dbck;
>  	u32 mod_usage;
> +	struct device *dev;
> +	bool dbck_flag;

I don't really see a need for this flag.  A failing clk_get() for a
debounce clock should indicate that the bank does not have/support a
debounce clock.  After that, a non-null bank->dbclk will be an
indicator.

Kevin
