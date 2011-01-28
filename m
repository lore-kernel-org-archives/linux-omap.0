From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
Date: Fri, 28 Jan 2011 11:06:29 +0000
Message-ID: <20110128110629.GB13005@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk> <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com> <20110127185935.GA1651@n2100.arm.linux.org.uk> <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com> <20110128095953.GA13005@n2100.arm.linux.org.uk> <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59430 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab1A1LHH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 06:07:07 -0500
Content-Disposition: inline
In-Reply-To: <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 28, 2011 at 10:46:51AM +0000, Catalin Marinas wrote:
> On Fri, 2011-01-28 at 09:59 +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 28, 2011 at 09:46:06AM +0000, Catalin Marinas wrote:
> > > My point is that we may want SWP_EMULATE disabled (or depending on !
> > > CPU_USE_DOMAINS). With domains enabled every read-only user page is
> > > writeable by the kernel. This has the side-effect that SWP emulation
> > > using LDREX/STREX breaks COW.
> > 
> > Yes, and maybe we should instead just enable the SWP instruction by default
> > on ARMv7, and if SWP emulation is built, disable it at that point.
> 
> We can't disable the SWP instruction as long as domains are enabled (COW
> not working for in-kernel STREX).
> 
> On ARMv7 we could always force R/O kernel/user pages in set_pte_ext
> independent of the domains setting and have early_trap_init() use
> vectors_page() if cpu_architecture() >= 7 (this would actually catch
> ARM11MPCore as well because of the way we interpret CPUID).

What about a kernel covering ARMv6 too?  Writing to an aliased mapping
of the vectors page (as required for TLS emulation) will require
additional cache maintainence on every context switch.

1. SWP emulation requires domain support turned off
2. We can't turn domains off without creating a vectors page alias
3. We can't have a separate vectors alias with ARMv6 VIPT aliasing caches
   without additional cache maintainence.

I don't think overloading the context switch with yet more conditionals
based on yet more TLS combinations is a practical solution.

So, ARMv6 TLS emulation, and SWP emulation are incompatible with each
other.

So either we don't have the SWP instruction at all on ARMv6+, or we have
it enabled in hardware, or we don't and use the emulation where possible.
