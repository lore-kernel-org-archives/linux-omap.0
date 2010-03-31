From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH-V2] OMAP: Fix for bus width which improves SD card's peformance.
Date: Wed, 31 Mar 2010 11:37:19 -0500
Message-ID: <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com> <004701caab40$68b576e0$544ff780@am.dhcp.ti.com> <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com> <v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com> <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'kishore kadiyala' <kishorek.kadiyala@gmail.com>, 'Vimal Singh' <vimal.newwork@gmail.com>
Cc: tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> Sent: Wednesday, March 31, 2010 2:03 AM
> To: Vimal Singh
> Cc: Madhusudhan; tony@atomide.com; svenkatr@ti.com; linux-
> omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> jarkko.lavinen@nokia.com
> Subject: Re: [PATCH-V2] OMAP: Fix for bus width which improves SD car=
d's
> peformance.
>=20
> Sorry for that and here's the Updated one.
>=20
> From: Kishore Kadiyala <kishore.kadiyala@ti.com>
>=20
> This patch improves low speeds for SD cards.
> OMAP-MMC controller's can support maximum bus width of '8'.
> when bus width is mentioned as "8" in controller data,the SD
> stack will check whether bus width is "4" and if not it will
> set bus width to "1" and there by degrading performance.
> This patch fixes the issue and improves the performance of
> SD cards.
>=20
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
>=20
> ---
> In V2 : Appended Signed-off by Venkat and Ack by Madhu
>=20
>  Here are my experiment numbers, on a Class 6 SDHC card:
>  Read peformance is increased by 220%
>  Write Performance is increased by 52%
>=20
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 83f0aff..8c97c22 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2092,7 +2092,7 @@ static int __init omap_hsmmc_probe(struct
>  		     MMC_CAP_WAIT_WHILE_BUSY;
>=20
>  	if (mmc_slot(host).wires >=3D 8)
> -		mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> +		mmc->caps |=3D (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA);
>  	else if (mmc_slot(host).wires >=3D 4)
>  		mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>=20
Kishore,

Since this patch is not yet pushed it makes sense to fix the readabilit=
y
issue.

Since 8-bit is the max how about:

 =A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 8)
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA | MMC=
_CAP_4_BIT_DATA;
 =A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 4)
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;

This would be little easy to read the code.

Can you please repost the patch??

Regards,
Madhu

> --
> 1.6.3.3
