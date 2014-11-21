From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/3] Move omap GPMC to live in drivers/memory
Date: Fri, 21 Nov 2014 10:34:13 -0800
Message-ID: <1416594856-15201-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57062 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbaKUSeh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 13:34:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Here's version 2 of the patches to move omap GPMC (General Purpose
Memory Controller) to live under drivers for further clean-up
work.

Changes from the first version are:

- Few randconfig fixes for the first patch in the series

- Don't include mach-omap2/gpmc.h any longer in any files
  we touch in this patch series, just keep it around for
  legacy reasons

- Move GPMC to drivers/memory instead of drivers/bus

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Prepare to move GPMC to drivers by platform data header
  ARM: OMAP2+: Move GPMC initcall to devices.c
  memory: gpmc: Move omap gpmc code to live under drivers

 MAINTAINERS                                        |   8 +
 arch/arm/mach-omap2/Kconfig                        |   2 +
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-am3517crane.c            |   1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |   3 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |   3 +-
 arch/arm/mach-omap2/board-flash.c                  |   4 +-
 arch/arm/mach-omap2/board-flash.h                  |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   3 +-
 arch/arm/mach-omap2/devices.c                      |  26 +++
 arch/arm/mach-omap2/gpmc-nand.c                    |   3 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |   3 +-
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 ---
 arch/arm/mach-omap2/gpmc.h                         | 228 +--------------------
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 .../gpmc.c => drivers/memory/omap-gpmc.c           |  91 +++++---
 .../gpmc-nand.h => include/linux/omap-gpmc.h       |  18 +-
 include/linux/platform_data/omap-gpmc.h            | 177 ++++++++++++++++
 22 files changed, 310 insertions(+), 302 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c (95%)
 rename arch/arm/mach-omap2/gpmc-nand.h => include/linux/omap-gpmc.h (54%)
 create mode 100644 include/linux/platform_data/omap-gpmc.h

-- 
2.1.3

