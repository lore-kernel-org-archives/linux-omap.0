From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
Date: Sat, 9 Oct 2010 20:28:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E840680@dbde02.ent.ti.com>
References: <1285059116-26366-1-git-send-email-tarun.kanti@ti.com>
 <4CA4FC22.9030806@ti.com>
 <alpine.DEB.2.00.1010011623020.22941@utopia.booyaka.com>
 <4CA98739.9040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab0JIO7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 10:59:00 -0400
In-Reply-To: <4CA98739.9040309@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Benoit, Paul,

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Monday, October 04, 2010 1:20 PM
> To: Paul Walmsley
> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org; Gopinath, Thara;
> Basak, Partha; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
> 
> Hi Paul,
> 
> On 10/2/2010 12:25 AM, Paul Walmsley wrote:
> > On Thu, 30 Sep 2010, Cousson, Benoit wrote:
> >
> >> On 9/21/2010 10:51 AM, DebBarma, Tarun Kanti wrote:
> >>
> >>>    #include "omap_hwmod_common_data.h"
> >>>
> >>>    #include "prm-regbits-24xx.h"
> >>> @@ -121,6 +123,614 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod
> = {
> >>>           .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> >>>           .flags          = HWMOD_NO_IDLEST,
> >>>    };
> >>> +/* Timer Common */
> >>> +static char *timer_clk_src_names[] = {
> >>> +       "sys_ck",
> >>> +       "func_32k_ck",
> >>> +       "alt_ck",
> >>> +       NULL,
> >>> +};
> >>
> >> I have an issue with that, because this is a pure duplication of the
> clock_sel
> >> information already contained in the clock data:
> >>
> >> static const struct clksel omap24xx_gpt_clksel[] = {
> >>          { .parent =&func_32k_ck, .rates = gpt_32k_rates },
> >> 	{ .parent =&sys_ck,      .rates = gpt_sys_rates },
> >>        	{ .parent =&alt_ck,      .rates = gpt_alt_rates },
> >> 	{ .parent = NULL },
> >> };
> >>
> >> And duplicating the same information somewhere else is most of the time
> a bad
> >> idea.
> >
> > Yep, there's no way that info should be in the hwmod data, in the
> current
> > setup.  It belongs in the clkdev tables.  Example below.
> >
> >> That being said... I don't really know how to handle that properly :-)
> >>
> >> We have to find a better way to select the proper source clock in a soc
> >> independent way.
> >>
> >> Maybe Paul will have some idea?
> >
> > Here's how it's done:
> >
> >     http://marc.info/?l=linux-omap&m=128596931017785&w=2
> >
> > and
> >
> >     http://marc.info/?l=linux-omap&m=128596931417805&w=2
> 
> The famous clock alias... I don't know why but I always forgot that
> solution each time I have such concern:-(
> This is indeed the very clean and cool way to do that clock selection.
> We can even remove this #define to identified them and use the clock
> string name directly.
> 

I will incorporate the suggestions. Thanks!!

-tarun
