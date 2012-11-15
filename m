From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Thu, 15 Nov 2012 11:01:37 +0000
Message-ID: <20121115110137.GA25985@arm.com>
References: <20121114185335.GU6801@atomide.com>
 <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com>
 <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com>
 <50A43D58.5030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47263 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993226Ab2KOLBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 06:01:48 -0500
In-Reply-To: <50A43D58.5030404@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 15, 2012 at 12:54:48AM +0000, Rob Herring wrote:
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
> 
> It could vary by rev, but I see 0 for the reset value, so this would not
> work if the bootloader did not do any setup of the diagnostic register.
> 
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

This would fail on platforms where Linux runs in non-secure mode. What
we do for some errata workarounds is to test whether the bit was already
set and avoid writing the register. But this assumes that, for a given
workaround in the kernel, there is a corresponding workaround in the
code running before the kernel (boot-loader, firmware) which sets that
bit.

Since the kernel will run more often in non-secure mode (on Cortex-A15
you need this for the virtualisation extensions) I strongly suggest that
the workaround (usually undocumented bit setting) is done before the
kernel is started and we simply remove it from Linux (or add a clear
comment that it only works if running in secure mode; if unsure say
'N').

I don't think it's worth the hassle detecting whether the kernel runs in
secure or non-secure mode, just assume the latter and get SoC vendors to
update the boot loaders or firmware (if possible) with any errata
workarounds.

Having a common SMC API for errata workarounds is not feasible since not
all registers are public, most are implementation specific and it could
have secure implications with exposing them.

-- 
Catalin

