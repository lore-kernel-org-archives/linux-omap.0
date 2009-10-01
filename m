From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Thu, 1 Oct 2009 09:34:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE8C41@dbde02.ent.ti.com>
References: <20090928190404.GE18957@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BADAC1AD@dbde02.ent.ti.com>
 <20090930175506.GO16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46059 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbZJAEEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 00:04:40 -0400
In-Reply-To: <20090930175506.GO16865@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, September 30, 2009 11:25 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
> please read
> 
> Hi,
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090929 03:54]:
> 
> <snip>
> 
> > Thanks for fixing the OMAP4 compilation issues. We need below patch to
> make the kernel boot on OMAP4430 on the latest LO master.
> 
> No problem. In the future, let's make sure the omap4 patches are merged
> into l-o master branch for testing. This time the first three patches
> in the omap-fixes branch were build breakage caused by the omap4 patches
> directly or indirectly..
Agree!! 
> Also, please everybody check that your patches don't break the build
> for other the omaps, and also boot test on some other omaps if someting
> looks risky.
> 
> Few comments below.
> 
> >
> > From d9a22d9f7b68b99aa9607bdab377d998dfe82acd Mon Sep 17 00:00:00 2001
> > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Date: Tue, 29 Sep 2009 16:10:46 +0530
> > Subject: [PATCH] ARM: OMAP4: Allow omap_serial_early_init() for OMAP4430
> board
> >
> > This patch enables omap_serial_early_init() function for OMAP4430
> > SDP. Without this the bootup would throw opps in omap_serial_init().
> 
> The opps probably should be oops above :)

YEP :)

> > Additionally the patch removed the merge issue for the UART4.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |    4 ++--
> >  arch/arm/mach-omap2/io.c            |    2 ++
> >  arch/arm/mach-omap2/serial.c        |   10 ----------
> >  3 files changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index eb37c40..609a5a4 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -58,6 +58,8 @@ static void __init gic_init_irq(void)
> >
> >  static void __init omap_4430sdp_init_irq(void)
> >  {
> > +	omap_board_config = sdp4430_config;
> > +	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
> >  	omap2_init_common_hw(NULL, NULL);
> >  #ifdef CONFIG_OMAP_32K_TIMER
> >  	omap2_gp_clockevent_set_gptimer(1);
> > @@ -70,8 +72,6 @@ static void __init omap_4430sdp_init_irq(void)
> >  static void __init omap_4430sdp_init(void)
> >  {
> >  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
> > -	omap_board_config = sdp4430_config;
> > -	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
> >  	omap_serial_init();
> >  }
> >
> > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > index e3a3bad..56be87d 100644
> > --- a/arch/arm/mach-omap2/io.c
> > +++ b/arch/arm/mach-omap2/io.c
> > @@ -302,7 +302,9 @@ void __init omap2_init_common_hw(struct
> omap_sdrc_params *sdrc_cs0,
> >  	pwrdm_init(powerdomains_omap);
> >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> >  	omap2_clk_init();
> > +#endif
> >  	omap_serial_early_init();
> > +#ifndef CONFIG_ARCH_OMAP4
> >  	omap_hwmod_late_init();
> >  	omap_pm_if_init();
> >  	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index ae21868..54dfeb5 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -109,16 +109,6 @@ static struct plat_serial8250_port
> serial_platform_data2[] = {
> >  		.regshift	= 2,
> >  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> >  	}, {
> > -#ifdef CONFIG_ARCH_OMAP4
> > -		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
> > -		.mapbase	= OMAP_UART4_BASE,
> > -		.irq		= 70,
> > -		.flags		= UPF_BOOT_AUTOCONF,
> > -		.iotype		= UPIO_MEM,
> > -		.regshift	= 2,
> > -		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> > -	}, {
> > -#endif
> >  		.flags		= 0
> >  	}
> >  };
> 
> Can't we fix the extra uart instead of removing it? We just added it!
> It's still there in omap4, right?
This is already fixed. Above piece is not necessary since there is a separate instance for UART4 (serial_platform_data3[])
Regards,
Santosh
