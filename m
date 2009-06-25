From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap-fixes for 2.6.31 (Re: [PATCH 00/12] Omap
	fixes for 2.6.31)
Date: Thu, 25 Jun 2009 15:35:07 +0300
Message-ID: <20090625123506.GS7352@atomide.com>
References: <20090622113422.28477.27052.stgit@localhost> <20090625122728.GA11875@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbZFYMfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 08:35:24 -0400
Content-Disposition: inline
In-Reply-To: <20090625122728.GA11875@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090625 15:27]:
> On Mon, Jun 22, 2009 at 02:36:53PM +0300, Tony Lindgren wrote:
> > Here are some omap fixes for 2.6.31 for review.
> 
> All look fine.

The following changes since commit d888a4c76c51092993643f8992bf55b3c28da483:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../vapier/blackfin

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Adrian Hunter (2):
      OMAP2/3: gpmc-onenand: correct use of async timings
      OMAP3: RX51: Use OneNAND sync read / write

Andrew de Quincey (1):
      OMAP1: Fix N770 MMC support

Fernando Guzman Lugo (1):
      OMAP: IOMMU: function flush_iotlb_page is not flushing correct entry

Grazvydas Ignotas (1):
      OMAP2/3: mmc-twl4030: use correct controller in twl_mmc23_set_power

Huang Weiyi (1):
      OMAP1: remove duplicated #include

Jonathan McDowell (1):
      OMAP1: Fix compilation of arch/arm/mach-omap1/mailbox.c

Kalle Jokiniemi (1):
      OMAP3: DMA: Enable idlemodes for DMA OCP

Kevin Hilman (1):
      OMAP2/3: Add omap_type() for determining GP/EMU/HS

Roel Kluin (1):
      OMAP2/3: omap mailbox: platform_get_irq() error ignored

Tero Kristo (1):
      OMAP3: SRAM size fix for HS/EMU devices

Tony Lindgren (1):
      OMAP: Fix IOMEM macro for assembly

janboe (1):
      OMAP2/3: Initialize gpio debounce register

 arch/arm/mach-omap1/board-nokia770.c         |    3 ++-
 arch/arm/mach-omap1/mailbox.c                |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 arch/arm/mach-omap2/gpmc-onenand.c           |   21 +++++++++++++++++++--
 arch/arm/mach-omap2/id.c                     |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/mailbox.c                |    6 +++---
 arch/arm/mach-omap2/mmc-twl4030.c            |   13 ++++++++++++-
 arch/arm/plat-omap/dma.c                     |   13 +++++++++++++
 arch/arm/plat-omap/gpio.c                    |    1 +
 arch/arm/plat-omap/include/mach/cpu.h        |   22 +++++++++++-----------
 arch/arm/plat-omap/include/mach/dma.h        |   15 +++++++++++++++
 arch/arm/plat-omap/include/mach/io.h         |    2 +-
 arch/arm/plat-omap/iommu.c                   |    2 +-
 arch/arm/plat-omap/sram.c                    |    7 ++++++-
 14 files changed, 108 insertions(+), 22 deletions(-)
