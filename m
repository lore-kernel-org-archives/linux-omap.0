From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Thu, 8 May 2014 11:40:56 -0700
Message-ID: <20140508184055.GC2198@atomide.com>
References: <536B7E44.2040303@ti.com>
 <7hppjos2w2.fsf@paris.lan>
 <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
 <20140508165558.GB2198@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52650 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbaEHSlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 14:41:04 -0400
Content-Disposition: inline
In-Reply-To: <20140508165558.GB2198@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Added few cpuidle people to Cc on this regression.

* Tony Lindgren <tony@atomide.com> [140508 09:57]:
> * Kevin Hilman <khilman@linaro.org> [140508 08:40]:
> > On Thu, May 8, 2014 at 8:31 AM, Kevin Hilman <khilman@linaro.org> wrote:
> > > Roger Quadros <rogerq@ti.com> writes:
> > >
> > >> Hi,
> > >>
> > >> Nishant pointed me to a booting issue with omap4-panda-es on linux-next but I'm observing
> > >> similar issues, although less frequent, with v3.15-rc4 as well.
> > >>
> > >> Configuration:
> > >>
> > >> - kernel v3.15-rc4 or linux-next (20140507)
> > >> - multi_v7_defconfig with LEDS_TRIGGER_HEARTBEAT and LEDS_GPIO enabled
> > >> - u-boot/master       173d294b94cf
> > >>
> > >> Observations:
> > >>
> > >> - Out of 10 boots a few may not succeed and hang midway without any warnings. Heartbeat LED stops.
> > >> e.g. http://www.hastebin.com/ebumojegoq.vhdl
> > >>
> > >> - Hang more noticeable on linux-next (20140507) than on v3.15-rc4
> > >
> > > I've beeen noticing the same thing for awhile with my boot tests.  For
> > > me, next-20140508 is failing most of the time now.
> > >
> > >> - Hang more noticeable with USB_EHCI_HCD enabled but hang observed even without USB_EHCI_HCD.
> > >> Maybe related to when high speed interrupts occur in the boot process.
> > >>
> > >> - On successful boots following warning is seen
> > >> [    4.010375] gic_timer_retrigger: lost localtimer interrupt
> > >>
> > >> - On successful boots heartbeat LED stops blinking after boot process and left idle. LED can remain stuck in
> > >> ON state as well. It does blink again when doing activity on console.
> > >>
> > >> Workaround:
> > >>
> > >> - Disabling CPU_IDLE or even just disabling C3 (MPU OSWR) seems to fix all the above issues.
> > >>
> > >> I don't really know what exactly is the issue but it seems to be specific to OMAP4, GIC, MPU OSWR.
> > >
> > > I can confirm that disabling CONFIG_CPU_IDLE seems to make the problem
> > > go away.  Hmm....
> > 
> > Another finger pointing in the same direction: omap2plus_defconfig +
> > CONFIG_CPU_IDLE=y also fails to boot rather consistently in today's
> > -next.
> 
> Booting today's next with multi_v7_defconfig (so cpuidle enabled) on
> omap4 sdp seems to boot reliably. And it's not producing these:
> 
> gic_timer_retrigger: lost localtimer interrupt 

Still seeing the above, looks like the lost localtimer interrupt
above is a separate issue..
 
> while panda is producing those errors like Roger mentioned.
> 
> It seems that the USB networking is the main difference between
> omap4 sdp and panda?

..but I think I found the cause for recent hangs on panda, just a wild
guess based on looking at the recent cpuidle patches after v3.14.

Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
until all coupled CPUs leave idle) makes booting work reliably again
on panda.

Can you guys confirm, so far no issues here after few boot tests,
but it might be too early to tell.

Regards,

Tony
