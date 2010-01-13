From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 0/3] nand support on zoom boards
Date: Wed, 13 Jan 2010 12:31:04 +0530
Message-ID: <ce9ab5791001122301xb852c95i116a50bf7e71d1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51380 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab0AMHBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 02:01:25 -0500
Received: by bwz27 with SMTP id 27so1718300bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 23:01:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 345704a79f15b0481b14d5d504b0bcdf55f2a9a6 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 12 Jan 2010 18:12:53 +0530
Subject: [PATCH] nand support on zoom boards

I have verified it on zoom2/3 support on zoom boards.
I still have not tried it on LDP (zoom1) board. So, I'll post patch
for same later.


Vimal Singh (3):
  OMAP: ZOOM: Introducing 'board-zoom-flash.c'
  OMAP3: Add support for NAND on ZOOM2 board
  OMAP3: Add support for NAND on ZOOM3 board

 arch/arm/mach-omap2/Makefile                  |    2 +
 arch/arm/mach-omap2/board-zoom-flash.c        |   85 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom2.c             |   49 ++++++++++++++
 arch/arm/mach-omap2/board-zoom3.c             |   49 ++++++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
 5 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
