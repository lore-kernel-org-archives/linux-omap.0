From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for flash
	init
Date: Fri, 5 Feb 2010 14:22:42 +0530
Message-ID: <ce9ab5791002050052w75ae4dbbjf6328320c70a3221@mail.gmail.com>
References: <ce9ab5791001122253u6b431290o136b2586d90ca92b@mail.gmail.com>
	<20100204235024.GA22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45860 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402Ab0BEIxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:53:05 -0500
Received: by bwz19 with SMTP id 19so1215319bwz.28
        for <linux-omap@vger.kernel.org>; Fri, 05 Feb 2010 00:53:02 -0800 (PST)
In-Reply-To: <20100204235024.GA22747@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Feb 5, 2010 at 5:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Vimal Singh <vimal.newwork@gmail.com> [100112 22:51]:
>> From 994785b066a9bd4fbaf7753cb6ab7317440afd36 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Tue, 12 Jan 2010 17:22:42 +0530
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
> Related to the comments for gpmc-nand.c, you can now get rid of the
> gpmc_cs_baseaddr hardcoding in the board-*.c files. The address gets
> assigned by gpmc_cs_request based on the chip select and size.

This (gpmc_cs_baseaddr) is passed to OMAP NAND driver (nand/omap2.c)
for its uses.
This is base address to GPMC Registers for CS where NAND is present.
And this will be used by functions like "omap_hwcontrol" to access
GPMC NAND COMMAND, GPMC NAND ADDRESS and GPMC NAND DATA etc CS
specific registers.

And of course, nand driver should not know at which 'cs' nand device
is connected, correct?
So, this information is passed from board.



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
