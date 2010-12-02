From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU
 bootup
Date: Thu, 02 Dec 2010 16:28:40 +0000
Message-ID: <1291307320.11271.51.camel@e102109-lin.cambridge.arm.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	 <20101130171658.GA24034@oksana.dev.rtsoft.ru>
	 <20101130233204.GB14383@n2100.arm.linux.org.uk>
	 <20101201002527.GC14383@n2100.arm.linux.org.uk>
	 <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
	 <20101202152428.GD10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101202152428.GD10461@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Jamie Iles <jamie.iles@picochip.com>, Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-12-02 at 15:24 +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 02, 2010 at 03:19:05PM +0000, Catalin Marinas wrote:
> > On 1 December 2010 00:25, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Tue, Nov 30, 2010 at 11:32:04PM +0000, Russell King - ARM Linux wrote:
> > >> Note that I'll go with factoring this out into arch/arm/kernel/smp_scu.c
> > >> for the time being, but I'm not convinced about the other parts yet.
> > >
> > > IOW, something like the attached.  I've gone a little further and removed
> > > the now unnecessary scu_enable() and scu_get_core_count() global functions,
> > > making scu_enable() static, and eliminating scu_get_core_count() entirely.
> >
> > There is some benefit in leaving get_core_count() in the platform
> > code. For example, the SCU on Cortex-A15 doesn't expose the core count
> > register and we have to get it from somewhere else (for now from some
> > L2 cache controller register but in the future it may be hardcoded,
> > passed via FDT or simply trying to boot maxcpus).
> 
> I notice that there's no way to tell what revision of SCU is implemented
> on _any_ mpcore platform.

C-A15 doesn't have any SCU registers exposed (and it's enabled by
default).

> In light of that, I think there's no point what so ever trying to
> consolidate this code - even the control register bits vary in
> unpredictable ways between different MPcore implementations.

The SCU is part of the core TRM, so I don't expect it to be the same
across various MP cores (and A15 is an example).

You may want to consolidate functions like scu_prepare_cpus (maybe call
it smp_prepare_cpus) and something that calls set_cpu_possible() but
with platform callbacks for getting the number of calls and initialising
the SMP (SCU for most platforms).

Whether this is worth, I don't know.

-- 
Catalin
