From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP: NAND: Adding config option to enable/disable HW ECC
	mode
Date: Wed, 16 Dec 2009 10:35:00 +0530
Message-ID: <ce9ab5790912152105v6e44860en57a1b2416a4d7e77@mail.gmail.com>
References: <ce9ab5790912150746t29be1640g817ab883b16860a3@mail.gmail.com>
	<20091215173510.GH4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47824 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZLPFFX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 00:05:23 -0500
Received: by bwz27 with SMTP id 27so471281bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 21:05:20 -0800 (PST)
In-Reply-To: <20091215173510.GH4575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Tue, Dec 15, 2009 at 11:05 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Vimal Singh <vimal.newwork@gmail.com> [091215 07:45]:
>> OMAP NAND driver got HW ECC implemented.
>>
>> From d5e28c9fdbc6b0a95c1259fac7add207f9c294d7 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Tue, 15 Dec 2009 21:10:54 +0530
>> Subject: [PATCH] OMAP: NAND: Adding config option to enable/disable =
HW ECC mode
>>
>> This patch adds config option to select/deselect HW ECC feature
>> on OMAP NAND driver. This is a feature provided by OMAP GPMC for
>> NAND devices.
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> ---
>> =A0drivers/mtd/nand/Kconfig | =A0 10 ++++++++++
>> =A01 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 34598e9..6c4b27c 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -97,6 +97,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
>> =A0 =A0 =A0 =A0or in DMA interrupt mode.
>> =A0 =A0 =A0 =A0Say y for DMA mode or MPU mode will be used
>>
>> +config MTD_NAND_OMAP_HWECC
>> + =A0 =A0 bool "The Hardware ECC support"
>> + =A0 =A0 depends on MTD_NAND && MTD_NAND_OMAP2
>> + =A0 =A0 default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0The ECC compuatation for the data to be written/read ca=
n be either by
>> + =A0 =A0 =A0software or omap has Hw ecc engine which calculates it.
>> + =A0 =A0 =A0MTD_NAND_OMAP_HWECC =3D y which enables the hw ecc
>> + =A0 =A0 =A0MTD_NAND_OMAP_HWECC =3D n enables software ecc
>> +
>> =A0config MTD_NAND_TS7250
>> =A0 =A0 =A0 tristate "NAND Flash device on TS-7250 board"
>> =A0 =A0 =A0 depends on MACH_TS72XX
>
> This sounds like it should be an option passed from the board-*.c
> files as platform_data rather than a Kconfig option.

ACK. I'll do it once flash support patches get merged.


--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
