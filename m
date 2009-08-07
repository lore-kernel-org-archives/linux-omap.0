From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap fixes for 2.6.31
Date: Fri, 7 Aug 2009 12:01:48 +0300
Message-ID: <20090807090145.GA2358@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54591 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbZHGJCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 05:02:02 -0400
Content-Disposition: inline
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

Here's the pull request for you.

Tony

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit ed680c4ad478d0fee9740f7d029087f181346564:
  Linus Torvalds (1):
        Linux 2.6.31-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Janboe Ye (1):
      OMAP3: Fix omap3 sram virtual addres overlap vmalloc space after increasing vmalloc size

Roger Quadros (4):
      OMAP: GPIO: Fix incorrect gpio_get logic for output GPIOs
      OMAP3: RX51: Define TWL4030 USB transceiver in board file
      OMAP2/3: mmc-twl4030: Free up MMC regulators while cleaning up
      OMAP3: RX51: Updated rx51_defconfig

Sergio Aguirre (1):
      OMAP3: Overo: Fix smsc911x platform device resource value

Vikram Pandita (1):
      OMAP2/3: DMA errata correction

 arch/arm/configs/rx51_defconfig              |    7 ++-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 ++
 arch/arm/mach-omap2/mmc-twl4030.c            |    6 ++
 arch/arm/plat-omap/dma.c                     |    4 +-
 arch/arm/plat-omap/gpio.c                    |   68 ++++++++++++++++++++++++--
 arch/arm/plat-omap/sram.c                    |    4 +-
 7 files changed, 85 insertions(+), 11 deletions(-)

--AhhlLboLdkugWU4S--
