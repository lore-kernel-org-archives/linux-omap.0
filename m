From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3505/3517 support
Date: Tue, 5 Jul 2011 23:56:05 -0700
Message-ID: <20110706065605.GK5783@atomide.com>
References: <4E121485.6060700@8d.com>
 <20110705111952.GG5783@atomide.com>
 <4E132143.7040802@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14887 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752499Ab1GFG4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 02:56:08 -0400
Content-Disposition: inline
In-Reply-To: <4E132143.7040802@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110705 07:30]:
> On 05/07/11 07:19 AM, Tony Lindgren wrote:
> > * Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110704 12:51]:
> >>
> >> The am3505 is apparently so similar to the 3430 that it was treate=
d as such=20
> >> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There are h=
owever a
> >> few differences that need to be addressed. I have therefore create=
d a new
> >> CHIP_IS and patched clocks, hwmod and power management related fil=
es
> >> consequently. My system now boots until it complains that it is un=
able=20
> >> to mount its root filesystem.
> >=20
> > Can you please describe where you need CHIP_IS for am3505? It seems=
 that
> > your patches just enable the same CHIP_IS_OMAP3430 features for am3=
505 too?
>
> Actually it's only needed for the 3505/3517 specific UART 4 which sho=
uld
> not be registered on real OMAP3430's. (see struct omap_hwmod=20
> am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)
>=20
> But there are also cases where OMAP3430 hwmods must not be registered
> on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 does
> not exist general purpose AM3505's.

Sounds like we should be able to handle both uart and gptimer12 the sam=
e way
as we'll be handling the hwmod reset for special cases like gptimer12 f=
or
secure mode. So addding Paul to Cc.

Basically we can have a am35xx specific arch_initcall that sets the spe=
cial
flags for these devices like noreset, disabled or unavailable.

In this case we would just set some devices as unavailable on am35xx.
=20
> > I'd rather see us improve the code so we can support am3505 properl=
y without
> > a need to patch all over the place..
> Maybe instead of having one big array of hwmods registered for
> all CPUs in omap_hwmod_3xxx_data we could have a separate
> one for am35xx (and maybe, eventually others) such as:
>=20
> static __initdata struct omap_hwmod *omap3xxx_hwmods[]
> static __initdata struct omap_hwmod *am35xx_hwmods[]
>=20
> ...and maybe also a 'common' array.
>=20
> The init function would then register the appropriate hwmod array(s).=
 The only=20
> thing I don't like is that for this to work we would have to keep set=
ting=20
> CHIP_IS_OMAP3430 even on AM35xx CPUs. But maybe we could change the b=
ehaviour of
> omap_hwmod_register to trust the caller and accept the hwmods without=
 looking=20
> at the omap_chip member. By doing this I think we could drop all the=20
> .omap_chip =3D OMAP_CHIP_INIT(...) instances.
>=20
> Otherwise I think the current approach, despite the size of the initi=
al patch,
> has at least the benefit of being explicit and less confusing than (a=
b)using the
> CHIP_IS from a different CPU.

Well let's see how far we can get with passing the special case flags w=
ith
omap2_init_devices(). Initially we can call that from the board-*.c fil=
e
that should get your board booting. Then we can add the am35xx specific
arch_initcall.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
