From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPUbootup
Date: Mon, 6 Dec 2010 12:58:02 +0530
Message-ID: <a77f1800c9be01e7c81532a716b4e260@mail.gmail.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru> <20101130171658.GA24034@oksana.dev.rtsoft.ru>
 <20101130233204.GB14383@n2100.arm.linux.org.uk> <20101201002527.GC14383@n2100.arm.linux.org.uk>
 <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
 <20101202152428.GD10461@n2100.arm.linux.org.uk> <1291307320.11271.51.camel@e102109-lin.cambridge.arm.com>
 <20101202173824.GE10461@n2100.arm.linux.org.uk> <20101202180150.GF10461@n2100.arm.linux.org.uk>
 <20101204084815.GA20969@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34350 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990Ab0LFH2F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 02:28:05 -0500
In-Reply-To: <20101204084815.GA20969@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Jamie

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Saturday, December 04, 2010 2:18 PM
> To: Tony Lindgren; Kukjin Kim; Srinidhi Kasagar; Jamie Iles; Anton
> Vorontsov; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; Colin Cross; linux-tegra@vger.kernel.org; Uwe
Kleine-
> K=F6nig; linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead=
=2Eorg
> Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary
> CPUbootup
>
> On Thu, Dec 02, 2010 at 06:01:50PM +0000, Russell King - ARM Linux
wrote:
> > On Thu, Dec 02, 2010 at 05:38:24PM +0000, Russell King - ARM Linux
> wrote:
> > > What if a platform, for what ever reason, wants to have 3 CPUs,
> > > numbered 0, 2, 3 ?  That's the reason why the code which sets the
> > > possible and present maps isn't in the ARM core code - Eg, we don=
't
> > > know if a platform wants to keep CPU 1 in AMP mode to run some
> > > special software on it.
> > >
> > > I don't think it's worth it because I think trying to considate t=
his
> > > is going to cripple the code structure in the future.
> >
> > I don't think this is particularly worth it either:
>
> As Catalin has pointed out:
>
>
http://lists.arm.linux.org.uk/lurker/message/20101202.162840.5465758c.e=
n.h
> tml
>
> The SCU is part of the core, and if you consult the TRMs for the MPCo=
re
> devices, it is actually different in ARM11 MPCore vs Cortex-A9 MPCore=
=2E
> Cortex-A15 doesn't have a MMIO addressable SCU at all.
>
> So, this is about as far as I want to go with stripping out the commo=
n
> code from the various platforms (this includes my previous SMP series=
):
>
>
http://lists.arm.linux.org.uk/lurker/message/20101203.200746.31424430.e=
n.h
> tml
>
> This results in a net reduction of 242 LOC, as shown in the following
> diffstat:
>
>  arch/arm/include/asm/hardirq.h            |   18 ++
>  arch/arm/include/asm/mach/irq.h           |    2 +-
>  arch/arm/include/asm/smp.h                |   17 +-
>  arch/arm/include/asm/smp_mpidr.h          |   17 --
>  arch/arm/kernel/entry-armv.S              |    2 +-
>  arch/arm/kernel/fiq.c                     |    5 +-
>  arch/arm/kernel/head.S                    |   39 +++--
>  arch/arm/kernel/irq.c                     |   23 ++-
>  arch/arm/kernel/smp.c                     |  243
++++++++++++++++--------
> -----
>  arch/arm/mach-msm/include/mach/smp.h      |    4 +-
>  arch/arm/mach-omap2/omap-hotplug.c        |   14 +--
>  arch/arm/mach-omap2/omap-smp.c            |   66 ++------
>  arch/arm/mach-realview/hotplug.c          |   18 +--
>  arch/arm/mach-realview/include/mach/smp.h |    5 +-
>  arch/arm/mach-realview/platsmp.c          |   95 +++---------
>  arch/arm/mach-s5pv310/hotplug.c           |   18 +--
>  arch/arm/mach-s5pv310/include/mach/smp.h  |    5 +-
>  arch/arm/mach-s5pv310/platsmp.c           |   46 +-----
>  arch/arm/mach-tegra/hotplug.c             |   18 +--
>  arch/arm/mach-tegra/include/mach/smp.h    |   12 +--
>  arch/arm/mach-tegra/platsmp.c             |   33 +---
>  arch/arm/mach-ux500/hotplug.c             |   18 +--
>  arch/arm/mach-ux500/include/mach/smp.h    |    5 +-
>  arch/arm/mach-ux500/platsmp.c             |   57 ++-----
>  arch/arm/mach-vexpress/include/mach/smp.h |    5 +-
>  arch/arm/mach-vexpress/platsmp.c          |   54 ++-----
>  arch/arm/plat-omap/include/plat/smp.h     |    5 +-
>  27 files changed, 301 insertions(+), 543 deletions(-)
>
> Can someone also explain why OMAP uses different file naming from
everyone
> else?  It's annoying as (eg) arch/arm/*/platsmp.c for editing the
platform
> SMP support files gets everyone except OMAP.

Nothing specific Russell?.
Its just to keep in sync with the way other files are named
under omap directories. We could rename this if it helps.

Regards,
Ssantosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
