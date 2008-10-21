From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt
	bits
Date: Tue, 21 Oct 2008 15:02:20 -0700
Message-ID: <20081021220216.GQ7341@atomide.com>
References: <20081021045809.GJ7341@atomide.com> <94a0d4530810211309w28188181rcb8b1b881588ec87@mail.gmail.com> <20081021203700.GP7341@atomide.com> <94a0d4530810211434t5708978ftd1f409c7e4c93d12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60446 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbYJUWCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 18:02:24 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530810211434t5708978ftd1f409c7e4c93d12@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Nathan Monson <nmonson@gmail.com>, lauri.leukkunen@nokia.com, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Rick Bronson <rick@efn.org>

* Felipe Contreras <felipe.contreras@gmail.com> [081021 14:34]:
> On Tue, Oct 21, 2008 at 11:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Contreras <felipe.contreras@gmail.com> [081021 13:09]:
> >> On Tue, Oct 21, 2008 at 7:58 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > Hi all,
> >> >
> >> > Here's a bug fix for the irq -33 issue. So far it looks like the irq
> >> > spurious bits just tell that the irq sorting is invalid.
> >> >
> >> > This patch applies after undoing Lauri's patch
> >> > 5dc857b34441d5c0989b68bf3a488f89983b2645.
> >>
> >> You mean?
> >> 3da0e10243d075b905dfa8f1b4a6cb3694ab2ce0
> >
> > Oops yeah.
> >
> >> > Looks like there are still occasional spurious GPT12 interrupts, so
> >> > I'm now looking into that.
> >>
> >> Works perfectly fine with my DSP tests :)
> >
> > Thanks for testing, good to hear.
> 
> Hm, I forgot to revert acb7f8, so the test is not valid. I will try
> again tomorrow.

Well so far the only difference in my tests have been that with
strongly ordered patch there are no spurious irq 95 interrupts,
while without the strongly ordered patch there are occasional
spurious irq 95 interrupts.

These irq 95 interrupts without the strongly ordered patch are
strange as I don't have GPT12 enabled. Also, when they occur,
the INTCPS_SIR_IRQ bits for SPURIOUSIRQFLAG are set to 0x3ffffff
instead of the normal 0 or 1.

Anybody have an idea whtat the SPURIOUSIRQFLAG bits are
supposed to tell in addition to the priority sorting information
being valid or not?

The spurious interrupts show up easily with Natan's DSP ping
test. There's about one spurious irq 95 every two seconds
or so. The system still keeps working normally.

Anyways, I'll revert the earlier patch from Lauri, and apply
this one. Will also add it to omap-fixes queue for the mainline
kernel.

Regards,

Tony
