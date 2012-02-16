From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
Date: Thu, 16 Feb 2012 18:48:15 +0200
Message-ID: <1329410895.4102.404.camel@sokoban>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
	 <1329320274-481-9-git-send-email-t-kristo@ti.com> <87pqdf99c2.fsf@ti.com>
	 <1329382652.4102.386.camel@sokoban>
	 <CAMQu2gx5JdKfTTUhi28N_=EZ3tDo7nTRA00ErrMpuGMkOh9rgw@mail.gmail.com>
	 <1329398159.4102.391.camel@sokoban> <1329405804.4102.400.camel@sokoban>
	 <CAMQu2gwMboftdRo9dE38ECp+5o2nTPgxeZ60JrbV0xd8HLNfUg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43002 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2BPQsZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 11:48:25 -0500
In-Reply-To: <CAMQu2gwMboftdRo9dE38ECp+5o2nTPgxeZ60JrbV0xd8HLNfUg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-02-16 at 21:15 +0530, Shilimkar, Santosh wrote:
> On Thu, Feb 16, 2012 at 8:53 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On Thu, 2012-02-16 at 15:15 +0200, Tero Kristo wrote:
> >> On Thu, 2012-02-16 at 15:27 +0530, Shilimkar, Santosh wrote:
> >> > On Thu, Feb 16, 2012 at 2:27 PM, Tero Kristo <t-kristo@ti.com> wrote:
> >> > > On Wed, 2012-02-15 at 11:37 -0800, Kevin Hilman wrote:
> >> > >> Tero Kristo <t-kristo@ti.com> writes:
> >> > >>
> >> > >> > Attempting this will cause problems especially with off-mode enabled.
> >> > >>
> >> > >> Please be more verbose about the problems seen, and the root cause(s).
> >> > >>
> >> > >
> >> > > I was actually looking forward for some help with this commit message,
> >> > > as I am still not quite sure what is going on in here. :) Here is the
> >> > > log for suspend (btw, cam_pwrdm does not go to off in mainline yet, but
> >> > > I think that is probably fixed by the patch from Paul,
> >> > > omap_set_pwrdm_state() does not work properly.) The warning comes out
> >> > > after wakeup from off-mode, and it is triggered by the disabling of
> >> > > autodeps before off-mode entry.
> >> > >
> >> > This mostly indicates that one of the per clock-domain module
> >> > clock turning ON seems to be not working well with auto deps
> >> > disabled. This leads to interconnect violation.
> >> >
> >> > if not tried already, can you put the per_clockdomain in SW_WKUP
> >> > in the low power code early resume path and see if this
> >> > error goes away.
> >>
> >> This seems to get rid of the dump also. It looks like some driver resume
> >> is not behaving nicely, I am trying to pinpoint the culprit currently
> >> and see whether it can provide more info.
> >
> > Okay, I have some more info about this now.
> >
> > What happens is that when entering off-mode, PER domain remains OFF even
> > during the execution of the exit phase from omap_sram_idle. Adding a
> > manual SW_WKUP it comes up and there are no issues. If autodeps are
> > enabled on the domain, it comes back from off mode as active.
> >
> > Looking further in the code, we have this at the end of omap_sram_idle:
> >
> >        if (per_next_state < PWRDM_POWER_ON) {
> >                per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> >                omap2_gpio_resume_after_idle();
> >                wake_per();
> >                if (per_prev_state == PWRDM_POWER_OFF)
> >                        omap3_per_restore_context();
> >        }
> >
> > ... which seems to assume that per domain is on. Gpio code does not
> > control any clocks currently, as it only requires the interface clock to
> > be on, and as this is autoidled....
> >
> > Any comments how we should handle this? Shall we just keep these two
> > patches for handling this or add some different hackery for the gpio
> > issue?
> >
> Good. I thought too that issue will disappear.
> The issue is pretty clear. Technically every driver pm_runtime() code should
> be able to manage a clock->clockdomain->power domain power up/down
> sequence. That should work without auto deps.
> 
> Do you narrowed down which driver resume is creating the dump ?
> UART , GPIO ?

It is the gpio base stuff called from omap_sram_idle(), basically the
restore context part. If I force enable per domain before the code
snippet before, there is no dump, but if it is done after, I get the
dump.

The thing is that gpio driver doesn't currently have this kind of
mechanism for the restore context part, at least not on omap3 due to
above clocking issue (only autoidled interface clock is used.)

-Tero


