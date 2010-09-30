From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 30 Sep 2010 15:11:11 -0700
Message-ID: <20100930221111.GO3117@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
 <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
 <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
 <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
 <20100924225254.GK4211@atomide.com>
 <AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
 <20100930184841.GL3117@atomide.com>
 <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
 <20100930191535.GM3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51531 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0I3WLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 18:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20100930191535.GM3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100930 12:07]:
> * Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com> [100930 11:57]:
> > 2010/9/30 Tony Lindgren <tony@atomide.com>:
> > > * Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
> > >> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
> > >> > same spotty voltage range.
> > >> > Cory, care to do a patch that fixes it for all of them?
> > >> Yeah, I can do that. =C2=A0I'll resubmit this patch too with the=
 fixed up ranges.
> > > Turns out I already did it :) Care to test/ack this one?
> >=20
> > [...]
> > > diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-=
omap1/board-sx1-mmc.c
> > > index 5b33ae8..be5a365 100644
> > > --- a/arch/arm/mach-omap1/board-sx1-mmc.c
> > > +++ b/arch/arm/mach-omap1/board-sx1-mmc.c
> > > @@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data =
=3D {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0.nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0.slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_power=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mmc_set_power,
> > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_=
30_31 |
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_=
29_30 |
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MMC_VDD_30_31 | MMC_VDD_31_32 |
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0MMC_VDD_32_33 | MMC_VDD_33_34,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > [...]
> >=20
> > Al least this one seems wrong (haven't checked others) as the
> > mmc_set_power() ignores vdd parameter. This suggests that the board
> > supports only one particular voltage, not the whole range.
>=20
> Hmm yeah good catch. With the external power it's board specific.=20

Most likely they all support only 3.3V cards except for n8x0. Not chang=
ing
the n8x0 for what voltages it handles although it may be missing the
MMC_VDD_27_28 voltage. Here's the updated patch.

Regards,

Tony

=46rom: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix spotty MMC voltages

As noted by Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>, the voltages =
should
cover the supported voltage range, or support only one voltage.

As all these boards are using a GPIO to enable the power, chances
are that only 3.3V cards are supported on these boards.

Reported-by: Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/b=
oard-h2-mmc.c
index b30c499..f2fc43d 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -58,8 +58,7 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.dma_mask			=3D 0xffffffff,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
-					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.ocr_mask               =3D MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
 };
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/b=
oard-h3-mmc.c
index 54b0f06..2098525 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -40,8 +40,7 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.dma_mask			=3D 0xffffffff,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
-					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.ocr_mask               =3D MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
 };
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap=
1/board-htcherald.c
index 7ea75c1..88c97e2 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -410,8 +410,7 @@ static struct omap_mmc_platform_data htc_mmc1_data =
=3D {
 	.nr_slots                       =3D 1,
 	.switch_slot                    =3D NULL,
 	.slots[0]       =3D {
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
-					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.ocr_mask               =3D MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 		.nomux                  =3D 1,
 		.wires                  =3D 4,
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/=
board-sx1-mmc.c
index 5b33ae8..e8ddd86 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -44,8 +44,7 @@ static struct omap_mmc_platform_data mmc1_data =3D {
 	.nr_slots                       =3D 1,
 	.slots[0]       =3D {
 		.set_power              =3D mmc_set_power,
-		.ocr_mask               =3D MMC_VDD_28_29 | MMC_VDD_30_31 |
-					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.ocr_mask               =3D MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name                   =3D "mmcblk",
 	},
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
