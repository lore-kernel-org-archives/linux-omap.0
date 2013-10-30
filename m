From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 30 Oct 2013 06:53:07 -0300
Message-ID: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43380 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752784Ab3J3JxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 05:53:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, Pekon Gupta <pekon@ti.com>, Brian Norris <computersforpeace@gmail.com>, marek.belisko@gmail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

As it was discussed recently in the mailing list, the omap2-nand driver currently
has an issue preventing proper ONFI detection of 16-bit devices (other drivers
may suffer from this same issue).

In an attempt to address such issue, this patch uses NAND_BUSWIDTH_AUTO
(actually discarding any DT property) and leaves the bus width detection
to the NAND core code.

This has been tested in a Beaglebone black (AM335x) board with a 16-bit Micron
NAND device, both ONFI and array-based detections work fine:

[    1.560945] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    1.569328] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xcc (Micron MT29F4G16ABADAH4)
[    1.577853] NAND device: 512MiB, SLC, page size: 2048, OOB size: 64
[    1.584448] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
[    1.591772] 8 ofpart partitions found on MTD device omap2-nand.0
[    1.598171] Creating 8 MTD partitions on "omap2-nand.0":
[    1.603797] 0x000000000000-0x000000020000 : "SPL1"
[    1.612926] 0x000000020000-0x000000040000 : "SPL2"
[    1.620112] 0x000000040000-0x000000060000 : "SPL3"
[    1.627192] 0x000000060000-0x000000080000 : "SPL4"
[    1.634205] 0x000000080000-0x000000260000 : "U-boot"
[    1.642708] 0x000000260000-0x000000280000 : "environment"
[    1.650410] 0x000000280000-0x000000780000 : "Kernel"
[    1.661828] 0x000000780000-0x000010000000 : "File-System"

Also, a quick run of nandtest ends successfully:

# nandtest /dev/mtd6
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 0
BBT blocks     : 0
004e0000: checking...
Finished pass 1 successfully

This time I've decided to submit this patch alone, so we can focus
the discussion on this issue. The other cleanups can wait.

AFAICS, the remaining questions are:

 1. Does this work in the 8-bit case?
 (I'm not able to test such case for lack of hardware)

 2. Do we want to re-configure the GPMC one the NAND core detects the
    device bus width?

Regarding this last question, and as I've exposed in the discussion with Pekon
about this [1], IMO, doing so is a bad design choice. It's not the NAND
driver's task to fix illed-prepared device-tree's or a badly configured memory
controller (GPMC).

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg97760.html

Ezequiel Garcia (1):
  mtd: nand: omap2: Fix device detection path

 drivers/mtd/nand/omap2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
1.8.1.5

