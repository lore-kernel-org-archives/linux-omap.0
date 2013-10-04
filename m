From: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 0/6] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Sat, 5 Oct 2013 01:19:42 +0530
Message-ID: <1380916188-24206-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Pawel.Moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


*Changes v6 -> v7*
[PATCH 1/6] <NEW> split from [PATCH v6 2/4] as per feedbacks of Brain Norris
[PATCH 2/6] incorporated feedbacks from DT maintainers
[PATCH 3/6] patch cleaning and incorporated feedbacks from Brain Norris
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
(Resent with CC: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org)
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
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
|OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
+---------------------------------------+---------------+---------------+

To optimize footprint of omap2-nand driver, selection of some ECC schemes
also require enabling following Kconfigs, in addition to setting appropriate
DT bindings
- Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
- Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engine


Pekon Gupta (6):
  mtd: nand: omap: combine different flavours of 1-bit hamming ecc
    schemes
  ARM: OMAP2+: cleaned-up DT support of various ECC schemes
  mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
    device_probe
  mtd:nand:omap2: updated support for BCH4 ECC scheme
  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
  mtd: nand: omap: updated devm_xx for all resource allocation and free
    calls

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   3 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/mach-omap2/board-flash.c                  |   2 +-
 arch/arm/mach-omap2/gpmc.c                         |  49 +-
 drivers/mtd/nand/Kconfig                           |  30 +-
 drivers/mtd/nand/omap2.c                           | 569 ++++++++++-----------
 include/linux/platform_data/mtd-nand-omap2.h       |  18 +-
 8 files changed, 335 insertions(+), 354 deletions(-)

-- 
1.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
