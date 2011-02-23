From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init() code
Date: Wed, 23 Feb 2011 19:59:04 +0530
Message-ID: <8e1ea9481b3af57ffb07fe965ff2ec64@mail.gmail.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1102230015480.22636@utopia.booyaka.com> <4D651791.8000900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45908 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719Ab1BWO3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 09:29:09 -0500
Received: by mail-qy0-f178.google.com with SMTP id 2so3579686qyk.9
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 06:29:07 -0800 (PST)
In-Reply-To: <4D651791.8000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Wednesday, February 23, 2011 7:50 PM
> To: Paul Walmsley
> Cc: Shilimkar, Santosh; linux-omap@vger.kernel.org; Tony Lindgren;
> Hilman, Kevin
> Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to mdesc-
> >timer->init() code
>
> Salut Paul,
>
> On 2/23/2011 8:18 AM, Paul Walmsley wrote:
> > Hi Santosh,
> >
> > On Tue, 22 Feb 2011, Santosh Shilimkar wrote:
> >
> >> To adhere to recent early_init changes, commit '44dc0' made
> >> omap_hwmod_late_init() to core_initcall to avoid ioremap()
> failures.
> >>
> >> Later 'e7c7d7' removed _mpu_rt_va population
> omap_hwmod_late_init()
> >>
> >> So now if we move the  omap_hwmod_late_init() to mdesc->timer-
> >init(),
> >> timer1 should work with hwmod instead of any special hwmod
> settings.
> >>
> >> This was proposed by Paul Walmsley<paul@pwsan.com>
> >
> > thanks -- something like this series was what I had in mind to go
> to
> > mainline:
> >
> >     http://marc.info/?l=linux-omap&m=129844518908008&w=2
> >
> > This series is also available at the branch
> "hwmod_clockevent_2.6.39" of
> > git://git.pwsan.com/linux-2.6.
> >
> > Ultimately, of course, it's up to Tony to decide what approach he
> wants to
> > use...
>
> This is indeed a little bit cleaner to init only the timer hwmod in
> the timer code, but I'm still wondering it it worth the extra
> complexity.
>
I too like Paul's series except the hard coding as pointed on the
relevant patch.

> As soon as we have one hwmod to initialize, why cannot we initialize
> the whole list like before?
> If tomorrow we want to handle PRCM and control module using hwmod,
> like
> I'd like to do, we will have to init these hwmods early as well.
> Even earlier that init_early for the control module at least.
>
> And then we will have a bunch of different init paths from different
> parts of the boot sequence that might become tricky to handle.
>
I agree with Benoit. L3 interconnect error handling and EMIF are another
examples. Interconnect error handling to trap early failures
and EMIF to re-configure DDR as early as possible. At least before
the DVFS kicks in.

Regards,
Santosh
