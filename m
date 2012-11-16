From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Fri, 16 Nov 2012 18:39:51 +0000
Message-ID: <20121116183951.GJ3332@n2100.arm.linux.org.uk>
References: <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk> <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com> <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com> <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com> <20121116095921.GH3332@n2100.arm.linux.org.uk> <20121116180928.GB31456@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43999 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab2KPSkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 13:40:19 -0500
Content-Disposition: inline
In-Reply-To: <20121116180928.GB31456@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Rob Herring <robherring2@gmail.com>, Tony Lindgren <tony@atomide.com>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 16, 2012 at 06:09:28PM +0000, Catalin Marinas wrote:
> On Fri, Nov 16, 2012 at 09:59:21AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 15, 2012 at 08:31:33AM -0600, Rob Herring wrote:
> > > So we should make all these work-arounds depend on !MULTI_PLATFORM then.
> > 
> > No, because some of the work-arounds don't require setting bits in magic
> > registers.
> > 
> > Also realise this: we test for the revision of the CPU to which they're
> > applicable before attempting to set them.  If you have a work-around
> > enabled in the kernel, and it fails at boot, _that_ is an indicator not
> > that the kernel is doing something wrong, but that you need to ensure
> > that the work-around has been applied by the earlier stages.
> > 
> > It's not about "but platform X doesn't need it" - it's about platform X
> > not having the earlier stages updated to fix the errata.
> 
> There is another aspect. Many CPUs in the field, even if they are a
> certain rxpy revision, have ECO fixes applied for critical bugs and
> don't require the workaround. Sometimes those undocumented bits have
> considerable performance impact and vendors may apply an ECO (unless
> they are very late in the tape-out process). But the ECO fix does not
> change the CPU revision, hence the workaround becomes platform specific.
> 
> That's why I think it's better if those workarounds are just pushed to
> the boot-loader for multi-platform kernels. Linux could still check the
> bits and warn about them rather than failing to boot.

... and that's a U-turn if ever there was one... it's ARM Ltd who've been
pushing to have these work-arounds in the kernel in the first place.

Should we just remove all the work-arounds, and require boot loaders,
including the one on Versatile platforms, to implement this?  Why should
we treat secure platforms be any different from the non-secure ones in
this regard?  After all, this _does_ stand in the way of a single kernel
image working properly on secure and non-secure platforms.

The more this thread progresses, the more I think the decision to put
errata into the kernel was the wrong one.
