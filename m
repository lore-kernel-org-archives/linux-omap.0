From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/7] OMAP: hwmod: consolidate duplicate data across
	OMAP2xxx/3xxx files
Date: Sat, 02 Jul 2011 02:44:44 -0600
Message-ID: <20110702084348.582.65635.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44622 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab1GBIp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 04:45:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series combines some duplicate omap_hwmod data across the OMAP2420,
OMAP2430, and OMAP3 data files.  The intention here is to reduce the amount
of kernel source code in arch/arm/mach-omap2/, although there is also a small
kernel size reduction.

Further cleanup and reorganization is forthcoming in later series; this is
simply the first round.

Boot-tested on OMAP4430 ES2 PandaBoard and OMAP3530 BeagleBoard.


- Paul

---

Paul Walmsley (7):
      omap_hwmod: use a null structure record to terminate omap_hwmod_addr_space arrays
      omap_hwmod: share identical omap_hwmod_addr_space arrays
      omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs arrays
      omap_hwmod: share identical omap_hwmod_mpu_irqs arrays
      omap_hwmod: use a terminator record with omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_class, omap_hwmod_class_sysconfig arrays


 arch/arm/mach-omap2/Makefile                       |   16 
 arch/arm/mach-omap2/omap_hwmod.c                   |  101 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  832 ++----------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  910 +++-----------------
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  173 ++++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  322 +++++++
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  130 +++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  150 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  654 +++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  357 ++++----
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |   20 
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   93 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   18 
 13 files changed, 1508 insertions(+), 2268 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c

