From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if
	ARCH_OMAP2 isnot selected
Date: Fri, 29 Jan 2010 10:42:56 +0000
Message-ID: <1264761776.4242.30.camel@pc1117.cambridge.arm.com>
References: <20100126193748.15134.4837.stgit@baageli.muru.com>
	 <1264676451.7064.40.camel@pc1117.cambridge.arm.com>
	 <20100128174741.GN23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:61922 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753670Ab0A2KnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 05:43:11 -0500
In-Reply-To: <20100128174741.GN23505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, 2010-01-28 at 17:47 +0000, Tony Lindgren wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [100128 02:58]:
> > On Tue, 2010-01-26 at 19:37 +0000, Tony Lindgren wrote:
> > > Otherwise the kernel built with both CPU_V6 and CPU_V7 will not
> > > boot on omap2.
> > >
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/mm/Kconfig |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > > index baf6384..4c2e90d 100644
> > > --- a/arch/arm/mm/Kconfig
> > > +++ b/arch/arm/mm/Kconfig
> > > @@ -399,7 +399,7 @@ config CPU_V6
> > >  config CPU_32v6K
> > >         bool "Support ARM V6K processor extensions" if !SMP
> > >         depends on CPU_V6
> > > -       default y if SMP && !ARCH_MX3
> > > +       default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> > >         help
> > >           Say Y here if your ARMv6 processor supports the 'K' extension.
> > >           This enables the kernel to use some instructions not present
> > > @@ -410,7 +410,7 @@ config CPU_32v6K
> > >  # ARMv7
> > >  config CPU_V7
> > >         bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> > > -       select CPU_32v6K
> > > +       select CPU_32v6K if !ARCH_OMAP2
> >
> > I suspect that would be an issue for all ARMv6 platforms without the MP
> > extensions (v6K). Could we do something like:
> >
> >       select CPU_32v6K if SMP || !CPU_V6
> 
> Hmm, but then we can't compile in SMP for single core systems and
> keep it bootable on single core v6?

Assuming that there is no issue with LDREX/STREX and the page
shareability attribute (or that we sort it out), there is also the TLS
register. The HAS_TLS_REG option gets enabled if SMP but I think that's
a v6K extension.

-- 
Catalin

