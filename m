From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
Date: Wed, 15 Sep 2010 09:11:26 -0700
Message-ID: <20100915161126.GS8647@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com>
 <20100914190314.GH8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
 <20100914202743.GK8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55794 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab0IOQLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 12:11:43 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 23:03]:
> > 
> > Sounds like you're having these problems anyways and they
> > are not related to the defconfigs?
> > 
> Well the issues are because of defconfig but mostly fixable.
> Will hold on my comments till I test the new defconfig on OMAP4.

OK
 
> > Considering Linus' earlier comments on the defconfigs, I don't
> > see any reasonds not to merge this patch. If TI wants to fix up
> > some other things, there's still about two weeks before -rc6.
> >
> Sure. I am just saying let's attempt to fix the remaining issues
> and if it doesn't happen in next week, anyway this patch will
> get merged.

OK let's plan on doing that.
  
> > > > - LOCAL_TIMERS hangs on omap4, disable it for now.
> > >
> > > This is expected on omap4 ES1.0 and hence not enabled
> > > in the omap_4430sdp_defconfig.
> > 
> > Maybe add a check for ES1.0 there to the init then?
> > 
> Yes but its ARM generic code and I don't want to pollute it
> with omap checks.. Will see if some other trick can fix this.

Maybe in smp_twd.c return from twd_timer_setup early if twd_base
is NULL?

Regards,

Tony
