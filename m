From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Mon, 7 Mar 2011 18:24:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A360AD0@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
 <20110304172320.GY20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AB@dbde02.ent.ti.com>
 <20110304193706.GF20560@atomide.com>
 <8580fc0ccffe9e8da3c13fd89ba1c9df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1CGMzD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 07:55:03 -0500
In-Reply-To: <8580fc0ccffe9e8da3c13fd89ba1c9df@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony, Santosh,
[...]
> > > > > +void __init omap2_dm_timer_early_init(void)
> > > > > +{
> > > > > +	int ret = omap_hwmod_for_each_by_class("timer",
> > > > > +			omap_timer_init, NULL);
> > > >
> > > > Here we really only want to initialize the system timer. The
> > rest we
> > > > want to do later, so let's not init all of them early.
> > > So, that is how it was at the beginning.
> > > Later we realized different platforms can use different timers for
> > this.
> > > For example, beagle uses GPT12. Therefore, as part of one of the
> > comments,
> > > We decided to provide flexibility so that any of the timers could
> > be used.
> >
> > You can still do it, just register the one that's being used and
> > mark it reserved so it won't get initialized again later on.
> >
> 
> I agree with Tony. We can still registers only the system
> timer because the timer ID is known well before we do
> initialization.
I must say, there was a gap in my understanding of the comment.
So, here is the implementation change:

-> Call omap2_dm_timer_early_init(u8 gptimer_id) from omap2_gp_timer_init()
-> Initialize only gptimer_id inside this function
-> In the regular init skip initialization of gptimer_id

As a result of this, we can rid of double registration and related code.
--
Tarun
