From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 0/9] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Tue, 15 Oct 2013 11:19:48 +0530
Message-ID: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43978 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759144Ab3JOFvH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>


*changes v8 -> v9*
[PATCH 1/9] <no update from [PATCH v8 1/6]>
[PATCH 2/9] <only commit log updated from [PATCH v8 2/6]>
 As per feedbacks from Brian Norris <computersforpeace@gmail.com> previous
 revision [PATCH v8 3/6] and [PATCH 4/6] are split into following sub-patches:
- [PATCH 3/9] <new> replaces local reference with generic names (mtd, nand_chip)
- [PATCH 4/9] <new> enables auto-detection of bus-width
- [PATCH 5/9] <new> removes omap3_init_bch: populates ecc-scheme data
- [PATCH 6/9] <new> removes omap3_init_bch_tail: populates ecc-layout
- [PATCH 7/9] <new> replaces lib/bch.c with nand_bch.c wrapper
[PATCH 8/9] <no update same as [PATCH v8 5/6]
[PATCH 9/9] removed devm_free_xx functions


*Changes v7 -> v8*
[PATCH 1/6] <no updates>
[PATCH 2/6]
	- updated DT parsing of "ti,nand-ecc-opts" so that its "ham1" remains
		compatible to "sw","hw","hw-romcode"
	- updated DT parsing of "ti,elm-id" to retain compatibility to "elm_id"
	- using of_parse_phandle() to get ELM device pointer from DT
[PATCH 3..6/6] <commit log updates>


*Changes v6 -> v7*
[PATCH 1/6] <NEW> split from [PATCH v6 2/4] as per feedbacks from Brian Norris <computersforpeace@gmail.com>
[PATCH 2/6] incorporated feedbacks from DT maintainers
[PATCH 3/6] cleaned and incorporated feedbacks from Brian Norris <computersforpeace@gmail.com>
[PATCH 4/6] rebasing changes and cleanup
[PATCH 5/6] updated omap3430-sdp.dts
[PATCH 6/6] <NEW> updated for devm_xx


*Changes v5 -> v6*
[PATCH 1/4]: 
	- updated DT binding for gpmc-nand based on 'Olof Johansson's feedbacks
	http://lists.infradead.org/pipermail/linux-mtd/2013-August/048394.html
	- detection of ELM device via ti,elm-id DT node, moved to gpmc.c driver
[PATCH 2/4]
	- removed: support for following obselete ECC schemes
	OMAP_ECC_HAMMING_CODE_DEFAULT (S/W based 1-bit Hamming ECC)
	OMAP_ECC_HAMMING_CODE_HW_ROMCODE (H/W based 1-bit Hamming ECC scheme)
	- updated: using omap_oobinfo as chip->ecc.layout for all ecc-schemes
	- clean: error messages
[PATCH 3/4] cleaned to include changes for OMAP_ECC_BCH8_CODE_HW only
[PATCH 4/4] updated to include DT property changes


*Changes v4 -> v5*
- Rebased to linux-next 
IMPORTANT: Need to revert commit fb1585b, [PATCH 2/4] part of previous version
	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html

- Swapped PATCH-1 & PATCH-2 to maintain bisectibility & compilation dependency
	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047461.html

- PATCH-2: re-ordered call to is_elm_present() for later updates ELM driver
	- dropped changes in include/linux/platform_data/elm.h (not needed)
- PATCH-3: re-ordered call to is_elm_present() for later updates ELM driver
- Re-formated patch description (replaced tabs with white-spaces)


*Changes v3 -> v4*
(Resent with CC: devicetree-discuss@lists.ozlabs.org)
- [Patch 1/3] removed MTD_NAND_OMAP_BCH8 & MTD_NAND_OMAP_BCH4 from nand/Kconfig
	ECC scheme selectable via nand DT (nand-ecc-opt).
- [*] rebased for l2-mtd.git


*Changes v2 -> v3*
(Resent with Author Name fixed)
- PATCH-1: re-arranged code to remove redundancy, added NAND_BUSWIDTH_AUTO
- PATCH-2: updated nand-ecc-opt DT mapping and Documentation
- PATCH-3: code-cleaning + changes to match PATCH-1
- PATCH-4 <DROPPED> update DT attribute for ti,nand-ecc-opt 
	- received feedback to keep DT mapping independent of linuxism
- PATCH-4:<NEW> : ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
	- independent patch for AM335x-evm.dts update based on PATCH-2


*Changes v1 -> v2*
	added 	[PATCH 3/4] and [PATCH 4/4]


After this patch series, omap2-nand driver will supports following ECC schemes:
+---------------------------------------+---------------+---------------+
| ECC scheme                            |ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
| (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
|                                       |               |               |
|OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
| (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
|        ti,elm-id)                     |               |               |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
| (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
|                                       |               |               |
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
| (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
|        ti,elm-id)                     |               |               |
+---------------------------------------+---------------+---------------+


Pekon Gupta (9):
  mtd: nand: omap: combine different flavours of 1-bit hamming ecc
    schemes
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes
  mtd: nand: omap: cleanup: replace local references with generic
    framework names
  mtd: nand: omap: enable auto-detection of bus-width for omap-nand
    drivers
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  mtd: nand: omap: clean-up ecc layout for BCH ecc schemes
  mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH ECC
    instead of lib/bch.c
  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
  mtd: nand: omap: updated devm_xx for all resource allocation and free
    calls

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   3 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/mach-omap2/board-flash.c                  |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  47 +-
 drivers/mtd/nand/Kconfig                           |  30 +-
 drivers/mtd/nand/omap2.c                           | 623 +++++++++------------
 include/linux/platform_data/mtd-nand-omap2.h       |  18 +-
 8 files changed, 339 insertions(+), 402 deletions(-)

-- 
1.8.1

