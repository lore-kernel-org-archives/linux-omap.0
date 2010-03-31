From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-V2] OMAP: Fix for bus width which improves SD card's
	peformance.
Date: Wed, 31 Mar 2010 11:57:20 +0530
Message-ID: <v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com>
	<004701caab40$68b576e0$544ff780@am.dhcp.ti.com> <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com
List-Id: linux-omap@vger.kernel.org

> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 83f0aff..8c97c22 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2092,7 +2092,7 @@ static int __init omap_hsmmc_probe(struct
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_WAIT_WHILE_BUSY;
>
> =A0 =A0 =A0if (mmc_slot(host).wires >=3D 8)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_8_BIT_DATA | MM=
C_CAP_4_BIT_DATA);
> =A0 =A0 =A0else if (mmc_slot(host).wires >=3D 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
Your mailer has some issue, 'tabs' got replaced by 'spaces' in this
patch. Please fix it and repost.

Also take care off deleting below unrelated content.

-
Regards,
Vimal

>
> On Thu, Feb 11, 2010 at 11:04 PM, Madhusudhan <madhu.cr@ti.com> wrote=
:
>>
>>
>>> -----Original Message-----
>>> From: kishore kadiyala [mailto:kishore.kadiyala@ti.com]
>>> Sent: Thursday, February 11, 2010 8:20 AM
>>> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Cc: jarkko.lavinen@nokia.com; madhu.cr@ti.com
>>> Subject: [PATCH] OMAP: Fix for bus width which improves SD card's
>>> peformance.
