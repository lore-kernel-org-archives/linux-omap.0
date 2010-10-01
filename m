From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
Date: Fri, 1 Oct 2010 16:25:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010011623020.22941@utopia.booyaka.com>
References: <1285059116-26366-1-git-send-email-tarun.kanti@ti.com> <4CA4FC22.9030806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51449 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0JAWZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 18:25:46 -0400
In-Reply-To: <4CA4FC22.9030806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On Thu, 30 Sep 2010, Cousson, Benoit wrote:

> On 9/21/2010 10:51 AM, DebBarma, Tarun Kanti wrote:
> 
> >   #include "omap_hwmod_common_data.h"
> > 
> >   #include "prm-regbits-24xx.h"
> > @@ -121,6 +123,614 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> >          .flags          = HWMOD_NO_IDLEST,
> >   };
> > +/* Timer Common */
> > +static char *timer_clk_src_names[] = {
> > +       "sys_ck",
> > +       "func_32k_ck",
> > +       "alt_ck",
> > +       NULL,
> > +};
> 
> I have an issue with that, because this is a pure duplication of the clock_sel
> information already contained in the clock data:
> 
> static const struct clksel omap24xx_gpt_clksel[] = {
>         { .parent = &func_32k_ck, .rates = gpt_32k_rates },
> 	{ .parent = &sys_ck,      .rates = gpt_sys_rates },
>       	{ .parent = &alt_ck,      .rates = gpt_alt_rates },
> 	{ .parent = NULL },
> };
> 
> And duplicating the same information somewhere else is most of the time a bad
> idea.

Yep, there's no way that info should be in the hwmod data, in the current 
setup.  It belongs in the clkdev tables.  Example below.

> That being said... I don't really know how to handle that properly :-)
> 
> We have to find a better way to select the proper source clock in a soc
> independent way.
> 
> Maybe Paul will have some idea?

Here's how it's done:

   http://marc.info/?l=linux-omap&m=128596931017785&w=2

and

   http://marc.info/?l=linux-omap&m=128596931417805&w=2



- Paul
