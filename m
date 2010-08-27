From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 09/10] [PM-WIP-MMC] OMAP MMC : Fix crash with CONFIG_PM_RUNTIME
Date: Fri, 27 Aug 2010 19:49:20 +0530
Message-ID: <AANLkTi=GXcqygu2Hrsh9vSq7RrVDz9_0CkSanHy0Se8P@mail.gmail.com>
References: <16171.10.24.255.18.1282335076.squirrel@dbdmail.itg.ti.com>
	<87vd6xuffg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49524 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab0H0OTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:19:21 -0400
Received: by vws3 with SMTP id 3so2901588vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 07:19:20 -0700 (PDT)
In-Reply-To: <87vd6xuffg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com

On Fri, Aug 27, 2010 at 4:53 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "kishore kadiyala" <kishore.kadiyala@ti.com> writes:
>
>> Crash if enabled CONFIG_PM_RUNTIME and power_saving set.
>>
>> Use get_sync/put_sync properly so that host->nesting_cnt gets
>> updated properly.
>
> <blush>This one is my fault for not really understanding the MMC driv=
er.
>
> Go ahead and just fold this into the original patch when you incorpor=
ate
> it.

Sure , will take care in final series while posting to LO

Regards,
Kishore
>
> Kevin
>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A05 ++---
>> =A01 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index c113bfd..90a69c3 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2036,7 +2036,8 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 host->dpm_state =3D DISABLED;
>>
>> =A0 =A0 =A0 pm_runtime_enable(host->dev);
>> - =A0 =A0 pm_runtime_get_sync(host->dev);
>> + =A0 =A0 if (mmc_host_enable(host->mmc) !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>>
>> =A0 =A0 =A0 if (cpu_is_omap2430()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dbclk =3D clk_get(&pdev->dev, "mmc=
hsdb_fck");
>> @@ -2139,8 +2140,6 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
>>
>> =A0 =A0 =A0 mmc_add_host(mmc);
>>
>> - =A0 =A0 pm_runtime_put(host->dev);
>> -
>> =A0 =A0 =A0 if (mmc_slot(host).name !=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D device_create_file(&mmc->class_d=
ev, &dev_attr_slot_name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
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
