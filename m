From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 23:39:13 -0800
Message-ID: <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:18116 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab1AYHjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 02:39:15 -0500
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id p0P7dEC7024598
	for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 23:39:14 -0800
Received: from yia28 (yia28.prod.google.com [10.243.65.28])
	by wpaz9.hot.corp.google.com with ESMTP id p0P7dDZP007148
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 23:39:13 -0800
Received: by yia28 with SMTP id 28so2701119yia.15
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 23:39:13 -0800 (PST)
In-Reply-To: <20110124111114.GA19409@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 24, 2011 at 3:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 11:06:09AM +0000, Russell King - ARM Linux wr=
ote:
>> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
>> > In CPU low power state, local timer looses its register context. T=
his
>> > patch adds context save restore hooks which can be used by platfor=
ms
>> > appropriately.
>>
>> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the gene=
ric
>> timer stuff wouldn't rely on it being kept alive?
>>
>> Hmm, it looks like we bypass the clockevents code by only setting th=
e
>> TWD load value at initialization time, not when we switch to periodi=
c
>> mode. =A0We really ought to rewrite it whenever we switch back to pe=
riodic
>> mode.
>>
>> I suspect fixing that means you won't need this save/restore support=
=2E
>
> Untested, but should do what's required.
>
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index fd91566..60636f4 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -36,6 +36,7 @@ static void twd_set_mode(enum clock_event_mode mode=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* timer load already set up */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D TWD_TIMER_CONTROL_ENABLE | TW=
D_TIMER_CONTROL_IT_ENABLE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| TWD_TIMER_CONTROL_PE=
RIODIC;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(twd_timer_rate / HZ, twd_b=
ase + TWD_TIMER_LOAD);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case CLOCK_EVT_MODE_ONESHOT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* period set, and timer enabled in 'n=
ext_event' hook */
> @@ -81,7 +82,7 @@ int twd_timer_ack(void)
>
> =A0static void __cpuinit twd_calibrate_rate(void)
> =A0{
> - =A0 =A0 =A0 unsigned long load, count;
> + =A0 =A0 =A0 unsigned long count;
> =A0 =A0 =A0 =A0u64 waitjiffies;
>
> =A0 =A0 =A0 =A0/*
> @@ -116,10 +117,6 @@ static void __cpuinit twd_calibrate_rate(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("%lu.%02luMHz.\n", twd_timer_ra=
te / 1000000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(twd_timer_rate / 1000=
000) % 100);
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 load =3D twd_timer_rate / HZ;
> -
> - =A0 =A0 =A0 __raw_writel(load, twd_base + TWD_TIMER_LOAD);
> =A0}
>
> =A0/*

This doesn't work for oneshot timers if the TWD_TIMER_CONTROL register
gets reset by cpu idle between twd_set_mode and twd_set_next_event.
Shadowing ctrl in a percpu variable and rewriting it during every call
to twd_set_next_event does work, but that's not much different, and a
little less efficient, than just saving and restoring the control and
load registers in idle.  It does have the advantage that platforms
don't need any extra calls.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
