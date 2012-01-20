From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
Date: Fri, 20 Jan 2012 19:24:23 +0200
Message-ID: <CANOLnONJgEJehOiH0_0AUWnAu62K-8A_cmv4UW0v=dwoQnn62w@mail.gmail.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51839 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753747Ab2ATRYY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 12:24:24 -0500
Received: by lahc1 with SMTP id c1so459416lah.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 09:24:23 -0800 (PST)
In-Reply-To: <1324168547-26569-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

Would be nice to have this for -rc as this used to work several
releases back when hsmmc23_before_set_reg() was checking for a
regulator, which wasn't set for MMC3 so the function would return
early, not causing the problem it causes now.

On Sun, Dec 18, 2011 at 2:35 AM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
> enables internal clock for MMC2. Currently this function is also call=
ed
> by code handling MMC3, and if .internal_clock is set in platform data
> (by default it currently is), it will set MMCSDIO2ADPCLKISEL for MMC2
> instead of MMC3 (MMC3 doesn't have such bit so nothing actually needs=
 to
> be done). This breaks 2nd SD slot on pandora.
>
> Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
> Note that this removes .remux() call for MMC3, but no board currently
> needs it and it's also not called for MMC4 and MMC5.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> applies both on mainline and hsmmc branch.
>
> =C2=A0arch/arm/mach-omap2/hsmmc.c | =C2=A0 =C2=A07 +++----
> =C2=A01 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index f4a1020..d90ac08 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct dev=
ice *dev, int slot,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
> +static void hsmmc2_before_set_reg(struct device *dev, int slot,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int power_on, int vdd=
)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_mmc_platform_data *mmc =3D dev=
->platform_data;
> @@ -378,14 +378,13 @@ static int __init omap_hsmmc_pdata_init(struct =
omap2_hsmmc_info *c,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0c->caps &=3D ~MMC_CAP_8_BIT_DATA;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0c->caps |=3D MMC_CAP_4_BIT_DATA;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FALLTHROUGH */
> - =C2=A0 =C2=A0 =C2=A0 case 3:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc->slots=
[0].features & HSMMC_HAS_PBIAS) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* off-chip level shifting, or none */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc->slots[0].before_set_reg =3D hsmmc23_before_set_reg;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc->slots[0].before_set_reg =3D hsmmc2_before_set_reg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mmc->slots[0].after_set_reg =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 case 3:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case 4:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case 5:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->slots[0].=
before_set_reg =3D NULL;
> --
> 1.7.0.4
>



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
