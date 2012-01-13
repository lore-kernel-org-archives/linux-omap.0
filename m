From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 15:41:04 +0100
Message-ID: <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com> <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:34221 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752354Ab2AMOla convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 09:41:30 -0500
Received: by mail-qy0-f172.google.com with SMTP id c1so366197qcs.31
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 06:41:26 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
>> On Fri, Jan 13, 2012 at 1:21 PM, Hiremath, Vaibhav <hvaibhav@ti.com>=
 wrote:
>> > Hi,
>> >
>> > In case of AM33xx family of devices, we do not have 32K Sync timer
>> > (32K Counter) available; and the current implementation is based o=
n
>> > compile-time option, where clock-source is chosen by something lik=
e,
>> >
>> > File - arch/arm/mach-omap2/timer.c
>> >
>> > #ifdef CONFIG_OMAP_32K_TIMER
>> > static void __init omap2_gp_clocksource_init(int unused, const cha=
r *dummy)
>> > {
>> > ...
>> > }
>> > #else
>> > static void __init omap2_gp_clocksource_init(int unused, const cha=
r *dummy)
>> > {
>> > ...
>> > }
>> > #endif
>> >
>> >
>> > But in order to support multi-omap build, we must
>> > make run-time decision to use the timer for kernel clock-source, e=
ither of -
>> >
>> > =A0- DMTIMER
>> > =A0- 32K Sync Timer
>> >
>> > The DMTIMER is already migrated to the HWMOD framework, but 32K Ti=
mer code
>> > has not yet migrated to it. So the question here is,
>> >
>> > 1) Does it make sense to migrate counter_32k.c to search entry in =
hwmod
>> > =A0 table and if 32k_sync timer is available in hwmod table then u=
se 32K
>> > =A0 timer for Kernel clock-source
>> > =A0 OR
>> > =A0 Fall back to DMTIMER.
>> >
>> > =A0 OMAP4 hwmod table already has entry,
>> >
>> > =A0 static struct omap_hwmod omap44xx_counter_32k_hwmod =3D {
>> > =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "counter_32k",
>> > =A0 ...
>> > =A0 };
>> >
>> > =A0 We need to have similar entries in all devices where 32K timer=
 is present.
>> >
>> > 2) OR simply add another cpu_is_am33xx() and then fall back to dmt=
imer?
>> > =A0 Just to prove this, everything works here, I modified the code=
 for this
>> > =A0 and tested it on both AM335x EVM and AM37xEVM and it works fin=
e for me.
>> >
>> >
>> > Any comments?? OR Better approach? OR anything which I am missing =
here?
>> >
>> You can register both the clock sources together with different
>> rating. Based on rating
>> timer code will automatically pick the better clock-source of two.
>> Ratings is based on the resolution of the timer.
>>
> Santosh,
>
> =A0- Still current compile time implementation must be changed/cleane=
d, right?
Yes. But that should be trivial.

> =A0- The 32k timer doesn't exist at all on AM33xx device, so you can =
not
> =A0 (and should not) Register this timer.
>
Well there are many init call happens on various IP's which are not sup=
ported
across SOCs.

Look at L2X0 cache init for example. In such cases you just return by n=
ot
doing anything on that hardware IP.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
