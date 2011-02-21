From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] omap3: Adding vdd_sdi regulator supply to OMAP3EVM
Date: Mon, 21 Feb 2011 15:02:24 +0800
Message-ID: <AANLkTim7Ks2n0CymKWSjpd2ND7ee1H_wKZDANBym7dnZ@mail.gmail.com>
References: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57469 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1BUHCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 02:02:44 -0500
Received: by iyb26 with SMTP id 26so414929iyb.19
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 23:02:44 -0800 (PST)
In-Reply-To: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, kernel-team@lists.ubuntu.com

Hi, would you guys take a look at this?

Thanks,
-Bryan

On Thu, Feb 17, 2011 at 4:11 PM, Bryan Wu <bryan.wu@canonical.com> wrot=
e:
> From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
>
> https://bugs.launchpad.net/bugs/630885
>
> When booting, the omapdss subsystem is looking for a regulator named
> "vdds_sdi". When the regulator is not found the initialisation sequen=
ce
> is aborted resulting in omapfb not finding a display to work with. =A0=
This
> patch allows the omapfb sub system to complete its initialisation
> properly and enable LCD display. The problem was fixed by lumping a
> "vdds_sdi" with the already existing "vdds_dsi" regulator. This fix
> takes its root from work done on the Beagle board and the Pandora boa=
rd.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 10 ++++++----
> =A01 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index c2a0fca..8b8eb36 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -521,8 +521,10 @@ static struct regulator_init_data omap3_evm_vdac=
 =3D {
> =A0};
>
> =A0/* VPLL2 for digital video outputs */
> -static struct regulator_consumer_supply omap3_evm_vpll2_supply =3D
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vdds_dsi", "omapdss");
> +static struct regulator_consumer_supply omap3_evm_vdds_supplies[] =3D=
 {
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +};
>
> =A0static struct regulator_init_data omap3_evm_vpll2 =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> @@ -534,8 +536,8 @@ static struct regulator_init_data omap3_evm_vpll2=
 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =A0 =A0 =3D RE=
GULATOR_CHANGE_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> - =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &omap3_evm_vpll2_supp=
ly,
> + =A0 =A0 =A0 .num_consumer_supplies =A0=3D ARRAY_SIZE(omap3_evm_vdds=
_supplies),
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D omap3_evm_vdds_suppli=
es,
> =A0};
>
> =A0static struct twl4030_platform_data omap3evm_twldata =3D {
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
