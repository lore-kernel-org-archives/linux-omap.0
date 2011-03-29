From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Tue, 29 Mar 2011 10:13:45 -0700
Message-ID: <20110329171345.GH4016@atomide.com>
References: <87d3lx5hoo.fsf@ti.com>
 <20110314171240.GB7258@atomide.com>
 <8762rhtnje.fsf@ti.com>
 <20110319002719.GF18583@atomide.com>
 <b65bf7960033964fba8f03e774b46905@mail.gmail.com>
 <20110321170758.GF2811@atomide.com>
 <87sjuge31n.fsf@ti.com>
 <20110321191114.GH2811@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A7E21D7@dbde02.ent.ti.com>
 <20110325155549.GZ2811@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:13:48 -0400
Content-Disposition: inline
In-Reply-To: <20110325155549.GZ2811@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* Tony Lindgren <tony@atomide.com> [110325 08:54]:
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110324 23:53]:
> > Hi Tony,
> > [...]
> > > Well the dmtimer code can then become just a regular platform_device
> > > based driver, except for clockevent and clocksource on omap2 & 3.
> > Should I re-post the patch series with removal of duplicate initialization
> > Which Kevin pointed out + other relevant comments?
> > Or, wait for your patch series!
> 
> Just wait few days please, I should have something available that mostly
> deals with timer-gp.c, so it should not cause too many issues with your
> patches.

FYI, posted some patches in the "omap init_early changes for irq and
timer init" thread, also available in devel-timer branch. Few notes
regarding updating your dmtimer series:

- Add the dmtimer arch_initcall into arch/arm/mach-omap2/timer.c so
  we don't end up with yet another timer*.c file there

- Make use of omap_dm_timer_init_one in the dmtimer arch_initcall so
  sys_timer initialized struct omap_dm_timer can be picked up

- You can pick the reserved clockevent and clocksource timers based
  on the sys_timer_reserved mask and then create proper dev entries
  for those too later on during the init

- Now arch/arm/plat-omap/dmtimer.c can become just a driver module
  living under drivers somewhere

Other than that, your patches should be pretty easy to rebase.

Regards,

Tony
