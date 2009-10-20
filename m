From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH] [RFC] OMAP: eliminate OMAP_MAX_NR_PORTS
Date: Tue, 20 Oct 2009 16:01:31 -0700
Message-ID: <20091020230131.GB16230@atomide.com>
References: <1254995997-26420-1-git-send-email-virtuoso@slind.org> <notify-1255128339@atomide.com> <20091020233115.GA7363@localhost.localdomain> <20091020221543.GL12576@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbZJTXBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 19:01:31 -0400
Content-Disposition: inline
In-Reply-To: <20091020221543.GL12576@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>, Kevin Hilman <khilman@deeprootsystems.com>

* Tony Lindgren <tony@atomide.com> [091020 15:15]:
> * Ladislav.Michl@seznam.cz <Ladislav.Michl@seznam.cz> [091020 14:53]:
> > On Fri, Oct 09, 2009 at 06:46:23PM -0400, Tony Lindgren wrote:
> > > This patch has been applied to the linux-omap
> > > by youw fwiendly patch wobot.
> > > 
> > > Branch in linux-omap: omap2-upstream
> > > 
> > > Initial commit ID (Likely to change): 439d2c69335a28ffdb5a9795ff384b6755ca0f7f
> > > 
> > > PatchWorks
> > > http://patchwork.kernel.org/patch/52477/
> > > 
> > > Git (Likely to change, and takes a while to get mirrored)
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=439d2c69335a28ffdb5a9795ff384b6755ca0f7f
> > 
> > This patch broke all OMAP1 boards. NULL terminator entry for omap1
> > serial_platform_data cannot be removed just because serial driver uses
> > is as last entry marker. Without it we end this way:
> > Unable to handle kernel NULL pointer dereference at virtual address 00000028
> > pgd = c0004000
> > [00000028] *pgd=00000000
> > Internal error: Oops: 80000005 [#1]
> > last sysfs file:
> > Modules linked in:
> > CPU: 0    Not tainted  (2.6.32-rc5-06314-g4155da6-dirty #12)
> > PC is at 0x28
> > LR is at serial8250_config_port+0x184/0xc34
> > (...etc...)
> > 
> > Please consider following fix (and while there fix OMAP2 too as patch broke
> > it as well (untested))
> 
> Thanks, I already refreshed the original patch with the same fix few
> days ago :) It should be there in for-next branch and master branch.

Correction, sorry looks like I did not really read your patch. It seems
to be the right solution for mach-omap1, but not needed for mach-omap2
because the array is not plat_serial8250_port on mach-omap2.
 
> Tony
>  
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > 
> > diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
> > index 9c59332..0392ff5 100644
> > --- a/arch/arm/mach-omap1/serial.c
> > +++ b/arch/arm/mach-omap1/serial.c
> > @@ -86,7 +86,9 @@ static struct plat_serial8250_port serial_platform_data[] = {
> >  		.iotype		= UPIO_MEM,
> >  		.regshift	= 2,
> >  		.uartclk	= OMAP16XX_BASE_BAUD * 16,
> > -	},
> > +	}, {
> > +	}
> > +
> >  };
> >  
> >  static struct platform_device serial_device = {
> > @@ -119,7 +121,7 @@ void __init omap_serial_init(void)
> >  		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
> >  	}
> >  
> > -	for (i = 0; i < ARRAY_SIZE(serial_platform_data); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(serial_platform_data) - 1; i++) {
> >  		unsigned char reg;
> >  
> >  		/* Static mapping, never released */
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index dabc089..ca69ffa 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -585,7 +585,7 @@ void __init omap_serial_early_init(void)
> >  	 * if not needed.
> >  	 */
> >  
> > -	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(omap_uart) - 1; i++) {
> >  		struct omap_uart_state *uart = &omap_uart[i];
> >  		struct platform_device *pdev = &uart->pdev;
> >  		struct device *dev = &pdev->dev;
> > @@ -637,7 +637,7 @@ void __init omap_serial_init(void)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(omap_uart) - 1; i++) {
> >  		struct omap_uart_state *uart = &omap_uart[i];
> >  		struct platform_device *pdev = &uart->pdev;
> >  		struct device *dev = &pdev->dev;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
