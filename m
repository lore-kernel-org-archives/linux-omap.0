From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] omap2/3/4: serial: Half revert multiboot changes
Date: Wed, 24 Feb 2010 21:07:35 -0600
Message-ID: <A24693684029E5489D1D202277BE89445398E44D@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944538C6D68@dlee02.ent.ti.com>
 <A24693684029E5489D1D202277BE8944538C6D6A@dlee02.ent.ti.com>
 <20100224162129.GO28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab0BYDHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 22:07:35 -0500
In-Reply-To: <20100224162129.GO28173@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 24, 2010 10:21 AM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; Pandita, Vikram
> Subject: Re: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> 
> * Aguirre, Sergio <saaguirre@ti.com> [100223 23:37]:
> > Hmm..
> >
> > I think I sent this patch too soon...
> >
> > Please ignore it, this is not a proper solution I feel..
> >
> > But what it is true... is that, patch "omap2/3/4: Fix mach-
> omap2/serial.c for multiboot" is definitely breaking Zoom3 boot, and needs
> to be fixed.
> 
> Yes sounds like only zoom has the external uart, other 3630
> boards may be using the internal uart4.

Actually, I don't see any patch to handle uart4 interface/functional clocks, so I assume the addition of uart4 for 3630 chip is incomplete.

Shall we apply my 2nd patch, until proper clock handling is in place?

I don't have an omap4 to test, but I think my patch shouldn't hurt the initial intention to make multiomap builds possible... agree?

> 
> > I'll try to come up with a better patch.
> 
> You can call omap_serial_init_port() for each port from
> board-zoom3.c instead of calling omap_serial_init().

Perhaphs it would be a good idea to specify in the boardfile somehow how many UART ports we want to enable.

The boards may not even have physical access for those ports, and if they do, they need to do proper muxing before initializing them.

Regards,
Sergio

> 
> See commit
> 
> Regards,
> 
> Tony
> 
> 
> > Regards,
> > Sergio
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
> > > Sent: Wednesday, February 24, 2010 1:31 AM
> > > To: Tony Lindgren
> > > Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; Pandita, Vikram
> > > Subject: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> > >
> > > From 14bc4ee14ac5a3dab79d9292bf22ab0401879cd5 Mon Sep 17 00:00:00 2001
> > > From: Sergio Aguirre <saaguirre@ti.com>
> > > Date: Wed, 24 Feb 2010 01:15:55 -0600
> > > Subject: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> > >
> > > The patch named:
> > >   "omap2/3/4: Fix mach-omap2/serial.c for multiboot"
> > >
> > > Which added UART4 init also for 36xx based boards, broke zoom3
> > > booting. External UART must be correctly initialized already
> > > by board-zoom-debugboard.c file, therefore the addition on UART4
> > > initialization can't be done blindly (i.e. board agnostic)
> > >
> > > This patch removes the 36xx uart4 init for the above reason.
> > >
> > > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/serial.c |   10 ++--------
> > >  1 files changed, 2 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-
> omap2/serial.c
> > > index b79bc89..fe3122b 100644
> > > --- a/arch/arm/mach-omap2/serial.c
> > > +++ b/arch/arm/mach-omap2/serial.c
> > > @@ -115,7 +115,6 @@ static struct plat_serial8250_port
> > > serial_platform_data2[] = {
> > >  	}
> > >  };
> > >
> > > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> > >  static struct plat_serial8250_port serial_platform_data3[] = {
> > >  	{
> > >  		.irq		= 70,
> > > @@ -132,11 +131,6 @@ static inline void omap2_set_globals_uart4(struct
> > > omap_globals *omap2_globals)
> > >  {
> > >  	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
> > >  }
> > > -#else
> > > -static inline void omap2_set_globals_uart4(struct omap_globals
> > > *omap2_globals)
> > > -{
> > > -}
> > > -#endif
> > >
> > >  void __init omap2_set_globals_uart(struct omap_globals
> *omap2_globals)
> > >  {
> > > @@ -597,7 +591,7 @@ static struct omap_uart_state omap_uart[] = {
> > >  			},
> > >  		},
> > >  	},
> > > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> > > +#ifdef CONFIG_ARCH_OMAP4
> > >  	{
> > >  		.pdev = {
> > >  			.name			= "serial8250",
> > > @@ -764,7 +758,7 @@ void __init omap_serial_init(void)
> > >  {
> > >  	int i, nr_ports;
> > >
> > > -	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
> > > +	if (!cpu_is_omap4430())
> > >  		nr_ports = 3;
> > >  	else
> > >  		nr_ports = ARRAY_SIZE(omap_uart);
> > > --
> > > 1.6.3.3
> >
