From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: fix oops in sched_clock_poll
Date: Thu, 20 Jan 2011 12:35:22 +0800
Message-ID: <AANLkTik-cxbwZZ_PfuC8DKqyHSnUM+R56PNXJdrPqSCb@mail.gmail.com>
References: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
	<20110119165602.GA6335@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:38910 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1ATEfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 23:35:24 -0500
Received: by wwi17 with SMTP id 17so1032796wwi.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 20:35:22 -0800 (PST)
In-Reply-To: <20110119165602.GA6335@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org

Hi,

2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jan 20, 2011 at 12:47:21AM +0800, tom.leiming@gmail.com wrote=
:
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> The patch fixes one oops in sched_clock_poll, tested on
>> beagle xm, follows the oops message:
>
>> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_c=
lock.c
>> index 9a46370..782dd08 100644
>> --- a/arch/arm/kernel/sched_clock.c
>> +++ b/arch/arm/kernel/sched_clock.c
>> @@ -21,7 +21,9 @@ static void (*sched_clock_update_fn)(void);
>> =A0static void sched_clock_poll(unsigned long wrap_ticks)
>> =A0{
>> =A0 =A0 =A0 mod_timer(&sched_clock_timer, round_jiffies(jiffies + wr=
ap_ticks));
>> - =A0 =A0 sched_clock_update_fn();
>> +
>> + =A0 =A0 if (sched_clock_update_fn)
>> + =A0 =A0 =A0 =A0 =A0 =A0 sched_clock_update_fn();
>
> It's called here because it's supposed to be initialized by the time =
this
> function is called. =A0Please ensure that is the case.

On omap2,  sched_clock_update_fn is initialized in omap_init_clocksourc=
e_32k,
and certainly is after calling sched_clock_poll, so the oops is trigger=
ed.


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
