From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH-v4 0/4] OMAP: Adding flash support to SDP, ZOOM2 and LDP
	boards
Date: Mon, 26 Oct 2009 17:37:30 +0530
Message-ID: <ce9ab5790910260507y2d0067dk1c12f0439c6fe5d7@mail.gmail.com>
References: <63751.192.168.10.88.1252582264.squirrel@dbdmail.itg.ti.com>
	<ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58833 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbZJZMHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 08:07:46 -0400
Received: by fxm18 with SMTP id 18so11986832fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 05:07:50 -0700 (PDT)
In-Reply-To: <ce9ab5790909251957t5598e4efq765f86420426392e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>

I posted a patch series for this sometime back and did not get any respose.. :(
http://marc.info/?l=linux-omap&m=125258227301958&w=2

This time again I am posting these patches, with one more patch added
in series, after re-basing the patches on top of LO master head.

This patch series adds flash support for NAND (in sdp, zoom2 and ldp),
OneNAND and NOR (in sdp)

Tested on Zoom2 by Vikram, On SDP by Vimal

[PATCH-v4 1/4] OMAP2/3: Add support for flash on SDP boards
[PATCH-v4 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
[PATCH-v4 3/4] OMAP: Zoom2: Enable NAND and JFFS2 support in defconfig
[PATCH 4/4] OMAP: 3430SDP: Enable NAND in defconfig

 arch/arm/configs/omap_3430sdp_defconfig      |  574 +++++++++++--------------
 arch/arm/configs/omap_zoom2_defconfig        |  334 ++++++++++----
 arch/arm/mach-omap2/Makefile                 |    2
 arch/arm/mach-omap2/board-2430sdp.c          |    2
 arch/arm/mach-omap2/board-3430sdp.c          |    2
 arch/arm/mach-omap2/board-ldp.c              |    2
 arch/arm/mach-omap2/board-sdp-flash.c        |  327 ++++++++++++++
 arch/arm/mach-omap2/board-zoom-flash.c       |  196 ++++++++
 arch/arm/mach-omap2/board-zoom2.c            |    2
 arch/arm/plat-omap/include/plat/board-sdp.h  |   15
 arch/arm/plat-omap/include/plat/board-zoom.h |   36 +
 arch/arm/plat-omap/include/plat/gpmc.h       |    2
 arch/arm/plat-omap/include/plat/nand.h       |    2
 14 files changed, 1095 insertions(+), 403 deletions(-)

-- 
Regards,
Vimal Singh
