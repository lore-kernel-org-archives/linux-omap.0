From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2 2/2]: Introducing 'gpmc-nand.c' for GPMC specific NAND
	init
Date: Thu, 7 Jan 2010 10:47:00 +0530
Message-ID: <ce9ab5791001062117s712bd3c2j950316e80eb5abcb@mail.gmail.com>
References: <64662.192.168.10.89.1259933932.squirrel@dbdmail.itg.ti.com>
	<20091204220138.GJ24013@atomide.com> <ce9ab5790912062229xae89bb3m6965b4f4465f11c3@mail.gmail.com>
	<ce9ab5790912070529h1143355du691ce6a23f5ddb56@mail.gmail.com>
	<20091207175644.GA24013@atomide.com> <20091208235725.GA24013@atomide.com>
	<ce9ab5790912132226n6480c029ve93def5ebec1e2c9@mail.gmail.com>
	<ce9ab5790912140147v23e3705aucf6d25c56aaaab31@mail.gmail.com>
	<1262788497.3177.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34187 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0AGFRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 00:17:21 -0500
Received: by bwz27 with SMTP id 27so11185944bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 21:17:20 -0800 (PST)
In-Reply-To: <1262788497.3177.14.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

On Wed, Jan 6, 2010 at 8:04 PM, Artem Bityutskiy <dedekind1@gmail.com> =
wrote:
> On Mon, 2009-12-14 at 15:17 +0530, Vimal Singh wrote:
>> From 6170aa1c63c49a3f09e76258f400230b742fdd6f Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Wed, 25 Nov 2009 18:23:15 +0530
>> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND in=
it
>>
>> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
>> For example: GPMC timing parameters and all.
>> This patch also migrates gpmc related calls from 'nand/omap2.c'
>> to 'gpmc-nand.c'.
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
>> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0137 +++++++++=
+++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A06 ++
>> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26 +--=
----
>> =A04 files changed, 149 insertions(+), 23 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>
> I assume this is material for Tony and the omap tree.
>
Yes, it is.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
