From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Move omap GPMC to live in drivers/bus
Date: Thu, 20 Nov 2014 14:28:18 -0800
Message-ID: <1416522501-14999-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47720 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbaKTW2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 17:28:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

Looks like we can now finally move omap GPMC (General Purpose
Memory Controller) to live under drivers for further clean-up
work.

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Prepare to move GPMC to drivers by platform data header
  ARM: OMAP2+: Move GPMC initcall to devices.c
  drivers: bus: Move omap gpmc code to live under drivers

 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   1 -
 arch/arm/mach-omap2/board-cm-t3517.c               |   1 -
 arch/arm/mach-omap2/board-flash.c                  |   4 +-
 arch/arm/mach-omap2/board-flash.h                  |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   1 -
 arch/arm/mach-omap2/devices.c                      |  26 +++
 arch/arm/mach-omap2/gpmc-nand.c                    |   1 -
 arch/arm/mach-omap2/gpmc-onenand.c                 |   1 -
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 ---
 arch/arm/mach-omap2/gpmc.h                         | 224 +--------------------
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 drivers/bus/Kconfig                                |   3 +
 drivers/bus/Makefile                               |   3 +-
 .../mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c   |  91 ++++++---
 .../gpmc-nand.h => include/linux/omap-gpmc.h       |  18 +-
 include/linux/platform_data/omap-gpmc.h            | 177 ++++++++++++++++
 20 files changed, 287 insertions(+), 298 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c (95%)
 rename arch/arm/mach-omap2/gpmc-nand.h => include/linux/omap-gpmc.h (54%)
 create mode 100644 include/linux/platform_data/omap-gpmc.h

-- 
2.1.3

