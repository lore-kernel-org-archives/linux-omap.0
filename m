From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 07/11] OMAP: HSMMC: Fix unused variable warning
Date: Fri, 27 Aug 2010 14:33:35 +0530
Message-ID: <AANLkTik55GAh3_E_-gW4WcyjAmypZmNq3ywOWN3JNoph@mail.gmail.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
	<1282856209-15645-8-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34070 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab0H0JDg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 05:03:36 -0400
Received: by vws3 with SMTP id 3so2645194vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 02:03:35 -0700 (PDT)
In-Reply-To: <1282856209-15645-8-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hi Manju,

Patch already posted here :
https://patchwork.kernel.org/patch/118871/

Regards,
Kishore

On Fri, Aug 27, 2010 at 2:26 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> From: Manjunatha GK <manjugk@ti.com>
>
> Fixes warning due to unused variable.
>
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
> drivers/mmc/host/omap_hsmmc.c:2308: warning: unused variable 'state'
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 4a8776f..fb6446a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2305,7 +2305,6 @@ static int omap_hsmmc_suspend(struct device *de=
v)
> =A0 =A0 =A0 =A0int ret =3D 0;
> =A0 =A0 =A0 =A0struct platform_device *pdev =3D to_platform_device(de=
v);
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D platform_get_drvdata(=
pdev);
> - =A0 =A0 =A0 pm_message_t state =3D PMSG_SUSPEND; /* unused by MMC c=
ore */
>
> =A0 =A0 =A0 =A0if (host && host->suspended)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> --
> 1.7.0.4
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
