From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 0/4 v2] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Fri, 17 May 2013 17:20:14 +0530
Message-ID: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57201 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab3EQLvV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 May 2013 07:51:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

From: "Gupta, Pekon" <pekon@ti.com>

[Change v1 -> v2]
	added 	[PATCH 3/4] and [PATCH 4/4]

[PATCH 1/4]: clean-up and optimization for supported ECC schemes.
[PATCH 2/4]: add separate DT options each supported ECC scheme.
[PATCH 3/4]: update BCH4 ECC implementation (using ELM or using lib/bch.h)
[PATCH 4/4]: update DT attribute for ti,nand-ecc-opt

After this patch series, omap2-nand driver will supports following ECC schemes:
+---------------------------------------+---------------+---------------+
| ECC scheme				|ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
|OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
|OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
|OMAP_ECC_BCH4_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
|OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+
- Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
	Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH ECC algorithm.

- Selection of OMAP_ECC_BCHx_CODE_HW requires,
	Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W module.


Gupta, Pekon (4):
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes
  mtd:nand:omap2: updated support for BCH4 ECC scheme
  ARM: OMAP2+: updated ECC scheme attributes for omap2-nand DT

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  52 ++-
 arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  17 +-
 drivers/mtd/nand/Kconfig                           |   1 -
 drivers/mtd/nand/omap2.c                           | 413 +++++++++------------
 include/linux/platform_data/elm.h                  |   4 +
 include/linux/platform_data/mtd-nand-omap2.h       |  22 +-
 7 files changed, 253 insertions(+), 258 deletions(-)

-- 
1.8.1

