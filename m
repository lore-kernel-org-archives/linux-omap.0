From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 1/2]: OMAP: SDP: Introducing 'board-sdp-flash.c' for flash
	init
Date: Tue, 22 Dec 2009 14:21:00 +0530
Message-ID: <ce9ab5790912220051i26fa07cbgb4ad3d22b732afeb@mail.gmail.com>
References: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
	<20091204221712.GL24013@atomide.com> <ce9ab5790912062240i1ca4d8eemcc46e6bc19ecb8f6@mail.gmail.com>
	<20091207183600.GF24013@atomide.com> <ce9ab5790912140159o46280d86u5ceb2ba11978e388@mail.gmail.com>
	<20091214193149.GB4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36714 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZLVIvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 03:51:22 -0500
Received: by bwz27 with SMTP id 27so3965062bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 00:51:20 -0800 (PST)
In-Reply-To: <20091214193149.GB4575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Dec 15, 2009 at 1:01 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Vimal Singh <vimal.newwork@gmail.com> [091214 01:58]:
>> On Tue, Dec 8, 2009 at 12:06 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Vimal Singh <vimal.newwork@gmail.com> [091206 22:39]:
>> >> On Sat, Dec 5, 2009 at 3:47 AM, Tony Lindgren <tony@atomide.com> =
wrote:
>> >> > Hi,
>> >> >
>> >> > * Vimal Singh <vimal.newwork@gmail.com> [091203 06:09]:
>> >> >> From 13d52884956a26f93826c443e2b8bd78615f74d6 Mon Sep 17 00:00=
:00 2001
>> >> >> From: Vimal Singh <vimalsingh@ti.com>
>> >> >> Date: Thu, 26 Nov 2009 16:10:24 +0530
>> >> >> Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' fo=
r flash init
>> >> >>
>> >> >> This patch adds 'board-sdp-flash.c', which could be utilized
>> >> >> by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).
>> >> >>
>> >> >> This file does initialization for all three flash devices pres=
ent
>> >> >> in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' numb=
er
>> >> >> dynamically using switch setting information (S8: 1-4).
>> >> >> This also expects partition information from core board files =
(for
>> >> >> ex: board-3430sdp.c). Which allows to choose different default
>> >> >> partitions for different boards.
>> >> >>
>> >> >> A new structure is created for this purpose: 'flash_partitions=
'
>> >> >> in 'mach/board-sdp.h'. This has two members:
>> >> >> 1. struct mtd_partition *parts
>> >> >> 2. int nr_parts
>> >> >>
>> >> >> A board file is expected to fill this structure and pass it to
>> >> >> 'sdp-flsash-init'. Partition information should be passed in
>> >> >> structure array of 'flash_partitions'. Partition information s=
hould
>> >> >> be passed in below sequence in array:
>> >> >> NOR
>> >> >> OneNAND
>> >> >> NAND
>> >> >>
>> >> >> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> >> >> ---
>> >> >> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A02=
46 ++++++++++++++++++++++++++
>> >> >> =A0arch/arm/mach-omap2/include/mach/board-sdp.h | =A0 22 +++
>> >> >> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A0=
2 +
>> >> >> =A03 files changed, 270 insertions(+), 0 deletions(-)
>> >> >> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>> >> >> =A0create mode 100644 arch/arm/mach-omap2/include/mach/board-s=
dp.h
>> >> >>
>> >> >> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
>> >> >> b/arch/arm/mach-omap2/board-sdp-flash.c
>> >> >> new file mode 100644
>> >> >> index 0000000..fbbcd0e
>> >> >> --- /dev/null
>> >> >> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
>> >> >
>> >> > <snip>
>> >> >
>> >> >> +__init board_nand_init(struct flash_partitions sdp_nand_parts=
, u8 cs)
>> >> >> +{
>> >> >> + =A0 =A0 sdp_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =
cs;
>> >> >> + =A0 =A0 sdp_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0 =3D sdp_=
nand_parts.parts;
>> >> >> + =A0 =A0 sdp_nand_data.nr_parts =A0 =A0 =A0 =A0 =A0=3D sdp_na=
nd_parts.nr_parts;
>> >> >> +
>> >> >> + =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =A0=3D (void *)(OMAP3=
4XX_GPMC_VIRT +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
>> >> >> + =A0 =A0 sdp_nand_data.gpmc_baseaddr =A0 =A0 =A0=3D (void *) =
(OMAP34XX_GPMC_VIRT);
>> >> >> +
>> >> >> + =A0 =A0 gpmc_nand_init(&sdp_nand_data);
>> >> >> +}
>> >> >
>> >> > This does not look right. You're supposed to use gpmc_cs_reques=
t()
>> >> > for allocating the GPMC area based on the chip select and size.
>> >>
>> >> I guess you are getting confuse a bit here:
>> >> gpmc_baseaddr: is the virtual address for GPMC_REVISION (which is=
 also
>> >> base address for GPMC).
>> >> gpmc_cs_baseaddr : This is offset from above to 'GPMC_CONFIG(cs)'=
 for
>> >> specified cs number.
>> >>
>> >> These are needed by nand driver.
>> >
>> > Right.. Looks like drivers/mtd/nand/omap2.c needs to be fixed so w=
e
>> > can get rid of this.
>> >
>> > And looks like we already are doing it all over the place anyways =
:(
>> >
>> >> While 'gpmc_cs_request' gives physical address to the device reso=
urce.
>> >> And this is done in 'nand/omap2.c'. This is done in driver itself=
 so
>> >> that we don't allocate a resource even before driver gets loaded.
>> >
>> > Yuk.. The nand driver should be generic.
>> >
>> >> >> --- a/arch/arm/plat-omap/include/plat/gpmc.h
>> >> >> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
>> >> >> @@ -27,6 +27,8 @@
>> >> >>
>> >> >> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A00x50
>> >> >> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A00x54
>> >> >> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
>> >> >> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 0x30
>> >> >
>> >> > The GPMC_CS0_BASE and GPMC_CS_SIZE seem to be values specic to
>> >> > your board, not for the GPMC hardware.
>> >>
>> >> These are offsets and very much specific to GPMC hardware.
>> >>
>> >> GPMC_CS0_BASE: is offset from GPMC base to first cs GPMC_CONFIG1 =
register.
>> >> GPMC_CS_SIZE : is offset (gap) between next cs config registers, =
e.i.
>> >> size for cs config registers.
>> >
>> > Let's keep it local until drivers/mtd/nand/omap2.c is fixed.
>> >
>> > Care to take a look at using some generic nand driver instead
>> > if we merge this for now?
>>
>> To me it seems ok, for now, to get this merged and later we can work
>> on cleaning 'nand/omap2.c' driver.
>
> OK, sounds good to me. Let's plan on moving to use the gpmc-nand.c as
> posted on this list.
>
Could you please merge these patches for now?

Below patches are list as "Changes Requested" in patchwork.
[1/4] : OMAP: ZOOM: Introducing 'board-zoom-flash.c' for NAND init in
ZOOM boards
[1/2] : OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init

Will you take care of them or you want me to re-post them?

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
