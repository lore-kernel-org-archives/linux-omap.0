From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 18:08:56 -0800
Message-ID: <20121115020856.GG6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
 <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com>
 <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com>
 <50A43D58.5030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60309 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423422Ab2KOCJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 21:09:06 -0500
Content-Disposition: inline
In-Reply-To: <50A43D58.5030404@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Rob Herring <robherring2@gmail.com> [121114 16:56]:
> On 11/14/2012 04:21 PM, Tony Lindgren wrote:
> > * Rob Herring <robherring2@gmail.com> [121114 13:59]:
> >> On 11/14/2012 02:32 PM, Tony Lindgren wrote:
> >>>
> >>> Checking for the bit already set should work in this case, I'll post
> >>> a patch for that shortly.
> >>
> >> Can you actually read the state of the diagnostic register in non-secure
> >> mode? If you can on the A9, is the same true on A8 or others?
> > 
> > Looks like it can be read on at least TI omap 4430 which is A9.
> > But it reads as zero, so the below patch is what I came up with.
> > 
> > No idea if assuming that zero value for the diagnostic register
> > is safe.. What's the default value of the diagnostic register supposed
> > to be?
> 
> RTFM. Oh, wait it's a super secret, undocumented register. We shouldn't
> even be talking about it.

WITFM? :)
 
> It could vary by rev, but I see 0 for the reset value, so this would not
> work if the bootloader did not do any setup of the diagnostic register.

OK
 
> One way to determine secure mode on the A9 would be seeing if you can
> change the auxcr register. Something like this (untested):
> 
> mrc	p15, 0, r0, c1, c0, 1; Read ACTLR
> eor	r1, r0, #0x100		; Modify alloc in 1 way
> mcr	p15, 0, r1, c1, c0, 1
> mrc	p15, 0, r2, c1, c0, 1; Read ACTLR
> mcr	p15, 0, r0, c1, c0, 1	; Restore original value
> cmp	r1, r2
> bne	skip_errata
> 
> 
> It would be good to do this test for all the errata rather than just
> this one.

I recall writes to the aux control registers producing an exception
on secure A8 based omaps, but I'll give that a try when I have a
chance.

Regards,

Tony
