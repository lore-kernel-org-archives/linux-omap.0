From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Fri, 14 Jan 2011 16:37:34 -0800
Message-ID: <20110115003734.GV4957@atomide.com>
References: <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
 <20110113091546.GA24429@n2100.arm.linux.org.uk>
 <20110113155152.GG4957@atomide.com>
 <20110113164957.GA28040@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com>
 <20110114212027.GD22505@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101141551140.28621@utopia.booyaka.com>
 <20110114235840.GE22505@n2100.arm.linux.org.uk>
 <20110115001254.GU4957@atomide.com>
 <20110115002531.GF22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63156 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1AOAhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 19:37:53 -0500
Content-Disposition: inline
In-Reply-To: <20110115002531.GF22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110114 16:24]:
> On Fri, Jan 14, 2011 at 04:12:55PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110114 15:58]:
> > > 
> > > # ARMv6k
> > > config CPU_32v6K
> > >         bool "Support ARM V6K processor extensions" if !SMP
> > >         depends on CPU_V6 || CPU_V7
> > >         default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> > > 
> > > OMAP2 prevents the selection of armv6k support.  This is probably a very
> > > bad idea if you want to run the resulting kernel on SMP hardware as it
> > > removes a barrier in the spinlock code and disables the SMP-safe bitops.
> > 
> > I have some ideas to fix this. Unfortunately it will be inefficient
> > as spinlock.h can be included from modules too :( I was thinking we can
> > implement dsb_sev in the proc-*.S functions for the unoptimized multi-arm
> > builds.
> 
> For spinlocks, the important thing is the barrier.  The wfe/sev are an
> optimization.  The barrier contained with the ifdef is a valid V6
> instruction.

OK, great it's just drain WB. Then we can do the ussual iffdeffery
on it for multi-arm builds as it does not depend on the 6K extensions.
I can do a patch for this on Monday, gotta run now.
 
> > > The original patch which started turning this off was from the MX3 stuff,
> > > but without explaination.
> > > 
> > > However, OMAP extended this to disabling the select statement for CPU_32v6K
> > > even if CPU_V7 is set:
> > > 
> > >  config CPU_V7
> > >         bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB |-       select CPU_32v6K
> > > +       select CPU_32v6K if !ARCH_OMAP2
> > > 
> > > Arguably, SMP _requires_ CPU_32v6K to be enabled for a safe kernel, and this
> > > patch should not have been merged.
> > 
> > The only way we can fix that is do smp_on_up style rewriting of the assembly
> > during init between CPUv6 and v6K. Want me to do a patch for that?
> 
> The bitops code is quite different between the two versions, and I doubt
> the smp_on_up rewriting will look at all pretty.  I think it needs an
> alternative idea - like not using the 'byte' operations at all.
> 
> Whether we have any code which passes non-word aligned pointers to bitops
> isn't particularly known - in theory they should all be unsigned long *'s,
> so should be word-aligned.  Who knows what filesystems do though... and
> such a change could be disasterous to peoples data if the block/inode
> bitmaps get corrupted.

Hmm, how about emulation of those instructions for non-v6K ARMv6 processors?
I guess we could do some address checking in the bitops functions too for
multi-arm builds..
 
> IOW, such a change needs testing on a box where a range of filesystems are
> used, and the filesystems can be thrown away if corrupted.

Or we could patch in the address checking first and only disable it
later if now warnings.

Tony
