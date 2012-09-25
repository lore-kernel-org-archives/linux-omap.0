From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP: counter: add locking to read_persistent_clock
Date: Tue, 25 Sep 2012 13:13:14 +0530
Message-ID: <CAJ7qFSd89Ry9KmHSqB+r9YVZxjUA55MsW4RUBf6=8FSTzxOFsA@mail.gmail.com>
References: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
	<87d31bj5jq.fsf@deeprootsystems.com>
	<20120925012243.GR28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50455 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839Ab2IYHnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 03:43:15 -0400
Received: by vcbfo13 with SMTP id fo13so7281880vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 00:43:14 -0700 (PDT)
In-Reply-To: <20120925012243.GR28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Colin Cross <ccross@android.com>

Hi Tony,

[snip..]

>> > index dbf1e03..2bc51fb 100644
>> > --- a/arch/arm/plat-omap/counter_32k.c
>> > +++ b/arch/arm/plat-omap/counter_32k.c
>> > @@ -55,22 +55,29 @@ static u32 notrace omap_32k_read_sched_clock(void)
>> >   * nsecs and adds to a monotonically increasing timespec.
>> >   */
>> >  static struct timespec persistent_ts;
>> > -static cycles_t cycles, last_cycles;
>> > +static cycles_t cycles;
>> >  static unsigned int persistent_mult, persistent_shift;
>> > +static DEFINE_SPINLOCK(read_persistent_clock_lock);
>> > +
>> >  static void omap_read_persistent_clock(struct timespec *ts)
>> >  {
>> >     unsigned long long nsecs;
>> > -   cycles_t delta;
>> > -   struct timespec *tsp = &persistent_ts;
>> > +   cycles_t last_cycles;
>> > +   unsigned long flags;
>> > +
>> > +   spin_lock_irqsave(&read_persistent_clock_lock, flags);
>> >
>> >     last_cycles = cycles;
>> >     cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
>> > -   delta = cycles - last_cycles;
>> >
>> > -   nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
>> > +   nsecs = clocksource_cyc2ns(cycles - last_cycles,
>> > +                                   persistent_mult, persistent_shift);
>
> ..I think there's another bug here where cycles - last_cycles
> returns wrong value when the timer wraps around as cycles_t is
> 64 bits and the counter is 32 bits. It seems it's been there
> since when the read_persistent_clock was added with commit
> d92cfcbe (OMAP: timekeeping: time should not stop during suspend)?
>
> It seems that after this patch cycles should not be cycles_t
> but u32, and the result of cycles - last_cycles should also
> be u32.
>
 cycles_t is defined as  typedef unsigned long cycles_t;
 Am i missing something here ?

Thanks,
 Sricharan
