From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 23 Mar 2012 16:20:25 +0800
Message-ID: <CACVXFVPTsFY7UJMH5jZa16V0KYEZB=o7WRYqVEYyNJw1tMq-yw@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
	<CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A831823816@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40407 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab2CWIUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 04:20:25 -0400
Received: by pbcun15 with SMTP id un15so2345160pbc.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 01:20:25 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A831823816@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Wed, Mar 21, 2012 at 7:29 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> On Mon, Mar 19, 2012 at 17:14:30, Ming Lei wrote:
>> On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com>=
 wrote:
>> >
>> > I think you made very good point here. With the above patch, we ar=
e almost missing the capability of registering dmtimer as a clocksource=
 for OMAP.
>> > It will always use 32k-counter, and never fall back to dmtimer.
>> >
>> > Then the only options we have here is,
>> >
>> > 1) Register both the timers, 32k-counter and dmtimer for clocksour=
ce; let
>> > =A0 Kernel pick up best rating clocksource out of these two.
>> >
>> > =A0 In case of OMAP1/2/3/4, kernel will use dmtimer, since it has =
better
>> > =A0 Rating. User can choose the 32k-counter clocksource via bootar=
gs.
>> >
>> > =A0 Impact: without bootargs for clocksource selection, kernel wil=
l choose
>> > =A0 =A0 dmtimer, impacting loss of time during suspend/resume.
>> >
>> >
>> > 2) Let the current code be as is, means, the clocksource registrat=
ion will
>> > =A0 Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this opti=
on
>> > =A0 selection will be Controlled by Kconfig rules.
>>
>> How about the 3rd option?
>>
>> 3), take the way in your patch 1) at default, but will switch to
>> register dmtimer
>> directly and bypass 32k-counter if user need it via kernel parameter=
=2E
>>
>> As far as I can think of, the situations required for dmtimer are hi=
gh-frequency
>> perf sample and high precision trace points, so looks it is OK to ta=
ke
>> 32k-counter
>> at default.
>>
> But if you register both the timers (dmtimer & 32ksync), then initial=
ly kernel will only pick up dmtimer, as this has better rating. And lat=
e in

Looks not so, I found that 32ksync is always selected as the default
clocksource if both are registered.

> the boot sequence clocksource switch will happen, base on
> kernel parameter (clocksource=3D).
>
> So logically dmtimer will be always used as a default here.

Not so at least on my Pandaboard.


Thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
