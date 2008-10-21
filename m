From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt
	bits
Date: Tue, 21 Oct 2008 13:37:04 -0700
Message-ID: <20081021203700.GP7341@atomide.com>
References: <20081021045809.GJ7341@atomide.com> <94a0d4530810211309w28188181rcb8b1b881588ec87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56343 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYJUUhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 16:37:08 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530810211309w28188181rcb8b1b881588ec87@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Nathan Monson <nmonson@gmail.com>, lauri.leukkunen@nokia.com, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Rick Bronson <rick@efn.org>

* Felipe Contreras <felipe.contreras@gmail.com> [081021 13:09]:
> On Tue, Oct 21, 2008 at 7:58 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi all,
> >
> > Here's a bug fix for the irq -33 issue. So far it looks like the irq
> > spurious bits just tell that the irq sorting is invalid.
> >
> > This patch applies after undoing Lauri's patch
> > 5dc857b34441d5c0989b68bf3a488f89983b2645.
> 
> You mean?
> 3da0e10243d075b905dfa8f1b4a6cb3694ab2ce0

Oops yeah.

> > Looks like there are still occasional spurious GPT12 interrupts, so
> > I'm now looking into that.
> 
> Works perfectly fine with my DSP tests :)

Thanks for testing, good to hear.

Tony
