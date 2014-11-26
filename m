From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] move omap gpmc to drivers finally
Date: Wed, 26 Nov 2014 11:43:30 -0800
Message-ID: <20141126194330.GN2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62143 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbaKZTp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 14:45:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

The following changes since commit 6f8782a7a1c826e1c013d6b7d5504af6bcc079e6:

  ARM: OMAP2+: Remove unnecesary include in GPMC driver (2014-11-06 10:51:06 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gpmc-move

for you to fetch changes up to d2c70f553d7203b9bb37730e577be29794ae3169:

  memory: gpmc: Move omap gpmc code to live under drivers (2014-11-26 11:11:19 -0800)

----------------------------------------------------------------
We can finally move the GPMC code to live in drivers/memory
for further clean up work. This series does the move with
minimal changes to the code.

----------------------------------------------------------------
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
