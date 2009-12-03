From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 0/2]OMAP:SDP: Add flash support for SDP boards
Date: Thu, 3 Dec 2009 19:38:47 +0530
Message-ID: <ce9ab5790912030608w17ade0e3nf3ab3fdc07e5cf5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62940 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZLCOJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:09:02 -0500
Received: by bwz27 with SMTP id 27so1106004bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:09:07 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From f48199dc44e1bf5f56aa981d20f35dc8ce1113bf Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 3 Dec 2009 18:35:37 +0530
Subject: [PATCH] OMAP:SDP: Add flash support for SDP boards

This patch series introduces 'board-sdp-flash.c', for flash devices init on SDP
boards.
'2nd' patch in the series gives an example of using 'gpmc-nand.c' and
'board-sdp-flash.c' by adding flash support to 3430SDP board.

Vimal Singh (2):
  OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init
  OMAP3: Add support for flash on 3430SDP board

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-3430sdp.c          |  111 ++++++++++++
 arch/arm/mach-omap2/board-sdp-flash.c        |  246 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/board-sdp.h |   22 +++
 arch/arm/plat-omap/include/plat/gpmc.h       |    2 +
 5 files changed, 382 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
