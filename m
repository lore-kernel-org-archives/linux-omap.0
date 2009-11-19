From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Thu, 19 Nov 2009 19:41:12 +0530
Message-ID: <ce9ab5790911190611r63830a5dxa7e2eab5f053c2a7@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	<20091109205250.GB23952@atomide.com> <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
	<ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50578 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZKSOL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:11:27 -0500
Received: by bwz27 with SMTP id 27so2379740bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 06:11:32 -0800 (PST)
In-Reply-To: <ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

Sorry, forgot to append diffstat. Listing below this time.

On Thu, Nov 19, 2009 at 7:38 PM, Vimal Singh <vimal.newwork@gmail.com> wrote:
> Here is the v6 of this patch series. I am cc'ing mtd list too this time.
>
>
> From 8bc97108cf9c78216f1ea5407ccbd900e6b63dc2 Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Thu, 19 Nov 2009 19:28:11 +0530
>
> This patch series adds flash support for NAND (in sdp, zoom and ldp),
> OneNAND and NOR (in sdp)
>
> Tested on Zoom2 and 3430SDP
>
> Vimal Singh (4):
> [PATCH-v6 1/4] OMAP2/3: Add support for flash on SDP boards
> [PATCH-v6 2/4] OMAP3: Add support for NAND on ZOOM/LDP boards
> [PATCH-v6 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfig
> [PATCH-v6 4/4] OMAP: 3430SDP: Enable NAND in defconfig
>
>
> v6 :
> 1. Implemented Tony's comments on below threads:
>
> [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
> http://marc.info/?l=linux-omap&m=125805845217778&w=2
>
> [PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
> http://marc.info/?l=linux-omap&m=125805867318269&w=2
>
> [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as module
> http://marc.info/?l=linux-omap&m=125787938923028&w=2
>
> 2. Creating 'mach-omap2/gpmc-nand.c' to handle GPMC related setups for
> the driver.
> 3. Removed all 'gpmc_cs_read_reg' and 'gpmc_cs_write_reg' calls from
> 'nand/omap2.c'
> 4. Corrected macro 'GPMC_CONFIG1_DEVICETYPE_NAND' for NAND
> 5. Removed 'nand unlock' routine in patch 2/4, will take this
> discussion to mtd list.
>
> v4-v5:
> [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards:
> Implemented Tony's comments.

 arch/arm/configs/omap_3430sdp_defconfig      |  140 +++++++----
 arch/arm/configs/omap_zoom2_defconfig        |  344 +++++++++++++++++++-------
 arch/arm/mach-omap2/Makefile                 |    8 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c        |  315 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-flash.c       |   92 +++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
 arch/arm/mach-omap2/gpmc-nand.c              |  128 ++++++++++
 arch/arm/plat-omap/include/plat/board-sdp.h  |   15 ++
 arch/arm/plat-omap/include/plat/board-zoom.h |   36 +++
 arch/arm/plat-omap/include/plat/gpmc.h       |    4 +-
 arch/arm/plat-omap/include/plat/nand.h       |    6 +
 drivers/mtd/nand/omap2.c                     |   33 +--
 15 files changed, 969 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h
 create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h
