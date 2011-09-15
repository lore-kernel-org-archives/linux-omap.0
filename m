From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform
 device driver
Date: Thu, 15 Sep 2011 09:58:10 -0700
Message-ID: <20110915165810.GA2284@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
 <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
 <20110914214533.GA30941@atomide.com>
 <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17825 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751628Ab1IOQ6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 12:58:15 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

* Mohammed, Afzal <afzal@ti.com> [110915 01:13]:
> Hi Tony,
> 
> On Thu, Sep 15, 2011 at 11:12:53, DebBarma, Tarun Kanti wrote:
> > On Thu, Sep 15, 2011 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
> > >> removed from timer code. New set of timers present on
> > >> OMAP4 are now supported.
> > > Also, as we don't need the support for different register offsets for 
> > > the first two omap4 timers, please rather implement support for the 
> > > new timers and the timeouts directly in plat-omap/dmtimer.c.
> > >
> > > That way we can still keep the minimal timer support simple for 
> > > clocksource and clockevent. Of course this means that we'll be only 
> > > supporting the first two timers as system timers on omap4, but that's 
> > > fine.
> > Ok, I can make the change!
> > But, do we have to keep OMAP5 in mind right now where even timers[1,2] require addition of offsets?
> 
> We need clocksource & clockevent to be able to work with
> timers requiring addition of offsets. Without this AM335X,
> TI816X and TI814X SoC's will not boot.

OK. Then how about let's do the following things:

1. Modify the inline access functions to take the PEND and others
   if needed registers as a parameter

2. Modify mach-omap2/timer.c to initialize the PEND and others
   in the SoC specific timer_init function

3. Move all the non-minimal stuff into dmtimer.c as that will
   eventually be a device driver at some point

This way we can still share some of the inline access functions
and keep the system timer code minimal. Then the device driver
like features will be limited to dmtimer.c as that usage is more
complex with than with system timer.

Regards,

Tony
