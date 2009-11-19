From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Thu, 19 Nov 2009 19:56:14 +0530
Message-ID: <ce9ab5790911190626w6f726f3cle61e703a7c3cfd42@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	<20091109205250.GB23952@atomide.com> <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
	<ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
	<ce9ab5790911190611r63830a5dxa7e2eab5f053c2a7@mail.gmail.com>
	<4B055493.70009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61970 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZKSO03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:26:29 -0500
Received: by bwz27 with SMTP id 27so2395961bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 06:26:34 -0800 (PST)
In-Reply-To: <4B055493.70009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux MTD <linux-mtd@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Singh, Vimal" <vimalsingh@ti.com>

On Thu, Nov 19, 2009 at 7:52 PM, Nishanth Menon <nm@ti.com> wrote:
> Vimal Singh had written, on 11/19/2009 08:11 AM, the following:
> [...]
>
>>>
>>> v4-v5:
>>> [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards:
>>> Implemented Tony's comments.
>>
>> =A0arch/arm/configs/omap_3430sdp_defconfig =A0 =A0 =A0| =A0140 +++++=
++----
>> =A0arch/arm/configs/omap_zoom2_defconfig =A0 =A0 =A0 =A0| =A0344
>> +++++++++++++++++++-------
>
> how about zoom3 and sdp3630?

I do not have these boards. Could someone test for these and drop a
patch for same?

>
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A08 +
>> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +
>> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +
>> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A0315
>> +++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 | =A0 92 +++++=
++
>> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A02 +
>> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
28 ++++++++++
>> =A0arch/arm/plat-omap/include/plat/board-sdp.h =A0| =A0 15 ++
>> =A0arch/arm/plat-omap/include/plat/board-zoom.h | =A0 36 +++
>> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A04 +-
>> =A0arch/arm/plat-omap/include/plat/nand.h =A0 =A0 =A0 | =A0 =A06 +
>> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 33 +--
>> =A015 files changed, 969 insertions(+), 160 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
>> =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Regards,
> Nishanth Menon
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
