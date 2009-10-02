From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] omap_hsmmc: Add missing probe handler hook to platform
 driver data
Date: Fri, 02 Oct 2009 14:47:45 +0300
Message-ID: <4AC5E861.2080102@nokia.com>
References: <1254407953-25124-1-git-send-email-ext-roger.quadros@nokia.com> <200910011758.35779.rok@kanardia.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49557 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZJBLsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 07:48:42 -0400
In-Reply-To: <200910011758.35779.rok@kanardia.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?ZXh0IFJvayBNYXJrb3ZpxI0=?= <rok@kanardia.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: madhu.cr@ti.com

ext Rok Markovi=C4=8D wrote:
> This is not the correct way to do it. There was some conflict during =
merge in=20
> init function. Correct patch should look like this:
>=20
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver=
 =3D {
>  static int __init omap_hsmmc_init(void)
>  {
>         /* Register the MMC driver */
> -       return platform_driver_register(&omap_hsmmc_driver);
> +       return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_p=
robe);
>  }
>=20
>  static void __exit omap_hsmmc_cleanup(void)
>=20
> Rok
>=20

Oh yes. Since omap_hsmmc is not a hot-pluggable device.
Will send a v2.

Thanks Rok, for pointing this out.

>=20
>=20
> Dne =C4=8Detrtek 1. oktobra 2009 ob 16:39:13 ste napisali:
>> The missing probe handler hook will never probe the driver. Add it b=
ack.
>> Fixes broken MMC on OMAP.
>>
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 4487cc0..26abe1e 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2001,6 +2001,7 @@ clk_en_err:
>>  #endif
>>
>>  static struct platform_driver omap_hsmmc_driver =3D {
>> +	.probe		=3D omap_hsmmc_probe,
>>  	.remove		=3D omap_hsmmc_remove,
>>  	.suspend	=3D omap_hsmmc_suspend,
>>  	.resume		=3D omap_hsmmc_resume,
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
