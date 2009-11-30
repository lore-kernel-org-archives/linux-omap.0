From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] AM3517: Add support for TSC2004 driver
Date: Mon, 30 Nov 2009 09:33:32 -0800
Message-ID: <20091130173331.GS4348@atomide.com>
References: <hvaibhav@ti.com>
 <1259212261-32528-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E739404370D7AEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54610 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbZK3Rdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 12:33:33 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404370D7AEB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [091125 21:13]:
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Thursday, November 26, 2009 10:41 AM
> > To: linux-omap@vger.kernel.org
> > Cc: tony@atomide.com; Hiremath, Vaibhav
> > Subject: [PATCH V2] AM3517: Add support for TSC2004 driver
> > 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > Changes:
> > 	- Removed omap_cfg_reg()
> > 
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-am3517evm.c |   61
> > +++++++++++++++++++++++++++++++++
> >  1 files changed, 61 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> > omap2/board-am3517evm.c
> > index 415a13d..b183d93 100644
> > --- a/arch/arm/mach-omap2/board-am3517evm.c
> > +++ b/arch/arm/mach-omap2/board-am3517evm.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/gpio.h>
> > +#include <linux/irq.h>
> > +#include <linux/i2c/tsc2004.h>
> > 
> >  #include <mach/hardware.h>
> >  #include <asm/mach-types.h>
> > @@ -27,10 +29,64 @@
> >  #include <asm/mach/map.h>
> > 
> >  #include <plat/board.h>
> > +#include <plat/mux.h>
> >  #include <plat/common.h>
> >  #include <plat/usb.h>
> > 
> >  /*
> > + * TSC 2004 Support
> > + */
> > +#define	GPIO_TSC2004_IRQ	65
> > +
> > +static int tsc2004_init_irq(void)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = gpio_request(GPIO_TSC2004_IRQ, "tsc2004-irq");
> > +	if (ret < 0) {
> > +		printk(KERN_WARNING "failed to request GPIO#%d: %d\n",
> > +				GPIO_TSC2004_IRQ, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (gpio_direction_input(GPIO_TSC2004_IRQ)) {
> > +		printk(KERN_WARNING "GPIO#%d cannot be configured as "
> > +				"input\n", GPIO_TSC2004_IRQ);
> > +		return -ENXIO;
> > +	}
> > +
> > +	omap_set_gpio_debounce(GPIO_TSC2004_IRQ, 1);
> > +	omap_set_gpio_debounce_time(GPIO_TSC2004_IRQ, 0xa);
> > +	return ret;
> > +}
> > +
> > +static void tsc2004_exit_irq(void)
> > +{
> > +	gpio_free(GPIO_TSC2004_IRQ);
> > +}
> > +
> > +static int tsc2004_get_irq_level(void)
> > +{
> > +	return gpio_get_value(GPIO_TSC2004_IRQ) ? 0 : 1;
> > +}
> > +
> > +struct tsc2004_platform_data am3517evm_tsc2004data = {
> > +	.model = 2004,
> > +	.x_plate_ohms = 180,
> > +	.get_pendown_state = tsc2004_get_irq_level,
> > +	.init_platform_hw = tsc2004_init_irq,
> > +	.exit_platform_hw = tsc2004_exit_irq,
> > +};
> > +
> > +static struct i2c_board_info __initdata
> > am3517evm_tsc_i2c_boardinfo[] = {
> > +	{
> > +		I2C_BOARD_INFO("tsc2004", 0x4B),
> > +		.type		= "tsc2004",
> > +		.platform_data	= &am3517evm_tsc2004data,
> > +	},
> > +};
> > +
> > +/*
> >   * Board initialization
> >   */
> >  static struct omap_board_config_kernel am3517_evm_config[]
> > __initdata = {
> > @@ -67,6 +123,11 @@ static void __init am3517_evm_init(void)
> > 
> >  	omap_serial_init();
> >  	usb_ehci_init(&ehci_pdata);
> > +
> > +	/* TSC 2004 */
> > +	am3517evm_tsc_i2c_boardinfo[0].irq =
> > gpio_to_irq(GPIO_TSC2004_IRQ);
> > +	i2c_register_board_info(1, am3517evm_tsc_i2c_boardinfo,
> > +				ARRAY_SIZE(am3517evm_tsc_i2c_boardinfo));
> >  }
> > 
> >  static void __init am3517_evm_map_io(void)
> [Hiremath, Vaibhav] Hi Tony,
> 
> Since I haven't received any comments on driver code it should get merged. But I am not sure what the procedure is for input subsystem drivers? Is it happens through linux-omap or linux-input?

I'd rather see it merged via linux-input as that's where most
of the code is. The platform init code looks OK to me to merge
via linux-input too.

Tony
