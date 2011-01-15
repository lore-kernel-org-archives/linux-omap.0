From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
Date: Sat, 15 Jan 2011 00:25:31 +0000
Message-ID: <20110115002531.GF22505@n2100.arm.linux.org.uk>
References: <20110111231611.GX4957@atomide.com> <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com> <20110113091546.GA24429@n2100.arm.linux.org.uk> <20110113155152.GG4957@atomide.com> <20110113164957.GA28040@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com> <20110114212027.GD22505@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141551140.28621@utopia.booyaka.com> <20110114235840.GE22505@n2100.arm.linux.org.uk> <20110115001254.GU4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56634 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab1AOAZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 19:25:50 -0500
Content-Disposition: inline
In-Reply-To: <20110115001254.GU4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, Jan 14, 2011 at 04:12:55PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110114 15:58]:
> > 
> > # ARMv6k
> > config CPU_32v6K
> >         bool "Support ARM V6K processor extensions" if !SMP
> >         depends on CPU_V6 || CPU_V7
> >         default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> > 
> > OMAP2 prevents the selection of armv6k support.  This is probably a very
> > bad idea if you want to run the resulting kernel on SMP hardware as it
> > removes a barrier in the spinlock code and disables the SMP-safe bitops.
> 
> I have some ideas to fix this. Unfortunately it will be inefficient
> as spinlock.h can be included from modules too :( I was thinking we can
> implement dsb_sev in the proc-*.S functions for the unoptimized multi-arm
> builds.

For spinlocks, the important thing is the barrier.  The wfe/sev are an
optimization.  The barrier contained with the ifdef is a valid V6
instruction.

> > The original patch which started turning this off was from the MX3 stuff,
> > but without explaination.
> > 
> > However, OMAP extended this to disabling the select statement for CPU_32v6K
> > even if CPU_V7 is set:
> > 
> >  config CPU_V7
> >         bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB |-       select CPU_32v6K
> > +       select CPU_32v6K if !ARCH_OMAP2
> > 
> > Arguably, SMP _requires_ CPU_32v6K to be enabled for a safe kernel, and this
> > patch should not have been merged.
> 
> The only way we can fix that is do smp_on_up style rewriting of the assembly
> during init between CPUv6 and v6K. Want me to do a patch for that?

The bitops code is quite different between the two versions, and I doubt
the smp_on_up rewriting will look at all pretty.  I think it needs an
alternative idea - like not using the 'byte' operations at all.

Whether we have any code which passes non-word aligned pointers to bitops
isn't particularly known - in theory they should all be unsigned long *'s,
so should be word-aligned.  Who knows what filesystems do though... and
such a change could be disasterous to peoples data if the block/inode
bitmaps get corrupted.

IOW, such a change needs testing on a box where a range of filesystems are
used, and the filesystems can be thrown away if corrupted.
