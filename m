From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Wed, 28 Mar 2012 14:16:13 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab2C1OQc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 10:16:32 -0400
In-Reply-To: <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Wed, Mar 21, 2012 at 19:30:01, Shilimkar, Santosh wrote:
> On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
> > On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
> >> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> >> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.=
com> wrote:
> >> >>
> >> >> I think you made very good point here. With the above patch, we=
 are almost missing the capability of registering dmtimer as a clocksou=
rce for OMAP.
> >> >> It will always use 32k-counter, and never fall back to dmtimer.
> >> >>
> >> >> Then the only options we have here is,
> >> >>
> >> >> 1) Register both the timers, 32k-counter and dmtimer for clocks=
ource; let
> >> >> =A0 Kernel pick up best rating clocksource out of these two.
> >> >>
> >> >> =A0 In case of OMAP1/2/3/4, kernel will use dmtimer, since it h=
as better
> >> >> =A0 Rating. User can choose the 32k-counter clocksource via boo=
targs.
> >> >>
> >> >> =A0 Impact: without bootargs for clocksource selection, kernel =
will choose
> >> >> =A0 =A0 dmtimer, impacting loss of time during suspend/resume.
> >> >>
> >> This is the right option. The problem is gptimer clocksource
> >> doesn't work across power transitions and hence it is broken.
> >>
> >> Even for the perf, with PM enabled, dmtimer can't be used or it ne=
eds
> >> to be used with 32KHz clock which makes it no better than sync tim=
er.
> >>
> >> So here keeping 32K sync timer is default clocksource makes sense =
since
> >> it is the only working and viable option.
> >>
> >> So what can be done is register both 32K and gptimer together but =
make
> >> gptimer clocksource registration depends on PM enabled.
> >>
> >> This should solve all the needs I guess.
> >>
> >
> > I am not sure this will work on all platforms, for example, AM33XX,=
 where
> > We do not have 32ksync timer available, but we need PM support. Als=
o, I
> > personally think, we should not again use compile time option here.
> >
> Why not ?
> If 32ksync timer is not available, don't register it. Then in AM case
> you just have one clock-source.=20

In case of AM33xx, what about kernel without PM support?
As clocksource registration would be dependent on PM option, it won't w=
ork.

> I am against the idea of making
> gptimer as the default and asking user to choose sync32k from
> command-line.
>=20

I understand your concern here.


> Btw, if you need PM, how are you going to use GPTIMER
> as a clocksource. Note sys-clock is generally stopped in
> low power states. So that leaves you option with using
> gptimer with 32K clock and in that case, GPTIMER
> is not a better clock-source compare to 32K sync timer
> and so shouldn't be the rating.
>=20

AM33xx has GPTIMER1 in wakeup domain, so that we are already using as a
Clocksource, without any issues.

Thanks,
Vaibhav

> Regards
> Santosh
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
