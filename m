From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 0/4]: Adding NAND support for LDP/ZOOM boards
Date: Thu, 3 Dec 2009 19:43:15 +0530
Message-ID: <ce9ab5790912030613y6c1a584fsebd2e28ae906225f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53832 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158AbZLCON3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:13:29 -0500
Received: by bwz27 with SMTP id 27so1110100bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:13:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 1786a05d3331850ff5c49e4edafe68a411597173 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 3 Dec 2009 18:36:11 +0530
Subject: [PATCH] Adding NAND support for LDP/ZOOM boards

'1st' patch in this series introduces 'board-zoom-flash.c' for NAND
init in ZOOM boards.
Other three patch will add NAND support for ZOOM2, ZOOM3 and LDP.

I have tested it for ZOOM2 and ZOOM3 boards.
Could someone please test this for LDP boards?

Vimal Singh (4):
  OMAP: ZOOM: Introducing 'board-zoom-flash.c'
  OMAP3: Add support for NAND on ZOOM2 board
  OMAP3: Add support for NAND on ZOOM3 board
  OMAP3: Add support for NAND on LDP board

 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-ldp.c               |   41 +++++++++++++++++
 arch/arm/mach-omap2/board-zoom-flash.c        |   59 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c             |   49 ++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom3.c             |   49 ++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++++
 6 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
