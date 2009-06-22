From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Omap fixes for 2.6.31
Date: Mon, 22 Jun 2009 14:36:53 +0300
Message-ID: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59326 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444AbZFVLg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:36:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are some omap fixes for 2.6.31 for review.

Regards,

Tony


---

Adrian Hunter (2):
      OMAP3: RX51: Use OneNAND sync read / write
      OMAP2/3: gpmc-onenand: correct use of async timings

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
 arch/arm/plat-omap/iommu.c                   |    2 +-
 arch/arm/plat-omap/sram.c                    |    7 ++++++-
 13 files changed, 107 insertions(+), 21 deletions(-)

-- 
Signature
