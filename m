From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v5 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Tue, 10 Nov 2009 15:31:49 +0530
Message-ID: <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	<20091109205250.GB23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63802 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbZKJKCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:02:05 -0500
Received: by fxm21 with SMTP id 21so790946fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 02:02:09 -0800 (PST)
In-Reply-To: <20091109205250.GB23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, vimal singh <vimalsingh@ti.com>

>From 225e5c1e38ba1d4a14757150b0b7caf1d8cab893 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 10 Nov 2009 15:24:29 +0530
Subject: [PATCH] OMAP: Adding flash support to SDP, ZOOM2 and LDP boards

This is v5 of this patch series.

This patch series adds flash support for NAND (in sdp, zoom2 and ldp),
OneNAND and NOR (in sdp)

Tested on Zoom2 by Vikram, On SDP by Vimal

Vimal Singh (4):
[PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
[PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
[PATCH-v5 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfig
[PATCH-v5 4/4] OMAP: 3430SDP: Enable NAND in defconfig

v4-v5:
[PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards:
Implemented Tony's comments.


 arch/arm/configs/omap_3430sdp_defconfig      |  591 ++++++++++++--------------
 arch/arm/configs/omap_zoom2_defconfig        |  333 +++++++++++----
 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c        |  326 ++++++++++++++
 arch/arm/mach-omap2/board-zoom-flash.c       |  196 +++++++++
 arch/arm/mach-omap2/board-zoom2.c            |    2 +
 arch/arm/plat-omap/include/plat/board-sdp.h  |   15 +
 arch/arm/plat-omap/include/plat/board-zoom.h |   36 ++
 arch/arm/plat-omap/include/plat/gpmc.h       |    2 +
 arch/arm/plat-omap/include/plat/nand.h       |    2 +
 13 files changed, 1103 insertions(+), 410 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
 create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h
 create mode 100644 arch/arm/plat-omap/include/plat/board-zoom.h


-- 
Regards,
Vimal Singh
