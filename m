From: Colin Cross <ccross@google.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Wed, 29 Jun 2011 09:57:18 -0700
Message-ID: <CAMbhsRSWh0j-ZUx0bVZYcK-+K=z1ywwofJws6P_vrru9U8NKHQ@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
	<CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
	<20110628234621.GD23312@n2100.arm.linux.org.uk>
	<CAMbhsRRBhT5YX6E4Nkyvns5YykqzqV3-g4JhR2KPcxBhj0ABww@mail.gmail.com>
	<20110629140059.GE23312@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:26892 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1F2Q5X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 12:57:23 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p5TGvJ0G004067
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 09:57:20 -0700
Received: from gxk1 (gxk1.prod.google.com [10.202.11.1])
	by wpaz29.hot.corp.google.com with ESMTP id p5TGtLRw004520
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 09:57:18 -0700
Received: by gxk1 with SMTP id 1so809302gxk.10
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 09:57:18 -0700 (PDT)
In-Reply-To: <20110629140059.GE23312@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, Jun 29, 2011 at 7:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 28, 2011 at 04:59:57PM -0700, Colin Cross wrote:
>> On Tue, Jun 28, 2011 at 4:46 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Jun 28, 2011 at 04:37:08PM -0700, Colin Cross wrote:
>> >> I don't think it affects bogomips - loops_per_jiffy can still be
>> >> calibrated and updated by cpufreq, udelay just wont use them.
>> >
>> > No, you can't avoid it. =A0__delay(), udelay(), and the global
>> > loops_per_jiffy are all linked together - for instance this is how
>> > the spinlock code has a 1s timeout:
>> >
>> > static void __spin_lock_debug(raw_spinlock_t *lock)
>> > {
>> > =A0 =A0 =A0 =A0u64 loops =3D loops_per_jiffy * HZ;
>> > =A0 =A0 =A0 =A0int print_once =3D 1;
>> >
>> > =A0 =A0 =A0 =A0for (;;) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < loops; i++) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (arch_spin_trylo=
ck(&lock->raw_lock))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret=
urn;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__delay(1);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >
>> > which goes wrong for all the same reasons you're pointing out abou=
t
>> > udelay(). =A0So just restricting your argument to udelay() is not
>> > realistic.
>> >
>>
>> True, there are a few other users of loops_per_jiffy and __delay, bu=
t
>> it looks like __spin_lock_debug is the only one worth worrying about=
,
>> and it's timing is not as critical as udelay - worst case here is th=
at
>> the warning occurs after 250 ms instead of 1s. =A0Leaving
>> loops_per_jiffy and __delay intact, and fixing udelay, would still b=
e
>> a net gain.
>
> Other users of loops_per_jiffy are incorrect in any case:

The same conclusion I came to on a quick scan of other uses of
loops_per_jiffy...

<snip>

> And strangely the major offender of this stuff are ARM drivers, not o=
ther
> peoples stuff and not stuff in drivers/staging.
>
> So I don't think its sane to ignore loops_per_jiffy and __delay, and =
just
> concentrate on udelay().

But this I don't understand.  Every other use I found of
loops_per_jiffy is incorrect and should be changed.  Fixing udelay now
would not make them any worse - they would stay just as broken as they
were, so there is no need to couple a fix to udelay with fixing other
users of loops_per_jiffy.  Why block a legitimate fix because some
other broken code uses a variable whose behavior would not change?

If you are requesting an alternate change that would allow __delay to
continue to be used to time loops while irqs are off and jiffies is
not being updated, but also allows loops_per_jiffy to change in the
middle of a loop, while not increasing the number of instructions
executed in __delay, I don't think that is possible.  You could
replace __delay with a function that tests against a timer, and
loops_per_jiffy with the frequency of the counter divided by HZ, but
that would limit your spinlock spins to the frequency of the counter -
1MHz on Tegra.

Are there ever other legitimate uses of loops_per_jiffy/__delay?  I
don't think even the spinlock_debug use is correct - the number of
instructions executed in the loop before the __delay call (I count 17)
is going to be much higher than the instructions in the __delay(1)
call (3 instructions).  The spinlock debug timeout is already going to
be much longer than expected.  It looks to me like the only legitimate
use of loops_per_jiffy is to calculate the number of loops and call
__delay(loops) (exactly what udelay does), the overhead of doing
anything else will swamp the __delay call.  spinlock debug can get
away with its incorrect usage, because it doesn't really care how long
the delay is, and must have a minimum overhead.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
