From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 1/2]: OMAP: SDP: Introducing 'board-sdp-flash.c' for flash
	init
Date: Mon, 7 Dec 2009 12:10:31 +0530
Message-ID: <ce9ab5790912062240i1ca4d8eemcc46e6bc19ecb8f6@mail.gmail.com>
References: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
	<20091204221712.GL24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43748 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbZLGGkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 01:40:45 -0500
Received: by bwz27 with SMTP id 27so3245997bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 06 Dec 2009 22:40:51 -0800 (PST)
In-Reply-To: <20091204221712.GL24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Sat, Dec 5, 2009 at 3:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Vimal Singh <vimal.newwork@gmail.com> [091203 06:09]:
>> From 13d52884956a26f93826c443e2b8bd78615f74d6 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Thu, 26 Nov 2009 16:10:24 +0530
>> Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' for flas=
h init
>>
>> This patch adds 'board-sdp-flash.c', which could be utilized
>> by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).
>>
>> This file does initialization for all three flash devices present
>> in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' number
>> dynamically using switch setting information (S8: 1-4).
>> This also expects partition information from core board files (for
>> ex: board-3430sdp.c). Which allows to choose different default
>> partitions for different boards.
>>
>> A new structure is created for this purpose: 'flash_partitions'
>> in 'mach/board-sdp.h'. This has two members:
>> 1. struct mtd_partition *parts
>> 2. int nr_parts
>>
>> A board file is expected to fill this structure and pass it to
>> 'sdp-flsash-init'. Partition information should be passed in
>> structure array of 'flash_partitions'. Partition information should
>> be passed in below sequence in array:
>> NOR
>> OneNAND
>> NAND
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A0246 +++=
+++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/include/mach/board-sdp.h | =A0 22 +++
>> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A02 +
>> =A03 files changed, 270 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>> =A0create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
>>
>> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
>> b/arch/arm/mach-omap2/board-sdp-flash.c
>> new file mode 100644
>> index 0000000..fbbcd0e
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
>
> <snip>
>
>> +__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 c=
s)
>> +{
>> + =A0 =A0 sdp_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cs;
>> + =A0 =A0 sdp_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0 =3D sdp_nand_p=
arts.parts;
>> + =A0 =A0 sdp_nand_data.nr_parts =A0 =A0 =A0 =A0 =A0=3D sdp_nand_par=
ts.nr_parts;
>> +
>> + =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =A0=3D (void *)(OMAP34XX_GP=
MC_VIRT +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
>> + =A0 =A0 sdp_nand_data.gpmc_baseaddr =A0 =A0 =A0=3D (void *) (OMAP3=
4XX_GPMC_VIRT);
>> +
>> + =A0 =A0 gpmc_nand_init(&sdp_nand_data);
>> +}
>
> This does not look right. You're supposed to use gpmc_cs_request()
> for allocating the GPMC area based on the chip select and size.

I guess you are getting confuse a bit here:
gpmc_baseaddr: is the virtual address for GPMC_REVISION (which is also
base address for GPMC).
gpmc_cs_baseaddr : This is offset from above to 'GPMC_CONFIG(cs)' for
specified cs number.

These are needed by nand driver.

While 'gpmc_cs_request' gives physical address to the device resource.
And this is done in 'nand/omap2.c'. This is done in driver itself so
that we don't allocate a resource even before driver gets loaded.


>
>> --- a/arch/arm/plat-omap/include/plat/gpmc.h
>> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
>> @@ -27,6 +27,8 @@
>>
>> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A00x50
>> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A00x54
>> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
>> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 0x30
>
> The GPMC_CS0_BASE and GPMC_CS_SIZE seem to be values specic to
> your board, not for the GPMC hardware.

These are offsets and very much specific to GPMC hardware.

GPMC_CS0_BASE: is offset from GPMC base to first cs GPMC_CONFIG1 regist=
er.
GPMC_CS_SIZE : is offset (gap) between next cs config registers, e.i.
size for cs config registers.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
