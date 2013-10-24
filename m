From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Thu, 24 Oct 2013 18:20:16 +0530
Message-ID: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051Ab3JXMva (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 08:51:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

*changes v10 -> v11*
- [PATCH v10 04/10] replaced with newer [PATCH v11 04/11] so that
  nand_scan_ident() is called only once.
  discussion thread with Brian Norris <computersforpeace@gmail.com>
  <http://lists.infradead.org/pipermail/linux-mtd/2013-October/049335.html>
- No change in any other patch


*changes v9 -> v10*
[PATCH 1/10], [PATCH 2/10]
  swapped [PATCH v9 1/9] and [PATCH v9 2/9] so that DT parsing updates
  (with backward compatibility) happen before the deprecation of DT values.
  This way DTB does not break functionally between the patches.
[PATCH 3/10] <no update>
[PATCH 4/10] 
  dropped [PATCH v9 4/9] introducing NAND_BUSWIDTH_AUTO, instead
  using DT 'nand-bus-width' for device bus-width. Refer discussion thread 
  <http://lists.infradead.org/pipermail/linux-mtd/2013-October/049198.html>
[PATCH 5/10] <no update>
[PATCH 6/10] <no update>
[PATCH 7/10] 
  separated out drivers/mtd/nand/Kconfig updates into separate [PATCH v10 10/10]
  cleanup: s/info->nand\./nand_chip->
[PATCH 8/10] <no update>
[PATCH 9/10] cleanup: s/out_release_mem_region/return_error
[PATCH 10/10] <new> spawned from [PATCH v9 8/9] for Kconfig updates


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


Pekon Gupta (10):
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes
  mtd: nand: omap: combine different flavours of 1-bit hamming ecc
    schemes
  mtd: nand: omap: cleanup: replace local references with generic
    framework names
  mtd: nand: omap: use DT specified bus-width only for scanning NAND
    device
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  mtd: nand: omap: clean-up ecc layout for BCH ecc schemes
  mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH ECC
    instead of lib/bch.c
  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
  mtd: nand: omap: updated devm_xx for all resource allocation and free
    calls
  mtd: nand: omap: remove selection of BCH ecc-scheme via KConfig

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   3 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/mach-omap2/board-flash.c                  |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  48 +-
 drivers/mtd/nand/Kconfig                           |  40 +-
 drivers/mtd/nand/omap2.c                           | 641 +++++++++------------
 include/linux/platform_data/mtd-nand-omap2.h       |  18 +-
 8 files changed, 348 insertions(+), 422 deletions(-)

-- 
1.8.1

