From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: DMTIMER: enable autoidle mode
Date: Fri, 1 Jul 2011 00:26:10 -0700
Message-ID: <20110701072610.GD23145@atomide.com>
References: <1308172355-1694-1-git-send-email-ambresh@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC19E@dbde02.ent.ti.com>
 <BANLkTinSJkAkq40uJW2qd63yAYJ6f8DrFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58521 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754918Ab1GAH0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:26:12 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinSJkAkq40uJW2qd63yAYJ6f8DrFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Ambresh" <ambresh@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

* K, Ambresh <ambresh@ti.com> [110615 21:41]:
> On Wed, Jun 15, 2011 at 9:39 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com>wrote:
> > >
> > > Currently autoidle is only enabled for OMAP2/3; by enabling autoidle,
> > > the automatic L4 clock gating strategy is applied based on L4 activity,
> > > otherwise L4 clock to module will be a free running.

Applying this into devel-fixes.

> > > -     /* Enable autoidle on OMAP2 / OMAP3 */
> > > -     if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > > +     /* Enable autoidle on OMAP2 CPUs. */
> > > +     if (cpu_class_is_omap2())
> > >               l |= 0x1 << 0;
> > BTW, in the hwmod adaptation series this is taken care by the framework.
> >
> 
> Ok!

That should be a trivial update. Let's first merge this fix so L4 can
autoidle on omap4.

Tony
