From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
 file
Date: Thu, 4 Nov 2010 15:45:17 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
 <AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079Ab0KDKPa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 06:15:30 -0400
In-Reply-To: <AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Thursday, November 04, 2010 3:22 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-=
arm-
> kernel@lists.infradead.org; Artem.Bityutskiy@nokia.com; Vimal Singh; =
Tony
> Lindgren
> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from
> board file
>=20
> On Thu, Nov 4, 2010 at 3:02 AM, Ghorai, Sukumar <s-ghorai@ti.com> wro=
te:
> >> -----Original Message-----
> >> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> >> Sent: Wednesday, November 03, 2010 6:33 PM
> >> To: Ghorai, Sukumar
> >> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; lin=
ux-
> arm-
> >> kernel@lists.infradead.org; Vimal Singh; Artem.Bityutskiy@nokia.co=
m
> >> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select f=
rom
> >> board file
> >>
> >> On Mon, Sep 27, 2010 at 5:11 PM, Sukumar Ghorai <s-ghorai@ti.com>
> wrote:
> >> > This patch makes it possible to select sw or hw (different layou=
t
> >> options)
> >> > ecc scheme supported by omap nand driver. =A0And hw ecc layout s=
elected
> >> for
> >> > sdp and zoom boards, by default.
> >> >
> >> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> >> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> >>
> >> Any news on this? Commit 2c01946c accidentally (?) enabled hardwar=
e
> >> ECC and now my board is broken, as the driver always used sw ecc a=
nd
> >> my NAND partitions are formatted accordingly. We should at least
> >> switch the default back to sw ecc, don't you think?
> > [Ghorai]
> > 1. which board you are working.
> > 2. and the default layout is the same as previous
> > + =A0 =A0 =A0 board_nand_data.ecc_opt =A0 =A0 =A0 =A0 =3D
> OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
>=20
> OMAP3 pandora.
> What I wanted to say is that current mainline code has hw ECC forced
> which is wrong for some boards, and this patch did not make into last
> merge window, so NAND is broken. It would be good to take this patch
> out of larger series you sent earlier and resend as a fix for -rc1, s=
o
> that NAND works on 2.6.37.  It's not too large and should probably be
> ok for -rc2.

[Ghorai]=20
There is an additional patch I will send (with this series by next week=
) to select the ECC from board file, such that different board file can=
 select the different ECC method.=20

1. This is mainly for OMAP3630 onwards and has been aligned with many c=
ustomers to use the hw ecc.

2. I did not understand how it's not working, would you please explain =
again? If you apply the series then it's storing the same ecc value in =
different location and generated from h/w module.=20
=46ile: arch/arm/mach-omap2/board-flash.c=20
board_nand_data.ecc_opt         =3D OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
change to -
board_nand_data.ecc_opt         =3D OMAP_ECC_HAMMING_CODE_HW;
- to switch back to s/w generated ECC stores at end of the spare area.

3. This patches are not upstream yet; send me the git-link you referrin=
g that these patches are available in 2.6.37?


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
