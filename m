From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 0/2] mtd:nand:omap2: ECC support clean-up for omap2-nand driver
Date: Thu, 16 May 2013 11:41:58 +0530
Message-ID: <1368684720-26763-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50315 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab3EPGMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 02:12:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com

From: "Gupta, Pekon" <pekon@ti.com>

This patch series makes ECC scheme selection for omap2-nand driver more 
user-friendly.It also adds scalability for large page-sized NAND devices,
and adding new ECC schemes in future.

[PATCH 1/2]
	- clean-up and optimization for supported ECC schemes.
	- added checks for Kconfigs required by specific ECC schemes.

[PATCH 2/2]
	- add DT options for selecting supported ECC scheme.

Gupta, Pekon (2):
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  37 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  12 +-
 drivers/mtd/nand/omap2.c                           | 432 ++++++++++-----------
 include/linux/platform_data/elm.h                  |   4 +
 include/linux/platform_data/mtd-nand-omap2.h       |  22 +-
 6 files changed, 258 insertions(+), 251 deletions(-)

-- 
1.8.1

