From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: OMAP: Add initialisation for the real-time
 counter.
Date: Tue, 14 Aug 2012 06:22:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA8E131@DBDE01.ent.ti.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
 <1344856045-15134-2-git-send-email-santosh.shilimkar@ti.com>
 <50293AC8.7010403@ti.com>
 <CAMQu2gw=W7J5Yy029XRb68H_J2yXYT9u93480vSr9J23C5jZ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60354 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab2HNGWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 02:22:13 -0400
In-Reply-To: <CAMQu2gw=W7J5Yy029XRb68H_J2yXYT9u93480vSr9J23C5jZ3g@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.orig" <linux-arm-kernel@lists.infradead.orig>, "tony@atomide.com" <tony@atomide.com>

On Tue, Aug 14, 2012 at 11:46:35, Shilimkar, Santosh wrote:
> On Mon, Aug 13, 2012 at 11:05 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> >
> >
> > On 8/13/2012 4:37 PM, Santosh Shilimkar wrote:
> > > The real time counter also called master counter, is a free-running
> > > counter. It produces the count used by the CPU local timer peripherals
> > > in the MPU cluster. The timer counts at a rate of 6.144 MHz.
> > >
> > > The ratio registers needs to be configured based on system clock
> > > only onetime. After initialisation, hardware takes care of adjusting
> > > the clock in different low power modes to keep counter rate constant.
> > >
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/Kconfig |    4 ++
> > >  arch/arm/mach-omap2/timer.c |   89
> > > ++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 92 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index dd2db02..2120f90 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -24,6 +24,9 @@ config ARCH_OMAP2PLUS_TYPICAL
> > >  config SOC_HAS_OMAP2_SDRC
> > >       bool "OMAP2 SDRAM Controller support"
> > >
> > > +config SOC_HAS_REALTIME_COUNTER
> > > +     bool "Real time free running counter"
> > > +
> > >  config ARCH_OMAP2
> > >       bool "TI OMAP2"
> > >       depends on ARCH_OMAP2PLUS
> > > @@ -69,6 +72,7 @@ config SOC_OMAP5
> > >       select CPU_V7
> > >       select ARM_GIC
> > >       select HAVE_SMP
> > > +     select SOC_HAS_REALTIME_COUNTER
> > >
> > >  comment "OMAP Core Type"
> > >       depends on ARCH_OMAP2
> > > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > > index 2ff6d41..9b17e6c 100644
> > > --- a/arch/arm/mach-omap2/timer.c
> > > +++ b/arch/arm/mach-omap2/timer.c
> > > @@ -69,6 +69,11 @@
> > >  #define OMAP3_SECURE_TIMER   1
> > >  #endif
> > >
> > > +#define REALTIME_COUNTER_BASE                                0x48243200
> > > +#define INCREMENTER_NUMERATOR_OFFSET                 0x10
> > > +#define INCREMENTER_DENUMERATOR_RELOAD_OFFSET                0x14
> > > +#define NUMERATOR_DENUMERATOR_MASK                   0xfffff000
> > > +
> > >  /* Clockevent code */
> > >
> > >  static struct omap_dm_timer clkev;
> > > @@ -339,6 +344,83 @@ static void __init omap2_clocksource_init(int
> > > gptimer_id,
> > >               omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> > >  }
> > >
> > > +#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
> > > +/*
> > > + * The realtime counter also called master counter, is a free-running
> > > + * counter, which is related to real time. It produces the count used
> > > + * by the CPU local timer peripherals in the MPU cluster. The timer
> > > counts
> > > + * at a rate of 6.144 MHz. Because the device operates on different
> > > clocks
> > > + * in different power modes, the master counter shifts operation
> > > between
> > > + * clocks, adjusting the increment per clock in hardware accordingly to
> > > + * maintain a constant count rate.
> > > + */
> > > +static void __init realtime_counter_init(void)
> > > +{
> > > +     void __iomem *base;
> > > +     static struct clk *sys_clk;
> > > +     unsigned long rate;
> > > +     unsigned int reg, num, den;
> > > +
> > > +     base = ioremap(REALTIME_COUNTER_BASE, SZ_32);
> > > +     if (!base) {
> > > +             pr_err("%s: ioremap failed\n", __func__);
> > > +             return;
> > > +     }
> > > +     sys_clk = clk_get(NULL, "sys_clkin_ck");
> > > +     if (!sys_clk) {
> > > +             pr_err("%s: failed to get system clock handle\n",
> > > __func__);
> > > +             return;
> >
> > Don't want to unmap the ioremap'ed space?
> >
> yep. Infact at the end of this function I wanted to unmap the
> space since this is one time init. Will fix that in next version.
> 
> > > +     }
> > > +
> > > +     rate = clk_get_rate(sys_clk);
> > > +     switch (rate) {
> > > +     case 1200000:
> > > +             num = 64;
> > > +             den = 125;
> > > +             break;
> > > +     case 1300000:
> > > +             num = 768;
> > > +             den = 1625;
> > > +             break;
> > > +     case 19200000:
> > > +             num = 8;
> > > +             den = 25;
> > > +             break;
> > > +     case 2600000:
> > > +             num = 384;
> > > +             den = 1625;
> > > +             break;
> > > +     case 2700000:
> > > +             num = 256;
> > > +             den = 1125;
> > > +             break;
> > > +     case 38400000:
> > > +             num = 4;
> > > +             den = 25;
> > > +             break;
> > > +     default:
> > > +             /* Program it for 38.4 MHz */
> > > +             num = 4;
> > > +             den = 25;
> > > +             break;
> >
> > You can simply do something like,
> >
> >         case 38400000:
> >         /* Program it for 38.4 MHz */
> >         default:
> >                 num = 4;
> >                 den = 25;
> >                 break;
> >
> Yes.
> 
> > Also, suggest to mention about why 38.4MHz as default? I believe it is
> > reset value, right?
> >
> This is the default sys clock rate assumed in most of the documentation
> and also expected to be a default sys clock rate. Reset values as you
> said in many other registers also assume 38.4 MHz.
> 
> > Also, does it make sense to get rid of hardcoded values above?
> >
> Actually not. Because the values are fixed since the counter
> clock-rate is hardwired to be 6.144 MHz and hence all the
> other numbers becomes constant. All these numbers are
> coming from TRM and not from any formula. I don't wanted
> to go on mathematical equation path since all the values
> are well documented.
> 

Yes, I looked at the TRM and they are well documented there.
I would atleast suggest you to state that, these values are coming directly 
from TRM and possibly give reference to the TRM section here.

Thanks,
Vaibhav
