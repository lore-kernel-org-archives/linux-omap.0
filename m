From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 0/2]OMAP: Introducing gpmc-nand.c
Date: Thu, 3 Dec 2009 19:33:56 +0530
Message-ID: <ce9ab5790912030603x4fb51ec1la3ea19ab9b06934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47192 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZLCOEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:04:10 -0500
Received: by bwz27 with SMTP id 27so1101557bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:04:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

>From fadc45cca4026d26d00a759efdc681303b0d3097 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 3 Dec 2009 18:35:23 +0530
Subject: [PATCH] OMAP: Introducing gpmc-nand.c

This patch series introduces generic gpmc-nand.c for nand device
related gpmc init.

Vimal Singh (2):
  Correcting GPMC_CONFIG1_DEVICETYPE_NAND
  Introducing 'gpmc-nand.c' for GPMC specific NAND init

 arch/arm/mach-omap2/Makefile           |    3 +
 arch/arm/mach-omap2/gpmc-nand.c        |  141 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 arch/arm/plat-omap/include/plat/nand.h |    6 ++
 drivers/mtd/nand/omap2.c               |   26 +-----
 5 files changed, 154 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
