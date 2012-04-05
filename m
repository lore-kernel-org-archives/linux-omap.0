From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Thu, 5 Apr 2012 09:36:00 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
 <4F7570FC.8000907@ti.com>
 <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
 <CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
 <CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
 <CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
 <CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
 <CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
 <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
 <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45685 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab2DEJgf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 05:36:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Russell King <rmk@arm.linux.org.uk>

On Wed, Apr 04, 2012 at 16:09:51, Hiremath, Vaibhav wrote:
> On Wed, Apr 04, 2012 at 14:34:09, Shilimkar, Santosh wrote:
> > On Tue, Apr 3, 2012 at 9:05 PM, Hiremath, Vaibhav <hvaibhav@ti.com>=
 wrote:
> > > On Tue, Apr 03, 2012 at 00:05:38, Hilman, Kevin wrote:
> > >> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> > >>
> > >> [...]
> > >>
> > >> > I don't personally like to add features which hardly anybody u=
se and
> > >> > fundamentally broken with full kernel.
> > >>
> > >> Let's keep sane defaults, but not make it unreasonable to tweak =
eaither.
> > >>
> > >> I suggest what has already been mentioned.
> > >>
> > >> Register both timers, but have the sync timer have a higher rati=
ng. =A0On
> > >> AMxxx where there is no sync timer, GPtimer will be used.
> > >>
> > >
> > > This is another good option, I can change the rating of both the =
timers.
> > > With below description and given understanding/discussion/usabili=
ty of both
> > > the timers, we can reverse the rating,
> > >
> > Btw, if we are going with this path, then there won't any need of c=
ommandline
> > option since clock-source can be switched from user space as well.
> >=20
>=20
> Yes, both the options will be open now and its upto user how he want =
to=20
> choose it (either bootargs or sysfs).
>=20

Santosh, Kevin and others (may be Russell can comment/conform),

Unfortunately, I am still struggling to get final patch out of this=20
discussion,

Although now we concluded on changing the rates for 32ksync (rating =3D=
 300)=20
and gptmier (rating =3D 250), and we thought kernel will choose better=20
clocksource automatically, in default case it would be 32ksync_counter,=
 and=20
that is what we want; and user can use bootargs to override the clockso=
urce=20
to gptimer.

But we all missed on "setup_sched_clock()", which is dependent on clock=
=20
=46requency, and based on that whole sched_clock() function works.

In case of 32ksync_counter:
--------------------------
cd.mult - 4000000000, cd.shift - 17
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 13107199=
9ms

In case of gptimer:
--------------------------
cd.mult - 2581110154, cd.shift - 26
sched_clock: 32 bits at 26MHz, resolution 38ns, wraps every 165191ms

Also, in addition to this,

 - We do not have any API available in sched_clock code to update the=20
   mult/shift factors.

 - You supposed to not call setup_sched_clock() multiple times, it dump=
s=20
   whole stack with,

   WARN_ON(read_sched_clock !=3D jiffy_sched_clock_read);

 - In case, user pass "clocksource=3D"gp timer" in bootargs, still init=
ially
   Kernel is going to use 32ksync_counter as a clocksource and the late=
 in=20
   the boot sequence it will switch to gptimer.

   [    0.637512] Switching to clocksource gp timer


There seems to be limitation for ARM architecture, it is restricted by
sched_clock implementation present in "arch/arm/kernel/sched_clock.c".
Natively, clocksource framework does support change in rate/frequency f=
or
registered timer, using,

   - __clocksource_updatefreq_scale()
   - __clocksource_updatefreq_hz()
   - __clocksource_updatefreq_khz()


May be I am missing something here, so far this is what my understandin=
g is,=20
I am still digging through the code to understand how best we can handl=
e=20
this. And also, I wouldn't want to again create our own sched_clock=20
interface.

May be Russell can help me to conform my understanding here.


Coming back to our actual problem of registering 2 clocksources, with a=
ll=20
above things, I am slowly moving towards keeping CONFIG_OMAP_32K_TIMER=20
config option and use compile time option for this (original approach) =
along=20
with hwmod detection, so that it can be reused for devices like AM33xx.

Code implementation will be,

#ifdef CONFIG_OMAP_32K_TIMER
	oh =3D omap_hwmod_lookup(oh_name);
	if (oh && oh->slaves_cnt !=3D 0) {
		u32 pbase;
		unsigned long size;
		struct resource mem_rsrc;
=09
		res =3D omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM,
					NULL, &mem_rsrc);
		if (!res) {
			pbase =3D mem_rsrc.start + 0x10;
			size =3D mem_rsrc.end - mem_rsrc.start;
			res =3D omap_init_clocksource_32k(pbase, size);
			if (!res)
				return;
	}
}
#endif

	/* Fall back to gp-timer code */
	res =3D omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
	BUG_ON(res);

	__omap_dm_timer_load_start(&clksrc,
			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);

	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);

	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
		pr_err("Could not register clocksource %s\n",
						clocksource_gpt.name);
	else
		pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
						gptimer_id, clksrc.rate);


Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
