From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 30 Sep 2010 12:15:35 -0700
Message-ID: <20100930191535.GM3117@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
 <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
 <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
 <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
 <20100924225254.GK4211@atomide.com>
 <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
 <20100930184841.GL3117@atomide.com>
 <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57082 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab0I3TPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 15:15:38 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com> [100930 11:57]:
> 2010/9/30 Tony Lindgren <tony@atomide.com>:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
> >> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
> >> > same spotty voltage range.
> >> > Cory, care to do a patch that fixes it for all of them?
> >> Yeah, I can do that. =C2=A0I'll resubmit this patch too with the f=
ixed up ranges.
> > Turns out I already did it :) Care to test/ack this one?
>=20
> [...]
> > diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-om=
ap1/board-sx1-mmc.c
> > index 5b33ae8..be5a365 100644
> > --- a/arch/arm/mach-omap1/board-sx1-mmc.c
> > +++ b/arch/arm/mach-omap1/board-sx1-mmc.c
> > @@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data =3D=
 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_power =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mmc_set_power,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_=
30_31 |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_=
29_30 |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MMC_VDD_30_31 | MMC_VDD_31_32 |
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MMC_VDD_32_33 | MMC_VDD_33_34,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> [...]
>=20
> Al least this one seems wrong (haven't checked others) as the
> mmc_set_power() ignores vdd parameter. This suggests that the board
> supports only one particular voltage, not the whole range.

Hmm yeah good catch. With the external power it's board specific.=20

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
