From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] Put in supportframework for PR785 board.
Date: Thu, 4 Dec 2008 13:39:25 +0200
Message-ID: <20081204113925.GP10209@gandalf.research.nokia.com>
References: <1228386206-13513-1-git-send-email-mani.pillai@ti.com> <20081204111409.GM10209@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E90E7234@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23513 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbYLDLkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 06:40:04 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E7234@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 04, 2008 at 05:00:14PM +0530, ext Pillai, Manikandan wrote:
> Hi,
> 
> Pls find my comments inlined.
> 
> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> Sent: Thursday, December 04, 2008 4:44 PM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] Put in supportframework for PR785 board.
> 
> On Thu, Dec 04, 2008 at 03:53:26PM +0530, ext Manikandan Pillai wrote:
> > Resending this patch with fixes for comments:
> > This patch provides the support framework for PR785 boards.
> > More patches will follow that will allow complete programming
> > support for PR785 boards.
> > The board-omap3evm.c contains the I2C devices to be supported.
> > CONFIG_PR785 is configuration used for the PR785 boards. This patch
> > provides support for TPS6235x devices on PR785 through I2C2 bus.
> > Support for I2C2 or I2C4 and selection between them will be given in
> > subsequent patches.
> > 
> > The selection of TWL4030 or PR785 is for now through compile time
> > option since a real time check is not clear.
> > 
> > Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |   22 +++++++++++++++++++++-
> >  arch/arm/mach-omap2/mmc-twl4030.c    |    5 +++--
> >  drivers/mfd/Kconfig                  |   14 ++++++++++++++
> >  drivers/video/omap/lcd_omap3evm.c    |    4 ++++
> >  4 files changed, 42 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> > index 8a1b86e..22ac2e9 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -42,7 +42,6 @@
> >  #include "twl4030-generic-scripts.h"
> >  #include "mmc-twl4030.h"
> >  
> > -
> >  static struct resource omap3evm_smc911x_resources[] = {
> >  	[0] =	{
> >  		.start  = OMAP3EVM_ETHR_START,
> > @@ -90,6 +89,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
> >  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> >  };
> >  
> > +#if defined(CONFIG_TWL4030_CORE)
> >  static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
> >  	.gpio_base	= OMAP_MAX_GPIO_LINES,
> >  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
> > @@ -151,11 +151,31 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
> >  		.platform_data = &omap3evm_twldata,
> >  	},
> >  };
> > +#endif
> > +
> > +#if defined(CONFIG_PR785)
> > +static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
> > +	{
> > +		I2C_BOARD_INFO("tps62352", 0x4A),
> > +		.flags = I2C_CLIENT_WAKE,
> > +	},
> > +	{
> > +		I2C_BOARD_INFO("tps62353", 0x48),
> > +		.flags = I2C_CLIENT_WAKE,
> > +	},
> > +};
> > +#endif
> >  
> >  static int __init omap3_evm_i2c_init(void)
> >  {
> > +#if defined(CONFIG_PR785)
> > +	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
> > +		ARRAY_SIZE(tps_6235x_i2c_board_info));
> > +#endif
> > +#if defined(CONFIG_TWL4030_CORE)
> >  	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
> >  			ARRAY_SIZE(omap3evm_i2c_boardinfo));
> > +#endif
> >  	omap_register_i2c_bus(2, 400, NULL, 0);
> >  	omap_register_i2c_bus(3, 400, NULL, 0);
> >  	return 0;
> > diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> > index 626d668..daf10f3 100644
> > --- a/arch/arm/mach-omap2/mmc-twl4030.c
> > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> 
> it doesn't make sense to build this file if you don't have twl4030 in
> the board. Better to have something like mmc-tps6235x.c or something
> like that.
> [Pillai, Manikandan] This would be provided in a latter patch that provides support for MMC1. I have created another file mmc-pr785.c in this patch. I am
> currently testing and shall send it soon.
> 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 650b51c..3fee589 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -61,6 +61,8 @@ config UCB1400_CORE
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ucb1400_core.
> >  
> > +menu "Texas Instruments Power board Support"
> > +
> >  config TWL4030_CORE
> >  	bool "Texas Instruments TWL4030/TPS659x0 Support"
> >  	depends on I2C=y && GENERIC_HARDIRQS
> > @@ -84,6 +86,18 @@ config TWL4030_POWER
> >  	  oscillators are switched off or on or reset when a sleep, wakeup
> >  	  or warm reset event occurs.
> >  
> > +config PR785
> > +	bool "A Texas Instruments TPS6235X based Power Module"
> > +	depends on I2C=y && MACH_OMAP3EVM=y && GENERIC_GPIO && (ARCH_OMAP3)
> > +	default n
> > +	help
> > +	Say yes here if you are using the TPS6235x based PR785 Power Module
> > +	for the EVM boards. This core driver provides register access and IRQ
> > +	handling facilities, and registers devices for the various functions
> > +	so that function-specific drivers can bind to them.
> > +
> > +endmenu
> 
> where's the driver for it ??
> [Pillai, Manikandan] The PATCH 2/2 contains the driver file. This has only
> the framework

so the Kconfig for that driver should be together with the driver.

-- 
balbi
