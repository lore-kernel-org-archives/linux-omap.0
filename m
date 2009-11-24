From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Tue, 24 Nov 2009 20:55:08 +0530
Message-ID: <ce9ab5790911240725x29b8bd6eq9f9c7a8b21c6786e@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	<20091109205250.GB23952@atomide.com> <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
	<ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
	<1259075173.29118.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56629 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbZKXPZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:25:23 -0500
Received: by bwz27 with SMTP id 27so6074396bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 07:25:28 -0800 (PST)
In-Reply-To: <1259075173.29118.20.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

On Tue, Nov 24, 2009 at 8:36 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Thu, 2009-11-19 at 19:38 +0530, Vimal Singh wrote:
>> Here is the v6 of this patch series. I am cc'ing mtd list too this time.
>>
>>
>> From 8bc97108cf9c78216f1ea5407ccbd900e6b63dc2 Mon Sep 17 00:00:00 2001
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Thu, 19 Nov 2009 19:28:11 +0530
>>
>> This patch series adds flash support for NAND (in sdp, zoom and ldp),
>> OneNAND and NOR (in sdp)
>>
>> Tested on Zoom2 and 3430SDP
>>
>> Vimal Singh (4):
>> [PATCH-v6 1/4] OMAP2/3: Add support for flash on SDP boards
>> [PATCH-v6 2/4] OMAP3: Add support for NAND on ZOOM/LDP boards
>> [PATCH-v6 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfig
>> [PATCH-v6 4/4] OMAP: 3430SDP: Enable NAND in defconfig
>
> Is it possible to separate the MTD and OMAP parts?

1st patch does migration of gpmc low level calls from omap2.c to gpmc-nand.c.
I am not sure how we can have separate patches for this.

-- 
Regards,
Vimal Singh
