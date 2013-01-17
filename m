From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Thu, 17 Jan 2013 19:13:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com> <20130108203853.GB1876@animalcreek.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-190855126-1358450016=:14118"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42121 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab3AQTNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 14:13:37 -0500
In-Reply-To: <20130108203853.GB1876@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-190855126-1358450016=:14118
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Mark,

I regret the delay,

On Tue, 8 Jan 2013, Mark A. Greer wrote:

> On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
>
> > - The patch series causes AM3517/3505 to crash.  I'd guess this is due =
to=20
> > the SHAM/AES modules being initialized on those chips, but they probabl=
y=20
> > don't exist there.  Can you change the initialization for those on OMAP=
3=20
> > to only take place on OMAP34xx/36xx GP?  I guess you'd need to create n=
ew=20
> > lists for those in the hwmod init.
>=20
> All am35xx GPs have the SHAM and AES modules except some very old ones.
> I've been told that there should be very few of the "old" ones around
> (I don't know how to differentiate them).  We're likely safe since the
> SHAM & AES modules are not enabled in omap2plus_defconfig so nobody
> should be enabling them on an am35xx unless they know that they have
> the modules.  Do you agree?

Those will presumably only enable or disable the device drivers.  The=20
hwmod code will probably still try to write to those IP blocks if they are=
=20
listed as present in the hwmod data, during the initial reset-and-idle=20
phase.

What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] array to=
=20
omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the implicit=
=20
and possibly wrong assumption that it's likely to be ES1.0 devices that=20
are missing the SHAM/AES, but it seems unlikely that TI would have=20
multiple silicon revs running around claiming to be ES1.1?  Or maybe I'm=20
just being na=EFve.

> The issue that you're likely running into is that 'CK_AM35XX' needs to be
> added for aes2_ick & sha12_ick in cclock3xxx_data.c.   The following
> patch should fix it (applies to my submitted/crypto/hwmod branch):
>=20
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/=
cclock3xxx_data.c
> index 582b055..aa5bdf6 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3332,10 +3332,10 @@ static struct omap_clk omap3xxx_clks[] =3D {
>  =09CLK("omap_hsmmc.2",=09"ick",=09&mmchs3_ick,=09CK_3430ES2PLUS | CK_AM3=
5XX | CK_36XX),
>  =09CLK(NULL,=09"mmchs3_ick",=09&mmchs3_ick,=09CK_3430ES2PLUS | CK_AM35XX=
 | CK_36XX),
>  =09CLK(NULL,=09"icr_ick",=09&icr_ick,=09CK_34XX | CK_36XX),
> -=09CLK("omap-aes",=09"ick",=09=09&aes2_ick,=09CK_34XX | CK_36XX),
> -=09CLK(NULL,=09"aes2_ick",=09&aes2_ick,=09CK_34XX | CK_36XX),
> -=09CLK("omap-sham",=09"ick",=09&sha12_ick,=09CK_34XX | CK_36XX),
> -=09CLK(NULL,=09"sha12_ick",=09&sha12_ick,=09CK_34XX | CK_36XX),
> +=09CLK("omap-aes",=09"ick",=09=09&aes2_ick,=09CK_34XX | CK_AM35XX | CK_3=
6XX),
> +=09CLK(NULL,=09"aes2_ick",=09&aes2_ick,=09CK_34XX | CK_AM35XX | CK_36XX)=
,
> +=09CLK("omap-sham",=09"ick",=09&sha12_ick,=09CK_34XX | CK_AM35XX | CK_36=
XX),
> +=09CLK(NULL,=09"sha12_ick",=09&sha12_ick,=09CK_34XX | CK_AM35XX | CK_36X=
X),
>  =09CLK(NULL,=09"des2_ick",=09&des2_ick,=09CK_34XX | CK_36XX),
>  =09CLK("omap_hsmmc.1",=09"ick",=09&mmchs2_ick,=09CK_3XXX),
>  =09CLK("omap_hsmmc.0",=09"ick",=09&mmchs1_ick,=09CK_3XXX),
>=20
>=20
> Please let me know if this patch works for you and, if it does, I'll resp=
in
> my patches to add those changes.

If those clocks are referenced by the hwmods, that that patch makes sense=
=20
to me.  Haven't had the chance to test it yet but maybe tomorrow.  On the=
=20
other hand it looks 'obviously correct' so maybe just add that change to=20
your patches and repost that one?


- Paul
--843723315-190855126-1358450016=:14118--
