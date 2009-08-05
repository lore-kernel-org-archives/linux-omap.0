From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Few more omap fixes for 2.6.31
Date: Wed, 05 Aug 2009 17:11:38 +0300
Message-ID: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49244 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbZHEOLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:11:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few more fixes for omap for review.

Regards,

Tony

---

Janboe Ye (1):
      OMAP3: Fix omap3 sram virtual addres overlap vmalloc space after increasing vmalloc size

Roger Quadros (2):
      OMAP3: RX51: Define TWL4030 USB transceiver in board file
      OMAP: GPIO: Fix incorrect gpio_get logic for output GPIOs

Sergio Aguirre (1):
      OMAP3: Overo: Fix smsc911x platform device resource value

Vikram Pandita (1):
      OMAP2/3: DMA errata correction


 arch/arm/mach-omap2/board-overo.c            |    2 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 ++
 arch/arm/plat-omap/dma.c                     |    4 +-
 arch/arm/plat-omap/gpio.c                    |   68 ++++++++++++++++++++++++--
 arch/arm/plat-omap/sram.c                    |    4 +-
 5 files changed, 75 insertions(+), 8 deletions(-)

-- 
Signature
