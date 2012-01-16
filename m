From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Mon, 16 Jan 2012 09:16:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A6A9D@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
 <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
 <20120113165003.GJ15299@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab2APJQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 04:16:37 -0500
In-Reply-To: <20120113165003.GJ15299@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 13, 2012 at 22:20:03, Tony Lindgren wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120113 06:08]:
> > On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com=
> wrote:
> > > On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
> > >> > =A0 ...
> > >> > =A0 };
> > >> >
> > >> > =A0 We need to have similar entries in all devices where 32K t=
imer is present.
> > >> >
> > >> > 2) OR simply add another cpu_is_am33xx() and then fall back to=
 dmtimer?
> > >> > =A0 Just to prove this, everything works here, I modified the =
code for this
> > >> > =A0 and tested it on both AM335x EVM and AM37xEVM and it works=
 fine for me.
> > >> >
> > >> >
> > >> > Any comments?? OR Better approach? OR anything which I am miss=
ing here?
>=20
> Why don't you just add a new entry to mach-omap2/timer.c using the OM=
AP_SYS_TIMER
> macro?
>=20
Tony,

The entry is already present in mach-olmap2/timer.c

OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
OMAP_SYS_TIMER(3_am33xx)


The issue is not related to this, more with respect to compile time=20
Code -

#ifdef CONFIG_OMAP_32K_TIMER
static void __init omap2_gp_clocksource_init(int unused, const char *du=
mmy)
{
	32K TIMER code
}
#else
static void __init omap2_gp_clocksource_init(int unused, const char *du=
mmy)
{
	DMTIMER code
}
#endif

Omap2plus_defconfig enabled option "CONFIG_OMAP_32K_TIMER", so from
Multi-omap point of view it will break AM335x.

Thanks,
Vaibhav

> See for example the omap3_secure timer set up. That should allow
> specifying the clock source already.
>=20
> Regards,
>=20
> Tony
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
