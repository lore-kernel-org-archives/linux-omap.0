From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v6 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Thu, 19 Nov 2009 19:38:53 +0530
Message-ID: <ce9ab5790911190608r5b7e8226j3546714957ce70e6@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
	<ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
	<ce9ab5790911040328p215dede2v37db38a966a5bbd5@mail.gmail.com>
	<20091109205250.GB23952@atomide.com> <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50077 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZKSOJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 09:09:08 -0500
Received: by fxm21 with SMTP id 21so2437749fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 06:09:13 -0800 (PST)
In-Reply-To: <ce9ab5790911100201j6b1ef5e1g43a992b00e69ade4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

Here is the v6 of this patch series. I am cc'ing mtd list too this time.


>From 8bc97108cf9c78216f1ea5407ccbd900e6b63dc2 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 19 Nov 2009 19:28:11 +0530

This patch series adds flash support for NAND (in sdp, zoom and ldp),
OneNAND and NOR (in sdp)

Tested on Zoom2 and 3430SDP

Vimal Singh (4):
[PATCH-v6 1/4] OMAP2/3: Add support for flash on SDP boards
[PATCH-v6 2/4] OMAP3: Add support for NAND on ZOOM/LDP boards
[PATCH-v6 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfig
[PATCH-v6 4/4] OMAP: 3430SDP: Enable NAND in defconfig


v6 :
1. Implemented Tony's comments on below threads:

[PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
http://marc.info/?l=linux-omap&m=125805845217778&w=2

[PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
http://marc.info/?l=linux-omap&m=125805867318269&w=2

[PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as module
http://marc.info/?l=linux-omap&m=125787938923028&w=2

2. Creating 'mach-omap2/gpmc-nand.c' to handle GPMC related setups for
the driver.
3. Removed all 'gpmc_cs_read_reg' and 'gpmc_cs_write_reg' calls from
'nand/omap2.c'
4. Corrected macro 'GPMC_CONFIG1_DEVICETYPE_NAND' for NAND
5. Removed 'nand unlock' routine in patch 2/4, will take this
discussion to mtd list.

v4-v5:
[PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards:
Implemented Tony's comments.

-- 
Regards,
Vimal Singh
