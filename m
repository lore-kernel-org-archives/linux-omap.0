From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if
 ARCH_OMAP2 isnot selected
Date: Thu, 28 Jan 2010 09:47:42 -0800
Message-ID: <20100128174741.GN23505@atomide.com>
References: <20100126193748.15134.4837.stgit@baageli.muru.com>
 <1264676451.7064.40.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64423 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab0A1Rr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:47:29 -0500
Content-Disposition: inline
In-Reply-To: <1264676451.7064.40.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [100128 02:58]:
> On Tue, 2010-01-26 at 19:37 +0000, Tony Lindgren wrote:
> > Otherwise the kernel built with both CPU_V6 and CPU_V7 will not
> > boot on omap2.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mm/Kconfig |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index baf6384..4c2e90d 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -399,7 +399,7 @@ config CPU_V6
> >  config CPU_32v6K
> >         bool "Support ARM V6K processor extensions" if !SMP
> >         depends on CPU_V6
> > -       default y if SMP && !ARCH_MX3
> > +       default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> >         help
> >           Say Y here if your ARMv6 processor supports the 'K' extension.
> >           This enables the kernel to use some instructions not present
> > @@ -410,7 +410,7 @@ config CPU_32v6K
> >  # ARMv7
> >  config CPU_V7
> >         bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> > -       select CPU_32v6K
> > +       select CPU_32v6K if !ARCH_OMAP2
> 
> I suspect that would be an issue for all ARMv6 platforms without the MP
> extensions (v6K). Could we do something like:
> 
> 	select CPU_32v6K if SMP || !CPU_V6

Hmm, but then we can't compile in SMP for single core systems and
keep it bootable on single core v6?

> As for the CPU_32v6K config entry, do any of ARCH_MX3 or ARCH_OMAP2
> support SMP? We could remove them.

There's no hardware SMP support for omap2 or 3. But I may take a look
at trying to compile in also unoptimized omap4 support with some dummy
SMP support for omap2 and omap3 :)

The bloated kernel I'm after would have:

ARCH_OMAP2	v6, no hardware SMP support, can't use CPU_32v6K
ARCH_OMAP3	v7, no hardware SMP support
ARCH_OMAP4	v7, hardware SMP support, so need SMP selected

In this case it should be OK to have SMP set and CPU_32v6K
not set. Sure the kernel would not be bootable if there was
some real v6 with hardware SMP support, but in this case there
is no such hardware.

Why is this needed? It avoids many unnecessary compiles to test
the common code. It's also handy for distro install kernels.

Regards,

Tony
