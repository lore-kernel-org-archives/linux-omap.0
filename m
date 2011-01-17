From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 21:19:56 +0000
Message-ID: <20110117211956.GD4042@flint.arm.linux.org.uk>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com> <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com> <20110117203902.GC4042@flint.arm.linux.org.uk> <alpine.DEB.2.00.1101171341591.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1AQVUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 16:20:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101171341591.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 02:00:17PM -0700, Paul Walmsley wrote:
> On Mon, 17 Jan 2011, Russell King wrote:
> 
> > On Mon, Jan 17, 2011 at 01:31:47PM -0700, Paul Walmsley wrote:
> > > 
> > > OMAP15xx uses the MPU timer for its clocksource, since OMAP15xx doesn't 
> > > have GPTIMERs or the 32k sync timer, and the MPU timer code in 
> > > mach-omap1/time.c wasn't updated for sched_clock() support.
> > > 
> > > Adding an init_fixed_sched_clock() into omap_init_clocksource() should 
> > > fix the boot on OMAP15xx/7xx.
> > 
> > No, it needs fixing properly.  There's no reason the gpt clocksource
> > can't be used for sched_clock.
> 
> There's a very good reason why it can't on OMAP15xx/7xx.  GPTIMER/DMTIMER 
> IP blocks are only present on OMAP1610 and later[1].  Nor is a 
> SYNCTIMER_32K IP block present on OMAP15xx/7xx[2].

Yes I realise that.  That doesn't negate what I said though.  Let me
show you how to do it:

static DEFINE_CLOCK_DATA(cd);

static inline u32 32k_read_cycles(void)
{
...
}

static inline u32 gpt_read_cycles(void)
{
...
}


#if defined(GPTIMER) && defined(32KTIMER)
static u32 (*omap_read_cycles)(void);
#elif defined(32KTIMER)
#define SC_MULT			4000000000u
#define SC_SHIFT		17
#define omap_read_cycles	32k_read_cycles
#else
#define SC_MULT			gpt_value_if_fixed
#define SC_SHIFT		gpt_value_if_fixed
#define omap_read_cycles	gpt_read_cycles
#endif

unsigned long long notrace sched_clock(void)
{
	u32 cyc = omap_read_cycles();
#ifdef SC_MULT
	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
#else
	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
#endif
}

static void notrace omap_update_sched_clock(void)
{
	u32 cyc = omap_read_cycles();
	update_sched_clock(&cd, cyc, (u32)~0);
}

void omap_init_sched_clock(int gpt)
{
	unsigned long rate;

#ifndef omap_read_cycles
	omap_read_cycles = gpt ? gpt_read_cycles : 32k_read_cycles;
#endif

	if (gpt)
		rate = gpt_rate;
	else
		rate = 32768;

#ifdef SC_MULT
	init_fixed_sched_clock(&cd, omap_update_sched_clock, 32, rate
			       SC_MULT, SC_SHIFT);
#else
	init_sched_clock(&cd, omap_update_sched_clock, 32, rate);
#endif
}

Both a GPT _and_ 32K sched_clock implementation together, selectable
at runtime or build time depending on what is selected.  I'll give you
that it isn't nice code, but it does what's required.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
