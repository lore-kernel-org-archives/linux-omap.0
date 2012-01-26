From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3
 setup
Date: Thu, 26 Jan 2012 15:53:27 -0800
Message-ID: <20120126235326.GD29812@atomide.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
 <20120126231921.GA29812@atomide.com>
 <CANOLnOPSwj-swMYR8CmFOf-Y0GWvdN-BQtneX4WLv87FwWTbtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38379 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab2AZXx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 18:53:29 -0500
Content-Disposition: inline
In-Reply-To: <CANOLnOPSwj-swMYR8CmFOf-Y0GWvdN-BQtneX4WLv87FwWTbtg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120126 15:06]:
> On Fri, Jan 27, 2012 at 1:19 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Grazvydas Ignotas <notasas@gmail.com> [111217 16:03]:
> >> hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
> >> enables internal clock for MMC2. Currently this function is also c=
alled
> >> by code handling MMC3, and if .internal_clock is set in platform d=
ata
> >> (by default it currently is), it will set MMCSDIO2ADPCLKISEL for M=
MC2
> >> instead of MMC3 (MMC3 doesn't have such bit so nothing actually ne=
eds to
> >> be done). This breaks 2nd SD slot on pandora.
> >>
> >> Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
> >> Note that this removes .remux() call for MMC3, but no board curren=
tly
> >> needs it and it's also not called for MMC4 and MMC5.
> >>
> >> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> >> ---
> >> applies both on mainline and hsmmc branch.
> >>
> >> =C2=A0arch/arm/mach-omap2/hsmmc.c | =C2=A0 =C2=A07 +++----
> >> =C2=A01 files changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsm=
mc.c
> >> index f4a1020..d90ac08 100644
> >> --- a/arch/arm/mach-omap2/hsmmc.c
> >> +++ b/arch/arm/mach-omap2/hsmmc.c
> >> @@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct =
device *dev, int slot,
> >> =C2=A0 =C2=A0 =C2=A0 }
> >> =C2=A0}
> >>
> >> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
> >> +static void hsmmc2_before_set_reg(struct device *dev, int slot,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int power_on, int v=
dd)
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 struct omap_mmc_platform_data *mmc =3D dev->p=
latform_data;
> >
> > This hunk above changing the function name seems to be a typo?
>=20
> No it's not, this function is changing MMC2 clock source and is no
> longer called for MMC3 after this patch (the call for MMC3 was the
> problem), so it loses hsmmc23 name.

OK thanks, applying into fixes.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
