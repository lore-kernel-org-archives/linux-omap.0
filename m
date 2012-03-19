From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Mon, 19 Mar 2012 19:44:30 +0800
Message-ID: <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53015 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab2CSLoa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 07:44:30 -0400
Received: by dajr28 with SMTP id r28so9810062daj.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 04:44:30 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
> I think you made very good point here. With the above patch, we are a=
lmost missing the capability of registering dmtimer as a clocksource fo=
r OMAP.
> It will always use 32k-counter, and never fall back to dmtimer.
>
> Then the only options we have here is,
>
> 1) Register both the timers, 32k-counter and dmtimer for clocksource;=
 let
> =A0 Kernel pick up best rating clocksource out of these two.
>
> =A0 In case of OMAP1/2/3/4, kernel will use dmtimer, since it has bet=
ter
> =A0 Rating. User can choose the 32k-counter clocksource via bootargs.
>
> =A0 Impact: without bootargs for clocksource selection, kernel will c=
hoose
> =A0 =A0 dmtimer, impacting loss of time during suspend/resume.
>
>
> 2) Let the current code be as is, means, the clocksource registration=
 will
> =A0 Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this option
> =A0 selection will be Controlled by Kconfig rules.

How about the 3rd option?

3), take the way in your patch 1) at default, but will switch to
register dmtimer
directly and bypass 32k-counter if user need it via kernel parameter.

As far as I can think of, the situations required for dmtimer are high-=
frequency
perf sample and high precision trace points, so looks it is OK to take
32k-counter
at default.

Thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
