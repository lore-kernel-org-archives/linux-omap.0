From: Paul Walmsley <paul@pwsan.com>
Subject: Re: AM3505/3517 support
Date: Thu, 7 Jul 2011 03:14:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070240350.30028@utopia.booyaka.com>
References: <4E121485.6060700@8d.com> <20110705111952.GG5783@atomide.com> <4E132143.7040802@8d.com> <20110706065605.GK5783@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-56793464-1310029117=:30028"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35027 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1GGJO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 05:14:56 -0400
In-Reply-To: <20110706065605.GK5783@atomide.com>
Content-ID: <alpine.DEB.2.00.1107070259210.30028@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-15?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-56793464-1310029117=:30028
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1107070259211.30028@utopia.booyaka.com>

On Tue, 5 Jul 2011, Tony Lindgren wrote:

> * Rapha=EBl Ass=E9nat <raph@8d.com> [110705 07:30]:
> > On 05/07/11 07:19 AM, Tony Lindgren wrote:
> > > * Rapha=EBl Ass=E9nat <raph@8d.com> [110704 12:51]:
> > >>
> > >> The am3505 is apparently so similar to the 3430 that it was treated =
as such=20
> > >> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There are how=
ever a
> > >> few differences that need to be addressed. I have therefore created =
a new
> > >> CHIP_IS and patched clocks, hwmod and power management related files
> > >> consequently. My system now boots until it complains that it is unab=
le=20
> > >> to mount its root filesystem.
> > >=20
> > > Can you please describe where you need CHIP_IS for am3505? It seems t=
hat
> > > your patches just enable the same CHIP_IS_OMAP3430 features for am350=
5 too?
> >
> > Actually it's only needed for the 3505/3517 specific UART 4 which shoul=
d
> > not be registered on real OMAP3430's. (see struct omap_hwmod=20
> > am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)
> >=20
> > But there are also cases where OMAP3430 hwmods must not be registered
> > on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 does
> > not exist general purpose AM3505's.
>=20
> Sounds like we should be able to handle both uart and gptimer12 the same =
way
> as we'll be handling the hwmod reset for special cases like gptimer12 for
> secure mode. So addding Paul to Cc.

So the idea would be to mark those devices as unavailable from the board=20
file?

It sounds possible, but AM35xx also has some devices that are not present=
=20
on 34xx chips, like the VPFE, EMAC, and HECC.  And there are probably some=
=20
other devices that are present on 34xx that are not present on AM35xx,=20
like SSI, MSPRO, D2D, etc.

I'd suggest adding a separate CHIP_IS_* for those AM35xx chips, as it=20
sounds like Rapha=EBl has done, since they are different silicon, unlike th=
e=20
34xx HS and GP chips, which just have some eFuse differences.

=2E..

This is a bit of a side issue, but right now, the CHIP_IS_* macros are=20
kind of messed up for OMAP3.  That CHIP_IS_OMAP3430 macro is the main=20
problem.  The different CHIP_IS_OMAP* bits were intended to be mutually=20
exclusive, so only one bit would be set at runtime for a given SoC.  Then=
=20
superset definitions would be defined as combinations of those bits, for=20
use with data structures that are common to multiple OMAP3 SoCs.  We do=20
this the right way with OMAP2 and OMAP4, just not with OMAP3.

I have a patch for this, but part of it involves renaming some=20
CHIP_IS_OMAP3430 to CHIP_IS_OMAP3XXX, so I've been hesitant to post it --=
=20
sounds like that would be grounds for flaming?  Or maybe it can be posted=
=20
as a 'cleanup' patch for the 3.2 time frame?

> Basically we can have a am35xx specific arch_initcall that sets the speci=
al
> flags for these devices like noreset, disabled or unavailable.
>=20
> In this case we would just set some devices as unavailable on am35xx.
> =20
> > > I'd rather see us improve the code so we can support am3505 properly =
without
> > > a need to patch all over the place..
> > Maybe instead of having one big array of hwmods registered for
> > all CPUs in omap_hwmod_3xxx_data we could have a separate
> > one for am35xx (and maybe, eventually others) such as:
> >=20
> > static __initdata struct omap_hwmod *omap3xxx_hwmods[]
> > static __initdata struct omap_hwmod *am35xx_hwmods[]
> >=20
> > ...and maybe also a 'common' array.
> >=20
> > The init function would then register the appropriate hwmod array(s). T=
he only=20
> > thing I don't like is that for this to work we would have to keep setti=
ng=20
> > CHIP_IS_OMAP3430 even on AM35xx CPUs. But maybe we could change the beh=
aviour of
> > omap_hwmod_register to trust the caller and accept the hwmods without l=
ooking=20
> > at the omap_chip member. By doing this I think we could drop all the=20
> > .omap_chip =3D OMAP_CHIP_INIT(...) instances.

For what it's worth, there are some patches here that are 3.2 material=20
that hopefully will make it easier to share hwmod data between different=20
chips with large portions that are similar.

> > Otherwise I think the current approach, despite the size of the initial=
 patch,
> > has at least the benefit of being explicit and less confusing than (ab)=
using the
> > CHIP_IS from a different CPU.
>=20
> Well let's see how far we can get with passing the special case flags wit=
h
> omap2_init_devices(). Initially we can call that from the board-*.c file
> that should get your board booting. Then we can add the am35xx specific
> arch_initcall.


- Paul
--155748971-56793464-1310029117=:30028--
