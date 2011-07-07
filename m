From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3505/3517 support
Date: Thu, 7 Jul 2011 14:54:46 +0300
Message-ID: <20110707115433.GE15815@atomide.com>
References: <4E121485.6060700@8d.com>
 <20110705111952.GG5783@atomide.com>
 <4E132143.7040802@8d.com>
 <20110706065605.GK5783@atomide.com>
 <alpine.DEB.2.00.1107070240350.30028@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56077 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755764Ab1GGLyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 07:54:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107070240350.30028@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?utf-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110707 12:09]:
> On Tue, 5 Jul 2011, Tony Lindgren wrote:
>=20
> > * Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110705 07:30]:
> > > On 05/07/11 07:19 AM, Tony Lindgren wrote:
> > > > * Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110704 12:51]:
> > > >>
> > > >> The am3505 is apparently so similar to the 3430 that it was tr=
eated as such=20
> > > >> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There a=
re however a
> > > >> few differences that need to be addressed. I have therefore cr=
eated a new
> > > >> CHIP_IS and patched clocks, hwmod and power management related=
 files
> > > >> consequently. My system now boots until it complains that it i=
s unable=20
> > > >> to mount its root filesystem.
> > > >=20
> > > > Can you please describe where you need CHIP_IS for am3505? It s=
eems that
> > > > your patches just enable the same CHIP_IS_OMAP3430 features for=
 am3505 too?
> > >
> > > Actually it's only needed for the 3505/3517 specific UART 4 which=
 should
> > > not be registered on real OMAP3430's. (see struct omap_hwmod=20
> > > am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)
> > >=20
> > > But there are also cases where OMAP3430 hwmods must not be regist=
ered
> > > on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 doe=
s
> > > not exist general purpose AM3505's.
> >=20
> > Sounds like we should be able to handle both uart and gptimer12 the=
 same way
> > as we'll be handling the hwmod reset for special cases like gptimer=
12 for
> > secure mode. So addding Paul to Cc.
>=20
> So the idea would be to mark those devices as unavailable from the bo=
ard=20
> file?
>=20
> It sounds possible, but AM35xx also has some devices that are not pre=
sent=20
> on 34xx chips, like the VPFE, EMAC, and HECC.  And there are probably=
 some=20
> other devices that are present on 34xx that are not present on AM35xx=
,=20
> like SSI, MSPRO, D2D, etc.

I suggested to do this initially from board-*.c file to get the board b=
ooting.
But in the long run this could fixed up with an am35xx arch_initcall li=
ke
I suggested where the arch_initcall would set up the am35xx specific de=
vices.
=20
> I'd suggest adding a separate CHIP_IS_* for those AM35xx chips, as it=
=20
> sounds like Rapha=C3=ABl has done, since they are different silicon, =
unlike the=20
> 34xx HS and GP chips, which just have some eFuse differences.

The problem is that we're really talking about a very similar chip to o=
ther
omap3 chips. To me it seems something is wrong if we have to patch all =
over
where the CHIP_IS_* is being used just to add support for a slightly di=
fferent
chip variant. Whatever we need to do we should be able to dynamically b=
ased on
the SoC features detected.
=20
> ...
>=20
> This is a bit of a side issue, but right now, the CHIP_IS_* macros ar=
e=20
> kind of messed up for OMAP3.  That CHIP_IS_OMAP3430 macro is the main=
=20
> problem.  The different CHIP_IS_OMAP* bits were intended to be mutual=
ly=20
> exclusive, so only one bit would be set at runtime for a given SoC.  =
Then=20
> superset definitions would be defined as combinations of those bits, =
for=20
> use with data structures that are common to multiple OMAP3 SoCs.  We =
do=20
> this the right way with OMAP2 and OMAP4, just not with OMAP3.
>=20
> I have a patch for this, but part of it involves renaming some=20
> CHIP_IS_OMAP3430 to CHIP_IS_OMAP3XXX, so I've been hesitant to post i=
t --=20
> sounds like that would be grounds for flaming?  Or maybe it can be po=
sted=20
> as a 'cleanup' patch for the 3.2 time frame?

Well let's fix things properly so we only need minimal patching to add =
proper
am3505 and 4460 support. If that means renaming something then let's do=
 it.

But if it still means that we again have to patch the CHIP_IS all over =
the
place for future omaps, then we really need a better way to fix this.

How about if we just had a list for each SoC that listed the devices it=
 has?

Then adding support for a new SoC would be just a question of initializ=
ing
the list and adding the new devices. Patching existing devices would no=
t
be needed in that case, and CHIP_IS would only be need to be initialize=
d
in one place instead of repeating it for each device.

Regards,

Tony
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
