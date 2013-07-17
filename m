From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 0/4] mtd: nand: omap: add support for BCH16_ECC
Date: Thu, 18 Jul 2013 01:22:02 +0530
Message-ID: <1374090726-9393-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55986 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab3GQTy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 15:54:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, Pekon Gupta <pekon@ti.com>

This patch series add support of BCH16_ECC scheme.
As BCH16_ECC scheme generates 26bytes of ECC syndrome per 512B data,
hence this scheme is usable only for NAND devices having 4K or above
page-size, as their OOB/spare area has enough space to accomodate ECC.

This patch series is applicable over an above following series:
[1] [Patch] mtd:nand:omap2: clean-up of supported ECC schemes 
 http://lists.infradead.org/pipermail/linux-mtd/2013-July/047530.html
[2] [Patch] optimize and clean-up of OMAP NAND and ELM driver
 http://lists.infradead.org/pipermail/linux-mtd/2013-July/047538.html

Also this BCH16_ECC patch series is sparsely tested, due to limited
availability of boards with 4K/224NAND, so request the users to test
the mentioned series, and provide Tested-by.


Pekon Gupta (4):
  mtd: nand: omap: add support for BCH16_ECC - DT updates
  mtd: nand: omap: add support for BCH16_ECC - ELM driver updates
  mtd: nand: omap: add support for BCH16_ECC - GPMC driver updates
  mtd: nand: omap: add support for BCH16_ECC - NAND driver updates

 .../devicetree/bindings/mtd/gpmc-nand.txt          |   7 ++
 arch/arm/mach-omap2/gpmc.c                         |  22 +++--
 drivers/mtd/devices/elm.c                          |  29 ++++++
 drivers/mtd/nand/omap2.c                           | 104 +++++++++++++++++++--
 include/linux/platform_data/elm.h                  |   8 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   7 +-
 6 files changed, 155 insertions(+), 22 deletions(-)

-- 
1.8.1

