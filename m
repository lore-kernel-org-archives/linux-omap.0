From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Tue, 25 Jun 2013 00:04:32 -0700
Message-ID: <20130625070432.GB5523@atomide.com>
References: <20130516214430.GN5600@atomide.com>
 <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost>
 <20130606155341.GL3331@atomide.com>
 <20130623221605.GA3150@blackmetal.musicnaut.iki.fi>
 <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
 <20130623234326.GA20703@blackmetal.musicnaut.iki.fi>
 <CAAwP0s00RwP7jCMF1O8j8Ndhu=VfD2dMA5fzr6jWvQ7PziXBCw@mail.gmail.com>
 <20130624072112.GQ5523@atomide.com>
 <CACxGe6vRCjyJgX+dgKuJREvFf_btjhSkfqDnYekuDfkVW7pRQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751256Ab3FYHEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 03:04:43 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6vRCjyJgX+dgKuJREvFf_btjhSkfqDnYekuDfkVW7pRQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jon Hunter <jgchunter@gmail.com>

* Grant Likely <grant.likely@secretlab.ca> [130624 09:00]:
> On Mon, Jun 24, 2013 at 8:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Javier Martinez Canillas <martinez.javier@gmail.com> [130623 18:08]:
> >> On Mon, Jun 24, 2013 at 1:43 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Jun 24, 2013 at 01:06:37AM +0200, Javier Martinez Canillas wrote:
> >> >> On Mon, Jun 24, 2013 at 12:16 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >> >> > What is the status of this patch? We're already at 3.10-rc7 and GPIO
> >> >> > IRQs are still broken on OMAP1.
> >> >
> >> > [...]
> >> >
> >> >> There is a problem with this patch.
> >> >
> >> > [...]
> >> >
> >> >> So I think that the correct solution is to add SPARSE_IRQ support to
> >> >> omap1 and not reverting Jon's patch. Of course this may not be
> >> >> possible since we are so close to 3.10 and most OMAP patches already
> >> >> merged for 3.11 but we should definitely try to have this at least for
> >> >> 3.12. Otherwise we won't be able to move to DT-only booting for
> >> >> OMAP2+.
> >> >
> >> > OMAP1 does not use DT. So we could put this code under #ifdef
> >> > CONFIG_ARCH_OMAP1 or similar. It's just a few lines of code. OMAP2+
> >> > work should not regress OMAP1.
> >> >
> >> > Demanding SPARSE_IRQ support for OMAP1 should have been discussed before
> >> > these changes were made. It's not reasonable to assume such things can
> >> > be made during rc-cycle. Also, now, I don't think it's reasonable to
> >> > wait for that to be done, as it would take until 3.12 or even later to
> >> > get OMAP1 functional again.
> >> >
> >> > A.
> >>
> >> Hi,
> >>
> >> Yes, since we are so late in the -rc cycle and OMAP1 is currently
> >> broken I agree that the only sensible solution is to revert the patch
> >> for now.
> >
> > Agreed.
> >
> >> I just wanted to point out the issue that keeping the OMAP GPIO driver
> >> using legacy mapping domain represents a blocker to have GPIO-IRQ
> >> working with Device Tree for OMAP2+
> >
> > Yes. We can do the ifdef Aaro suggested, and let's also plan on
> > converting omap1 to use SPARSE_IRQ. But with the ifdef we can cut
> > away the dependency between these two.
> 
> Alright. Sorry I dropped the ball on this one. I've lost track of
> which patch needs to get applied, but given that it is so late in the
> cycle, it would be better for someone else to apply the change, test
> and send a pull request to Linus. I'm okay with it going through the
> OMAP tree if that is the most expedient. Alternately, send me the pull
> request and I'll pass it on to Linus.

OK, I'll wait for Aaro's ack on Javier's patch and then put it into a
branch for you.

Regards,

Tony
