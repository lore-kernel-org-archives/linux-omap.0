From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Fri, 28 Jan 2011 12:25:18 +0000
Message-ID: <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	 <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	 <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
	 <20110127185935.GA1651@n2100.arm.linux.org.uk>
	 <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
	 <20110128095953.GA13005@n2100.arm.linux.org.uk>
	 <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
	 <20110128110629.GB13005@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:33925 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755221Ab1A1MZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 07:25:29 -0500
In-Reply-To: <20110128110629.GB13005@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2011-01-28 at 11:06 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 28, 2011 at 10:46:51AM +0000, Catalin Marinas wrote:
> > On Fri, 2011-01-28 at 09:59 +0000, Russell King - ARM Linux wrote:
> > > On Fri, Jan 28, 2011 at 09:46:06AM +0000, Catalin Marinas wrote:
> > > > My point is that we may want SWP_EMULATE disabled (or depending on !
> > > > CPU_USE_DOMAINS). With domains enabled every read-only user page is
> > > > writeable by the kernel. This has the side-effect that SWP emulation
> > > > using LDREX/STREX breaks COW.
> > >
> > > Yes, and maybe we should instead just enable the SWP instruction by default
> > > on ARMv7, and if SWP emulation is built, disable it at that point.
> >
> > We can't disable the SWP instruction as long as domains are enabled (COW
> > not working for in-kernel STREX).
> >
> > On ARMv7 we could always force R/O kernel/user pages in set_pte_ext
> > independent of the domains setting and have early_trap_init() use
> > vectors_page() if cpu_architecture() >= 7 (this would actually catch
> > ARM11MPCore as well because of the way we interpret CPUID).
> 
> What about a kernel covering ARMv6 too?  Writing to an aliased mapping
> of the vectors page (as required for TLS emulation) will require
> additional cache maintainence on every context switch.

With your latest patches, do we use the TLS emulation on ARMv7 (UP) if
v6 is compiled in? If that's the case, we may have a problem - I talked
to the toolchain guys and it looks like code optimised for ARMv7 reads
the TLS register directly without going through the kuser helper. So you
may have people taking an Ubuntu filesystem (v7 only) and a pre-built
OMAP image with TLS emulation even on Cortex-A8 and things won't work as
expected.

On ARMv6 with domains enabled, cpu_v6_set_pte_ext() maps the vectors
page as kernel R/W. The cpu_v7_set_pte_ext() could map it as kernel RO
and use the TLS register. The only other place where this matters on
ARMv7 is early_trap_init() but it's easily fixable on this architecture.

> 1. SWP emulation requires domain support turned off

Not necessarily - it requires RO user pages to be kernel RO (though this
feature came with the domains removal patch).

> 2. We can't turn domains off without creating a vectors page alias

Correct.

> 3. We can't have a separate vectors alias with ARMv6 VIPT aliasing caches
>    without additional cache maintainence.

Correct.

> I don't think overloading the context switch with yet more conditionals
> based on yet more TLS combinations is a practical solution.

Yet another run-time code patching for the TLS, though it gets a bit
complex. But we may need to solve it for the v7 filesystem case I
mentioned above.

> So, ARMv6 TLS emulation, and SWP emulation are incompatible with each
> other.

Yes.

> So either we don't have the SWP instruction at all on ARMv6+, or we have
> it enabled in hardware, or we don't and use the emulation where possible.

If we can't sort out TLS register setting on v6+v7 kernels (I think we
should), then we must have the SWP instruction enabled (no emulation).
Which gets us back to the SWP_EMULATE depend on (CPU_V7 && !CPU_V6).

-- 
Catalin


