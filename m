From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU
	bootup
Date: Thu, 2 Dec 2010 15:24:28 +0000
Message-ID: <20101202152428.GD10461@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru> <20101130171658.GA24034@oksana.dev.rtsoft.ru> <20101130233204.GB14383@n2100.arm.linux.org.uk> <20101201002527.GC14383@n2100.arm.linux.org.uk> <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Jamie Iles <jamie.iles@picochip.com>, Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 02, 2010 at 03:19:05PM +0000, Catalin Marinas wrote:
> On 1 December 2010 00:25, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 30, 2010 at 11:32:04PM +0000, Russell King - ARM Linux =
wrote:
> >> Note that I'll go with factoring this out into arch/arm/kernel/smp=
_scu.c
> >> for the time being, but I'm not convinced about the other parts ye=
t.
> >
> > IOW, something like the attached. =A0I've gone a little further and=
 removed
> > the now unnecessary scu_enable() and scu_get_core_count() global fu=
nctions,
> > making scu_enable() static, and eliminating scu_get_core_count() en=
tirely.
>=20
> There is some benefit in leaving get_core_count() in the platform
> code. For example, the SCU on Cortex-A15 doesn't expose the core coun=
t
> register and we have to get it from somewhere else (for now from some
> L2 cache controller register but in the future it may be hardcoded,
> passed via FDT or simply trying to boot maxcpus).

I notice that there's no way to tell what revision of SCU is implemente=
d
on _any_ mpcore platform.

In light of that, I think there's no point what so ever trying to
consolidate this code - even the control register bits vary in
unpredictable ways between different MPcore implementations.

So we can't say "this is a SCU X and this is its register layout."

And really, having it undetectable except via DT (which from what I
can see, isn't happening any time soon) or via a command line argument
isn't acceptable.

So I think the idea of consolidating the SCU code is a lost cause.
