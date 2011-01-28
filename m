From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
Date: Fri, 28 Jan 2011 13:21:34 +0000
Message-ID: <20110128132134.GD13005@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk> <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com> <20110127185935.GA1651@n2100.arm.linux.org.uk> <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com> <20110128095953.GA13005@n2100.arm.linux.org.uk> <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com> <20110128110629.GB13005@n2100.arm.linux.org.uk> <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47375 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1A1NVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 08:21:42 -0500
Content-Disposition: inline
In-Reply-To: <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 28, 2011 at 12:25:18PM +0000, Catalin Marinas wrote:
> On Fri, 2011-01-28 at 11:06 +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 28, 2011 at 10:46:51AM +0000, Catalin Marinas wrote:
> > > On Fri, 2011-01-28 at 09:59 +0000, Russell King - ARM Linux wrote:
> > > > On Fri, Jan 28, 2011 at 09:46:06AM +0000, Catalin Marinas wrote:
> > > > > My point is that we may want SWP_EMULATE disabled (or depending on !
> > > > > CPU_USE_DOMAINS). With domains enabled every read-only user page is
> > > > > writeable by the kernel. This has the side-effect that SWP emulation
> > > > > using LDREX/STREX breaks COW.
> > > >
> > > > Yes, and maybe we should instead just enable the SWP instruction by default
> > > > on ARMv7, and if SWP emulation is built, disable it at that point.
> > >
> > > We can't disable the SWP instruction as long as domains are enabled (COW
> > > not working for in-kernel STREX).
> > >
> > > On ARMv7 we could always force R/O kernel/user pages in set_pte_ext
> > > independent of the domains setting and have early_trap_init() use
> > > vectors_page() if cpu_architecture() >= 7 (this would actually catch
> > > ARM11MPCore as well because of the way we interpret CPUID).
> > 
> > What about a kernel covering ARMv6 too?  Writing to an aliased mapping
> > of the vectors page (as required for TLS emulation) will require
> > additional cache maintainence on every context switch.
> 
> With your latest patches, do we use the TLS emulation on ARMv7 (UP) if
> v6 is compiled in? If that's the case, we may have a problem - I talked
> to the toolchain guys and it looks like code optimised for ARMv7 reads
> the TLS register directly without going through the kuser helper. So you
> may have people taking an Ubuntu filesystem (v7 only) and a pre-built
> OMAP image with TLS emulation even on Cortex-A8 and things won't work as
> expected.

You're really making a mountain out of TLS.

If we have a v6+v6k+v7 kernel, then the way the kernel TLS code is built,
we will use the TLS register if that's available on the hardware.  If it
isn't, we will write the TLS value directly to virtual 0xffff0ffc.

So, a kernel built for v6+v6k+v7, when run on v7, will set the hardware
TLS register, and your v7 optimized binaries which access the TLS register
directly will work.  Same for v6k.

For v6, you won't be able to run v7 optimized binaries on that hardware
anyway, because it doesn't have the TLS register, and as such the
instructions which access it will fault.  That's true whether you have
a v6 only kernel or a v6+v6k+v7 kernel.

What we're discussing has nothing at all to do with getting v7 binaries
running on v6 hardware.  That's just not going to happen.

> On ARMv6 with domains enabled, cpu_v6_set_pte_ext() maps the vectors
> page as kernel R/W. The cpu_v7_set_pte_ext() could map it as kernel RO
> and use the TLS register. The only other place where this matters on
> ARMv7 is early_trap_init() but it's easily fixable on this architecture.

That's pointless.  There's no "could map the vectors page" - set_pte_ext()
doesn't know what's the vectors page and what isn't.  It's about how
set_pte_ext() maps pages which are marked with just L_PTE_USER.

All L_PTE_USER pages get mapped as user read-only.  Whether they get mapped
SVC read-only or SVC read-write depends on whether we support domains.
Without domains, they're mapped SVC read-write, and we need to use the
ldrt/strt instructions.  With domains, they're mapped SVC read-only, and we
no longer need the ldrt/strt instructions.

> > 1. SWP emulation requires domain support turned off
> 
> Not necessarily - it requires RO user pages to be kernel RO (though this
> feature came with the domains removal patch).

Yes it does because without domains, we need user pages to be kernel
read-only, which also makes the vectors page kernel read-only.

> > 2. We can't turn domains off without creating a vectors page alias
> 
> Correct.
> 
> > 3. We can't have a separate vectors alias with ARMv6 VIPT aliasing caches
> >    without additional cache maintainence.
> 
> Correct.
> 
> > I don't think overloading the context switch with yet more conditionals
> > based on yet more TLS combinations is a practical solution.
> 
> Yet another run-time code patching for the TLS, though it gets a bit
> complex.

It _already_ is complex.  We don't need any more complexity there.  Have
a look in asm/tls.h to see that there's already four different cases we
have to consider.

> But we may need to solve it for the v7 filesystem case I mentioned above.

No we don't.  We're already selecting the code appropriately from four
different cases for the supported processor types.  We don't need "maybe
the vectors page is read-only" introducing another two cases with complex
cache flushing and location of the vectors page, and we certainly don't
need this complication at runtime.

> If we can't sort out TLS register setting on v6+v7 kernels (I think we
> should), then we must have the SWP instruction enabled (no emulation).
> Which gets us back to the SWP_EMULATE depend on (CPU_V7 && !CPU_V6).

That I think is the right solution.  It sorts out the issues without
additional overhead.

The only use which SWP_EMULATE gets us then is detecting userspace
programs which use the SWP instruction - and that can only happen on
a V7-only or v6k+v7 targetted kernel.
