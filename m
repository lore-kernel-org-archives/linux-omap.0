From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 0/3] Some am3517 related patches [V4]
Date: Thu, 13 May 2010 20:39:28 +0800
Message-ID: <1273754371-26014-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44950 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818Ab0EMM3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 08:29:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: stanley.miao@windriver.com, tony@atomide.com

Changes from V3:
1, refresh the the patches against the current omap-for-linus branch
2, Added "features" in mmc->slot[i].

Stanley.Miao (3):
      AM3517: rename the i2c boardinfo to make it more readable
      omap: init the gpio pinmux for mmc
      omap hsmmc: fix the hsmmc driver for am3517

 arch/arm/mach-omap2/board-am3517evm.c |   20 ++++++++++----------
 arch/arm/mach-omap2/devices.c         |    9 +++++++++
 arch/arm/mach-omap2/hsmmc.c           |   27 +++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/mmc.h |    4 ++++
 4 files changed, 44 insertions(+), 16 deletions(-)

