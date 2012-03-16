From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH RESEND 8/8] mmc: omap4: hsmmc: fix module re-insertion
Date: Fri, 16 Mar 2012 16:02:16 +0530
Message-ID: <CANfBPZ-TRRoMrRsE-4twQuq8Q9Htce3BJH2r8hf8OVUou=p4Fg@mail.gmail.com>
References: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-9-git-send-email-svenkatr@ti.com> <20120315150426.GT28447@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41894 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031019Ab2CPKci convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 06:32:38 -0400
Received: by mail-bk0-f44.google.com with SMTP id w5so2727036bku.3
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 03:32:37 -0700 (PDT)
In-Reply-To: <20120315150426.GT28447@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com

On Thu, Mar 15, 2012 at 8:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Mar 15, 2012 at 08:03:42PM +0530, Venkatraman S wrote:
>> From: Balaji T K <balajitk@ti.com>
>>
>> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
>> Addng the offset to platform_device resource structure
>> increments the start address for every insmod operation.
>> MMC command fails on re-insertion as module due to incorrect registe=
r base.
>> Fix this by updating the ioremap base address only.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A04 +---
>> =A01 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 4476b26..f324cf4 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1813,8 +1813,6 @@ static int __devinit omap_hsmmc_probe(struct p=
latform_device *pdev)
>> =A0 =A0 =A0 if (res =3D=3D NULL || irq < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>>
>> - =A0 =A0 res->start +=3D pdata->reg_offset;
>> - =A0 =A0 res->end +=3D pdata->reg_offset;
>> =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(res=
), pdev->name);
>> =A0 =A0 =A0 if (res =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> @@ -1838,7 +1836,7 @@ static int __devinit omap_hsmmc_probe(struct p=
latform_device *pdev)
>> =A0 =A0 =A0 host->dma_ch =A0 =A0=3D -1;
>> =A0 =A0 =A0 host->irq =A0 =A0 =A0 =3D irq;
>> =A0 =A0 =A0 host->slot_id =A0 =3D 0;
>> - =A0 =A0 host->mapbase =A0 =3D res->start;
>> + =A0 =A0 host->mapbase =A0 =3D res->start + pdata->reg_offset;
>
> could this be done with a revision check at some point so we drop the
> pdata requirement ? Not part of $SUBJECT though, because you're just
> moving the increment.
>
That's a good idea. Will post that patch as part of another clean up se=
ries in
the pipeline.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
