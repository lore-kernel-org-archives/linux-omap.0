From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
Date: Thu, 16 Feb 2012 15:15:59 +0200
Message-ID: <1329398159.4102.391.camel@sokoban>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
	 <1329320274-481-9-git-send-email-t-kristo@ti.com> <87pqdf99c2.fsf@ti.com>
	 <1329382652.4102.386.camel@sokoban>
	 <CAMQu2gx5JdKfTTUhi28N_=EZ3tDo7nTRA00ErrMpuGMkOh9rgw@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60027 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab2BPNQM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 08:16:12 -0500
In-Reply-To: <CAMQu2gx5JdKfTTUhi28N_=EZ3tDo7nTRA00ErrMpuGMkOh9rgw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-02-16 at 15:27 +0530, Shilimkar, Santosh wrote:
> On Thu, Feb 16, 2012 at 2:27 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On Wed, 2012-02-15 at 11:37 -0800, Kevin Hilman wrote:
> >> Tero Kristo <t-kristo@ti.com> writes:
> >>
> >> > Attempting this will cause problems especially with off-mode enabled.
> >>
> >> Please be more verbose about the problems seen, and the root cause(s).
> >>
> >
> > I was actually looking forward for some help with this commit message,
> > as I am still not quite sure what is going on in here. :) Here is the
> > log for suspend (btw, cam_pwrdm does not go to off in mainline yet, but
> > I think that is probably fixed by the patch from Paul,
> > omap_set_pwrdm_state() does not work properly.) The warning comes out
> > after wakeup from off-mode, and it is triggered by the disabling of
> > autodeps before off-mode entry.
> >
> This mostly indicates that one of the per clock-domain module
> clock turning ON seems to be not working well with auto deps
> disabled. This leads to interconnect violation.
> 
> if not tried already, can you put the per_clockdomain in SW_WKUP
> in the low power code early resume path and see if this
> error goes away.

This seems to get rid of the dump also. It looks like some driver resume
is not behaving nicely, I am trying to pinpoint the culprit currently
and see whether it can provide more info.

-Tero


