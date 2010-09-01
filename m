From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
Date: Wed, 1 Sep 2010 14:50:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD32E@dbde02.ent.ti.com>
References: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com>
 <87tymkq38r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab0IAJVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 05:21:04 -0400
In-Reply-To: <87tymkq38r.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 5:41 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha; Nayak,
> Rajendra; Paul Walmsley; Tony Lindgren
> Subject: Re: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > +/**
> > +* omap2_dm_timer_early_init - top level early timer initialization
> > +* called in the last part of omap2_init_common_hw
> > +*
> > +* uses dedicated hwmod api to parse through hwmod database for
> > +* given class name and then build and register the timer device.
> > +* at the end driver is registered and early probe initiated.
> > +**/
> > +void __init omap2_dm_timer_early_init(void)
> > +{
> > +	omap_hwmod_for_each_by_class("timer_1ms",
> > +				omap_dm_timer_early_init, NULL);
> > +	omap2_dm_timer_setup();
> > +	early_platform_driver_register_all("earlytimer");
> > +	early_platform_driver_probe("earlytimer", early_timer_count + 1, 0);
> > +}
> 
> It's not clear (or documented) why on the 1ms timers should be the only
> earlydevices.
> 
> For example, GPT12 is used as the system timer on Beagle due to a board
> bug in early revs of the board.  That will no longer function with this
> approach.
>
OK, I will change the design so that any timers could be used as early timers.
 
> Kevin
> 

