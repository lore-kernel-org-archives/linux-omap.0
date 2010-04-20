From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 0/7] Some am3517 related patches [V3]
Date: Tue, 20 Apr 2010 14:33:25 +0800
Message-ID: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55691 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab0DTGYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 02:24:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

Changes from V2:
1, Again, removed the controversial patches.

Some am3517 related patches. The detaild changelog is below:

Stanley.Miao (7):
      omap: fix the compile error if CONFIG_MTD_NAND_OMAP2 is not enabled
      omap: remove one of the define of INT_34XX_BENCH_MPU_EMUL
      AM3517: rename the i2c boardinfo to make it more readable
      AM3517: initialize i2c subsystem after mux subsystem
      OMAP: fix a gpmc nand problem
      omap: init the gpio pinmux for mmc
      omap hsmmc: fix the hsmmc driver for am3517.

 arch/arm/mach-omap2/board-am3517evm.c  |   24 ++++++++++++------------
 arch/arm/mach-omap2/devices.c          |    7 +++++++
 arch/arm/mach-omap2/gpmc-nand.c        |    3 +++
 arch/arm/mach-omap2/hsmmc.c            |   32 ++++++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/irqs.h |    2 --
 arch/arm/plat-omap/include/plat/nand.h |    7 +++++++
 6 files changed, 53 insertions(+), 22 deletions(-)

