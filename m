From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 0/11] Some am3517 related patches [V2]
Date: Wed, 14 Apr 2010 16:30:13 +0800
Message-ID: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34854 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0DNIVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 04:21:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Changes from V1:
1, modify the mmc set_power part according to Adrian.Hunter.
2, Updated the config file.

Some am3517 related patches. The detaild changelog is below:


The following changes since commit eba014745cc806d625b6a553d1af6efd14e16321:
  Tony Lindgren (1):
        Linux-omap rebuilt: Updated to -rc3

are available in the git repository at:

  . devel

Stanley.Miao (12):
      omap: remove one of the define of INT_34XX_BENCH_MPU_EMUL
      AM3517: Add platform init code for EMAC driver
      AM3517: rename the i2c boardinfo to make it more readable
      AM3517: Add platform init code for regulator driver
      AM3517: Add audio codec platform data
      AM3517: Add nand platform data for am3517evm
      AM3517: initialize i2c subsystem after mux subsystem
      OMAP: fix a gpmc nand problem
      AM3517: Update the config file of am3517evm
      omap: init the gpio pinmux for mmc
      omap hsmmc: fix the hsmmc driver for am3517.
      AM3517: Add mmc platform data for am3517evm

 arch/arm/configs/am3517_evm_defconfig     |  599 ++++++++++++++++++++++++----
 arch/arm/mach-omap2/Makefile              |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c     |  392 ++++++++++++++++++-
 arch/arm/mach-omap2/devices.c             |    7 +
 arch/arm/mach-omap2/gpmc-nand.c           |    3 +
 arch/arm/mach-omap2/hsmmc.c               |   32 ++-
 arch/arm/mach-omap2/include/mach/am35xx.h |    9 +
 arch/arm/plat-omap/include/plat/irqs.h    |    2 -
 8 files changed, 938 insertions(+), 109 deletions(-)

