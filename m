From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Wed, 21 Mar 2012 11:29:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831823816@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>	<87mx9ej8fp.fsf@ti.com>
	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51488 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab2CUL35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 07:29:57 -0400
In-Reply-To: <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Mon, Mar 19, 2012 at 17:14:30, Ming Lei wrote:
> On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
> >
> > I think you made very good point here. With the above patch, we are=
 almost missing the capability of registering dmtimer as a clocksource =
for OMAP.
> > It will always use 32k-counter, and never fall back to dmtimer.
> >
> > Then the only options we have here is,
> >
> > 1) Register both the timers, 32k-counter and dmtimer for clocksourc=
e; let
> > =A0 Kernel pick up best rating clocksource out of these two.
> >
> > =A0 In case of OMAP1/2/3/4, kernel will use dmtimer, since it has b=
etter
> > =A0 Rating. User can choose the 32k-counter clocksource via bootarg=
s.
> >
> > =A0 Impact: without bootargs for clocksource selection, kernel will=
 choose
> > =A0 =A0 dmtimer, impacting loss of time during suspend/resume.
> >
> >
> > 2) Let the current code be as is, means, the clocksource registrati=
on will
> > =A0 Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this optio=
n
> > =A0 selection will be Controlled by Kconfig rules.
>=20
> How about the 3rd option?
>=20
> 3), take the way in your patch 1) at default, but will switch to
> register dmtimer
> directly and bypass 32k-counter if user need it via kernel parameter.
>=20
> As far as I can think of, the situations required for dmtimer are hig=
h-frequency
> perf sample and high precision trace points, so looks it is OK to tak=
e
> 32k-counter
> at default.
>=20
But if you register both the timers (dmtimer & 32ksync), then initially=
 kernel will only pick up dmtimer, as this has better rating. And late =
in
the boot sequence clocksource switch will happen, base on=20
kernel parameter (clocksource=3D).

So logically dmtimer will be always used as a default here.

Thanks,
Vaibhav

> Thanks,
> --=20
> Ming Lei
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
