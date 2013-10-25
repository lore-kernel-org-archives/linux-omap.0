From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 0/5] Assorted OMAP2 NAND clean-ups
Date: Fri, 25 Oct 2013 07:17:52 -0300
Message-ID: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54081 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548Ab3JYKSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:18:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, marek.belisko@gmail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hello everyone,

As it was discussed recently in the mailing list, the omap2-nand driver currently
has an issue preventing proper ONFI detection of 16-bit devices (other drivers
may suffer from this same issue).

In an attempt to address such issue, patch 2/5 "mtd: nand: omap2: Fix device
detection path" uses NAND_BUSWIDTH_AUTO (actually discarding any DT property)
and leaves the bus width detection the NAND core code.

I've based the patch in previously sent work by Pekon Gupta, did some work and
added my name on it. I hope it's fine to handle the authorship like this.
Otherwise, feel free to tell.

This has been tested in a Beaglebone black (AM335x) board with a 16-bit Micron
NAND device, both ONFI and array-based detections work fine:

[    1.253200] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    1.260638] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xcc (Micron MT29F4G16ABADAH4)
[    1.269110] NAND device: 512MiB, SLC, page size: 2048, OOB size: 64
[    1.275721] Missing elm_id property, fall back to Software BCH
[    1.283546] enabling NAND BCH ecc with 8-bit correction
[    1.290219] 8 ofpart partitions found on MTD device omap2-nand.0
[    1.296591] Creating 8 MTD partitions on "omap2-nand.0":
[    1.302192] 0x000000000000-0x000000020000 : "SPL1"
[    1.309884] 0x000000020000-0x000000040000 : "SPL2"
[    1.316332] 0x000000040000-0x000000060000 : "SPL3"
[    1.322599] 0x000000060000-0x000000080000 : "SPL4"
[    1.328877] 0x000000080000-0x000000260000 : "U-boot"
[    1.336763] 0x000000260000-0x000000280000 : "environment"
[    1.343575] 0x000000280000-0x000000780000 : "Kernel"
[    1.354074] 0x000000780000-0x000010000000 : "File-System"

Also, a quick run of nandtest ends successfully:

$ nandtest /dev/mtd7
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 2
BBT blocks     : 0
Bad block at 0x00000000
Bad block at 0x00520000
[...]
Finished pass 1 successfully

The first patch 1/5 is included just for reference of the DT GPMC configuration
currently in use, together with required pinmuxing, in case anyone feels like
testing. It's not intended to be merged, since it doesn't belong to the Beaglebone
board itself, but instead it's an attached daughter board.

The other patches are just minor cleanups I came across while looking at the code.
As usual, the patchset applies on top of latest l2-mtd's master branch.

Pekon, Brian: Do you think this solution might work for 8-bit and 16-bit devices?

I've been going through the GPMC code again, and it looks like some cleaning is needed
there two, but that's a different story!

Feel free to comment or provide any feedback!

Changes from v1:

  * As noticed by Belisko Marek, re-added the out_free_info label
    in PATCH 4/5 to prevent build failures. The result is the same
    and the label is removed in the last patch, together with the last
    users of it.

Ezequiel Garcia (3):
  mtd: nand: omap2: Fix OMAP_BCH option dependency
  mtd: nand: omap2: Use devm_kzalloc
  mtd: nand: omap2: Use devm_ioremap_resource

Pekon Gupta (2):
  ARM: am335x-bone: Add support for 16-bit NAND cape
  mtd: nand: omap2: Fix device detection path

 arch/arm/boot/dts/am335x-bone-common.dtsi | 28 ++++++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 75 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-boneblack.dts    | 69 ++++++++++++++++++++++++++++
 drivers/mtd/nand/Kconfig                  |  2 +-
 drivers/mtd/nand/omap2.c                  | 52 +++++----------------
 5 files changed, 185 insertions(+), 41 deletions(-)

-- 
1.8.1.5

