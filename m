From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] omap init_early changes for irq and timer init
Date: Thu, 31 Mar 2011 10:32:12 -0700
Message-ID: <20110331173212.GB21887@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <4D92E21F.6030608@ti.com>
 <20110330182211.GE18334@atomide.com>
 <4D943871.4030206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57182 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1CaRcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 13:32:18 -0400
Content-Disposition: inline
In-Reply-To: <4D943871.4030206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110331 01:14]:
> On 3/30/2011 11:52 PM, Tony Lindgren wrote:
> 
> >What it does not have is the code to dedicate gpt1 for PM
> >code, which can be done later once all the other dmtimer
> >changes are done.
> >
> Which not possible to do unless you plan to hack generic
> timer framework or waste additional timer hardware for
> this.

Well an extra timer hardware would only be needed on omap2 & 3.

But hey, if it makes sense to do or not to do is a different
set of patches. At least we now have an option to play with it.
 
> >For removing the old interface, I don't see any reason to
> >select timer combinations on omap3 other than omap3_timer
> >and omap3_beagle_timer.
> >
> >If there's need, any new valid sane combinations can be esily
> >added, although I seriously doubt that we'll need more for
> >omap3.
> >
> May be I am wrong but the point is about the merit of the
> solution even if there are only couple of board files where
> we use that interface.
> 
> It much cleaner and simpler to say timerid=X, from board
> file rather than creating a "struct sys_timer" instance
> and putting that in timer code.

Well the timerid=X adds yet another interface and more calls from
board-*.c to the common code. And it requires more changes if beagle
boards want to use the system clock as the source clock instead
of the 32KiHZ source.

Maybe let's call the omap3_beagle_timer omap3_secure_timer instead?

That should solve your issue of having the board name show up
in the generic code, no?
 
> >>At least I don't see other solution than using GPT1
> >>for wakeup.
> >
> >Right, there's no other way to wake except gpt1 or wake-up
> >enabled gpio lines. But we don't need to use gpt1 during
> >runtime at all.
> >
> This is not entirely correct and I think this is the point
> where we are not on same page. During runtime, gpt1 clock
> event is not used for tick generation but it's kept
> programmed because low power state switch via
> get triggered any time and on any CPU.

Well ideally we would not program it during runtime at all
because it's slow to program. I don't think that can be
currently done with the sys_timer.
 
> This is the same problem as X86 APIC timer + HPET
> switching and I worked with Thomas G and Russell
> to get this working on ARM platforms using generic
> timer framework. No hacking is needed in PM code
> for this.

Except we should improve things eventually where we don't
need to program the slow external timer during runtime
if we have local timers.

Hmm maybe I'm wrong and you got that working already?

Regards,

Tony
 
