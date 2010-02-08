From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH v2 0/3] OMAP: NAND: support flashes on sdp boards
Date: Mon, 8 Feb 2010 16:51:54 +0530
Message-ID: <ce9ab5791002080321k459c159wbe843376a129528e@mail.gmail.com>
References: <ce9ab5791001122246v254bb721p68c58607a292fb8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f223.google.com ([209.85.218.223]:39563 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0BHLWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 06:22:16 -0500
Received: by bwz23 with SMTP id 23so991407bwz.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Feb 2010 03:22:14 -0800 (PST)
In-Reply-To: <ce9ab5791001122246v254bb721p68c58607a292fb8e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

On Wed, Jan 13, 2010 at 12:16 PM, Vimal Singh <vimal.newwork@gmail.com> wrote:
> From 4fbddd880c7a0da61fb66ae1d2c2553e3fbc82cb Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 12 Jan 2010 18:14:14 +0530
> Subject: [PATCH] OMAP: NAND: support flashes on sdp boards


Reposting this patch set again after fixes in 1st patch as per
comments from Tony:
- Removing 'nand_base' from functions specified and correcting
prototype in header file too
- calling gpmc_cs_request first

Rest of the patches in the series are untouched and just have been
re-based on LO master branch.

--
Vimal


>From d3e5ee6d8a6449aee01fbc93313201a4674f5577 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Mon, 8 Feb 2010 05:19:20 +0530
Subject: [PATCH] OMAP: NAND: support flashes on sdp boards

1st patch introduces 'gpmc-nand.c' for generic gpmc stuffs. Which may be
used by any omap board.

2nd and 3rd patches are to show up how to use 'gpmc-nand.c' with example
of 3430sdp board.

Vimal Singh (3):
  Introducing 'gpmc-nand.c' for GPMC specific NAND init
  OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init
  OMAP3: Add support for flash on 3430SDP board

 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-3430sdp.c          |  111 ++++++++++
 arch/arm/mach-omap2/board-sdp-flash.c        |  295 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-nand.c              |  139 ++++++++++++
 arch/arm/mach-omap2/include/mach/board-sdp.h |   22 ++
 arch/arm/plat-omap/include/plat/gpmc.h       |    2 +
 arch/arm/plat-omap/include/plat/nand.h       |   10 +-
 drivers/mtd/nand/omap2.c                     |   35 +---
 8 files changed, 586 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
