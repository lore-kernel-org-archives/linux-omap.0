From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Sun, 23 Jun 2013 23:28:15 +0530
Message-ID: <1372010299-30141-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38425 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab3FWR7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Jun 2013 13:59:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, b-cousson@ti.com
Cc: arnd@arndb.de, avinashphilip@ti.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com, Pekon Gupta <pekon@ti.com>

(with Author Name fixed)
Changes v2 -> v3
- PATCH-1: re-arranged code to remove redundancy, added NAND_BUSWIDTH_AUTO
- PATCH-2: updated nand-ecc-opt DT mapping and Documentation
- PATCH-3: code-cleaning + changes to match PATCH-1
- PATCH-4 <DROPPED> update DT attribute for ti,nand-ecc-opt 
	- received feedback to keep DT mapping independent of linuxism
- PATCH-4:<NEW> : ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
	- independent patch for AM335x-evm.dts update based on PATCH-2

Changes v1 -> v2
	added 	[PATCH 3/4] and [PATCH 4/4]

Patches in this series:
[PATCH 1/4]: clean-up and optimization for supported ECC schemes.
[PATCH 2/4]: add separate DT options each supported ECC scheme.
[PATCH 3/4]: update BCH4 ECC implementation (using ELM or using lib/bch.h)
[PATCH 4/4]: ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt

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


Pekon Gupta (4):
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes
  mtd:nand:omap2: updated support for BCH4 ECC scheme
  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  65 ++-
 arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  14 +-
 drivers/mtd/nand/Kconfig                           |   7 +-
 drivers/mtd/nand/omap2.c                           | 482 ++++++++++-----------
 include/linux/platform_data/elm.h                  |   4 +
 include/linux/platform_data/mtd-nand-omap2.h       |  22 +-
 7 files changed, 307 insertions(+), 289 deletions(-)

-- 
1.8.1

