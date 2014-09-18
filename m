From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v3 1/3] nand: omap2: Add support for flash-based bad block table
Date: Thu, 18 Sep 2014 08:46:15 +0100
Message-ID: <CAAEAJfDsht+-LU+ASX2fcsj2j=VKhkFzbhubMbrT5PMcOvQC8A@mail.gmail.com>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1410447730-16087-2-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20140918055948.GD7362@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:48257 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaIRHqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 03:46:17 -0400
Received: by mail-qa0-f48.google.com with SMTP id v10so605731qac.35
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2014 00:46:16 -0700 (PDT)
In-Reply-To: <20140918055948.GD7362@norris-Latitude-E6410>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On 18 September 2014 06:59, Brian Norris <computersforpeace@gmail.com> =
wrote:
> On Thu, Sep 11, 2014 at 12:02:08PM -0300, Ezequiel Garcia wrote:
>> This commit adds a new platform-data boolean property that enables u=
se
>> of a flash-based bad block table. This can also be enabled by settin=
g
>> the 'nand-on-flash-bbt' devicetree property.
>>
>> If the flash BBT is not enabled, the driver falls back to use OOB
>> bad block markers only, as before. If the flash BBT is enabled the
>> kernel will keep track of bad blocks using a BBT, in addition to
>> the OOB markers.
>>
>> As explained by Brian Norris the reasons for using a BBT are:
>>
>> ""
>> The primary reason would be that NAND datasheets specify it these da=
ys.
>> A better argument is that nobody guarantees that you can write a
>> bad block marker to a worn out block; you may just get program failu=
res.
>>
>> This has been acknowledged by several developers over the last sever=
al
>> years.
>>
>> Additionally, you get a boot-time performance improvement if you onl=
y
>> have to read a few pages, instead of a page or two from every block =
on
>> the flash.
>> ""
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Pushed this one to l2-mtd.git. Thanks!
>
> But I do have one question below, and I have comments for patch 2.
>
>> ---
>>  arch/arm/mach-omap2/gpmc.c                   | 2 ++
>>  drivers/mtd/nand/omap2.c                     | 6 +++++-
>>  include/linux/platform_data/mtd-nand-omap2.h | 1 +
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 2f97228..b55a225 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -1440,6 +1440,8 @@ static int gpmc_probe_nand_child(struct platfo=
rm_device *pdev,
>>                               break;
>>                       }
>>
>> +     gpmc_nand_data->flash_bbt =3D of_get_nand_on_flash_bbt(child);
>> +
>>       val =3D of_get_nand_bus_width(child);
>>       if (val =3D=3D 16)
>>               gpmc_nand_data->devsize =3D NAND_BUSWIDTH_16;
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 5967b38..e1a9b31 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -1663,7 +1663,6 @@ static int omap_nand_probe(struct platform_dev=
ice *pdev)
>>       mtd->owner              =3D THIS_MODULE;
>>       nand_chip               =3D &info->nand;
>>       nand_chip->ecc.priv     =3D NULL;
>> -     nand_chip->options      |=3D NAND_SKIP_BBTSCAN;
>>
>>       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       nand_chip->IO_ADDR_R =3D devm_ioremap_resource(&pdev->dev, res=
);
>> @@ -1692,6 +1691,11 @@ static int omap_nand_probe(struct platform_de=
vice *pdev)
>>               nand_chip->chip_delay =3D 50;
>>       }
>>
>> +     if (pdata->flash_bbt)
>> +             nand_chip->bbt_options |=3D NAND_BBT_USE_FLASH | NAND_=
BBT_NO_OOB;
>> +     else
>> +             nand_chip->options |=3D NAND_SKIP_BBTSCAN;
>
> Can you remind me: why do you use SKIP_BBTSCAN? Doesn't that mean you=
're
> skipping all boot-time scanning for bad blocks, and resorting to
> on-demand scanning (chip->block_bad()) every time you need to check f=
or
> bad blocks?
>

Honestly, I have *no* idea, I just retained the previous flag, so to
keep the exact same behavior.

Roger, any ideas? If I have to guess, I'd say this is an attempt to
save some boot time.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
