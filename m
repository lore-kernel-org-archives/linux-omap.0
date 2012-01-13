From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 14:57:35 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A51E9@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
 <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab2AMO54 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 09:57:56 -0500
In-Reply-To: <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 13, 2012 at 20:11:04, Shilimkar, Santosh wrote:
> On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> =
wrote:
> > On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
> >> On Fri, Jan 13, 2012 at 1:21 PM, Hiremath, Vaibhav <hvaibhav@ti.co=
m> wrote:
> >> > Hi,
> >> >
> >> > In case of AM33xx family of devices, we do not have 32K Sync tim=
er
> >> > (32K Counter) available; and the current implementation is based=
 on
> >> > compile-time option, where clock-source is chosen by something l=
ike,
> >> >
> >> > File - arch/arm/mach-omap2/timer.c
> >> >
> >> > #ifdef CONFIG_OMAP_32K_TIMER
> >> > static void __init omap2_gp_clocksource_init(int unused, const c=
har *dummy)
> >> > {
> >> > ...
> >> > }
> >> > #else
> >> > static void __init omap2_gp_clocksource_init(int unused, const c=
har *dummy)
> >> > {
> >> > ...
> >> > }
> >> > #endif
> >> >
> >> >
> >> > But in order to support multi-omap build, we must
> >> > make run-time decision to use the timer for kernel clock-source,=
 either of -
> >> >
> >> > =A0- DMTIMER
> >> > =A0- 32K Sync Timer
> >> >
> >> > The DMTIMER is already migrated to the HWMOD framework, but 32K =
Timer code
> >> > has not yet migrated to it. So the question here is,
> >> >
> >> > 1) Does it make sense to migrate counter_32k.c to search entry i=
n hwmod
> >> > =A0 table and if 32k_sync timer is available in hwmod table then=
 use 32K
> >> > =A0 timer for Kernel clock-source
> >> > =A0 OR
> >> > =A0 Fall back to DMTIMER.
> >> >
> >> > =A0 OMAP4 hwmod table already has entry,
> >> >
> >> > =A0 static struct omap_hwmod omap44xx_counter_32k_hwmod =3D {
> >> > =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "counter_32k",
> >> > =A0 ...
> >> > =A0 };
> >> >
> >> > =A0 We need to have similar entries in all devices where 32K tim=
er is present.
> >> >
> >> > 2) OR simply add another cpu_is_am33xx() and then fall back to d=
mtimer?
> >> > =A0 Just to prove this, everything works here, I modified the co=
de for this
> >> > =A0 and tested it on both AM335x EVM and AM37xEVM and it works f=
ine for me.
> >> >
> >> >
> >> > Any comments?? OR Better approach? OR anything which I am missin=
g here?
> >> >
> >> You can register both the clock sources together with different
> >> rating. Based on rating
> >> timer code will automatically pick the better clock-source of two.
> >> Ratings is based on the resolution of the timer.
> >>
> > Santosh,
> >
> > =A0- Still current compile time implementation must be changed/clea=
ned, right?
> Yes. But that should be trivial.
>=20
> > =A0- The 32k timer doesn't exist at all on AM33xx device, so you ca=
n not
> > =A0 (and should not) Register this timer.
> >
> Well there are many init call happens on various IP's which are not s=
upported
> across SOCs.
>=20
> Look at L2X0 cache init for example. In such cases you just return by=
 not
> doing anything on that hardware IP.
>=20

Is "just return" happening through cpu_is_xxxx() check? I can see,

static int __init omap_l2_cache_init(void)
{
   ...
         /*
          * To avoid code running on other OMAPs in
          * multi-omap builds
          */
         if (!cpu_is_omap44xx())
                 return -ENODEV;
   ...
}


If yes, then, doesn't 'hwmod lookup' (may be DT in future) sound=20
much better option?

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
