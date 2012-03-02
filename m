From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] cbus: Fix lines for Nokia 770
Date: Thu, 1 Mar 2012 16:02:19 -0800
Message-ID: <20120302000219.GD18901@atomide.com>
References: <20120222220937.GM18185@atomide.com>
 <20120223084633.GB18463@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61392 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab2CBACV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 19:02:21 -0500
Content-Disposition: inline
In-Reply-To: <20120223084633.GB18463@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120223 00:15]:
> Hi,
> 
> On Wed, Feb 22, 2012 at 02:09:37PM -0800, Tony Lindgren wrote:
> > From 54c4785b8d274f8d282b4243945ae0b17edf4686 Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Wed, 22 Feb 2012 13:03:07 -0800
> > Subject: [PATCH] cbus: Fix lines for Nokia 770
> > 
> > This makes retu and tahvo work again on Nokia 770 so it
> > stays running.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > I applied this into cbus branch as it seems to fix retu
> > watchdog for Nokia 770.
> > 
> > --- a/arch/arm/mach-omap1/board-nokia770.c
> > +++ b/arch/arm/mach-omap1/board-nokia770.c
> > @@ -87,9 +87,9 @@ static struct platform_device nokia770_kp_device = {
> >  #if defined(CONFIG_CBUS) || defined(CONFIG_CBUS_MODULE)
> >  
> >  static struct cbus_host_platform_data nokia770_cbus_data = {
> > -	.clk_gpio	= OMAP_MPUIO(11),
> > +	.clk_gpio	= OMAP_MPUIO(9),
> >  	.dat_gpio	= OMAP_MPUIO(10),
> > -	.sel_gpio	= OMAP_MPUIO(9),
> > +	.sel_gpio	= OMAP_MPUIO(11),
> >  };
> >  
> >  static struct platform_device nokia770_cbus_device = {
> 
> Has this been wrong since the beginning ? Looking at commit d64193bd, I
> just moved whatever was on cbus.c to respective board-files.

Yes I think I dumped them from custom ATAGs quite a while ago,
but probably got them wrong way around at some point and have
been wondering ever since how come cbus does not seem to work
on 770 :)

Regards,

Tony
