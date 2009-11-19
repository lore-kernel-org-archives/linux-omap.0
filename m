From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
 	boards
Date: Thu, 19 Nov 2009 08:22:11 -0600
Message-ID: <4B055493.70009@ti.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com> 	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com> 	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com> 	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com> 	<20091109205250.GB23952@atomide.com> <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com> 	<ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com> <ce9ab5790911190611r63830a5dxa7e2eab5f053c2a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755105AbZKSOWN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Nov 2009 09:22:13 -0500
In-Reply-To: <ce9ab5790911190611r63830a5dxa7e2eab5f053c2a7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux MTD <linux-mtd@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Singh, Vimal" <vimalsingh@ti.com>

Vimal Singh had written, on 11/19/2009 08:11 AM, the following:
[...]

>>
>> v4-v5:
>> [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards:
>> Implemented Tony's comments.
> 
>  arch/arm/configs/omap_3430sdp_defconfig      |  140 +++++++----
>  arch/arm/configs/omap_zoom2_defconfig        |  344 +++++++++++++++++++-------

how about zoom3 and sdp3630?

>  arch/arm/mach-omap2/Makefile                 |    8 +
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +
>  arch/arm/mach-omap2/board-3430sdp.c          |    2 +
>  arch/arm/mach-omap2/board-ldp.c              |    2 +
>  arch/arm/mach-omap2/board-sdp-flash.c        |  315 +++++++++++++++++++++++
>  arch/arm/mach-omap2/board-zoom-flash.c       |   92 +++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
>  arch/arm/mach-omap2/gpmc-nand.c              |  128 ++++++++++
>  arch/arm/plat-omap/include/plat/board-sdp.h  |   15 ++
>  arch/arm/plat-omap/include/plat/board-zoom.h |   36 +++
>  arch/arm/plat-omap/include/plat/gpmc.h       |    4 +-
>  arch/arm/plat-omap/include/plat/nand.h       |    6 +
>  drivers/mtd/nand/omap2.c                     |   33 +--
>  15 files changed, 969 insertions(+), 160 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>  create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
>  create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>  create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h
>  create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Regards,
Nishanth Menon
