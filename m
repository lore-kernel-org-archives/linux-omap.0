From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [CFT] OMAP patches
Date: Thu, 7 Jun 2012 12:06:10 +0100
Message-ID: <20120607110610.GB15973@n2100.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54287 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab2FGLGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:06:17 -0400
Content-Disposition: inline
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

And the last set - the OMAP patches.

 Documentation/feature-removal-schedule.txt |   11 +
 arch/arm/mach-omap1/board-h2-mmc.c         |    1 -
 arch/arm/mach-omap1/board-h3-mmc.c         |    1 -
 arch/arm/mach-omap1/board-nokia770.c       |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    1 -
 arch/arm/mach-omap2/hsmmc.c                |    1 -
 arch/arm/plat-omap/include/plat/mmc.h      |    2 -
 drivers/dma/Kconfig                        |    6 +
 drivers/dma/Makefile                       |    1 +
 drivers/dma/omap-dma.c                     |  522 ++++++++++++++++++++++++++++
 drivers/mmc/host/omap.c                    |  368 +++++++++-----------
 drivers/mmc/host/omap_hsmmc.c              |  202 ++++++------
 drivers/mtd/nand/omap2.c                   |  106 +++---
 drivers/spi/spi-omap2-mcspi.c              |  229 +++++++------
 include/linux/omap-dma.h                   |   24 ++
 15 files changed, 1010 insertions(+), 466 deletions(-)

