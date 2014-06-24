From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 0/3] ARM: dts: am335x-bone: Beaglebone cape DTS
Date: Tue, 24 Jun 2014 17:54:23 +0530
Message-ID: <1403612666-31197-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34824 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaFXMZF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 08:25:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Pekon Gupta <pekon@ti.com>

This series adds DTS for following Beaglebone capes:

Memory Cape: http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
NAND Cape:   http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
NOR Cape:    http://elinux.org/Beagleboardtoys:BeagleBone_128Mb_16-Bit_NOR_Module
LCD4 Cape:   http://elinux.org/CircuitCo:BeagleBone_LCD4

Based on Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v3.16/dt-v2

Acceptance of cape DTS in mainline is still under discussion [1], so multiple
'Tested-by' would be helpful.
Note: In order to avoid conflicts with existing DTS, device nodes added in these
patches have status="disabled", and need to be "enabled" via u-boot.
DT nodes can be selectively enabled | disabled via u-boot [2]

Example: Below sequence works for NAND cape patch.
---------------
/* load DTB */
u-boot> tftp 0x81000000 am335x-boneblack.dtb
u-boot> fdt addr 0x81000000
/* disable MMC2 node */
u-boot> fdt list /ocp/mmc@481d8000
u-boot> fdt set  /ocp/mmc@481d8000 status \d\i\s\a\b\l\e\d
u-boot> fdt list /ocp/mmc@481d8000 status
/* enable GPMC node */
u-boot> fdt list /ocp/gpmc
u-boot> fdt set  /ocp/gpmc status \o\k\a\y
u-boot> fdt list /ocp/gpmc status
/* enable ELM node */
u-boot> fdt list /ocp/elm
u-boot> fdt set  /ocp/elm status \o\k\a\y
u-boot> fdt list /ocp/elm status
/* boot uImage */
tftp 0x82000000 uImage
bootm 0x82000000 - 0x81000000

Note: "fdt set" command does not accept string literals
as binding values, it internally converts them to string, so
escape sequenced characters were used here..
"okay" == \o\k\a\y
"disabled" == \d\i\s\a\b\l\e\d"
---------------

[1] http://www.spinics.net/lists/linux-omap/msg108505.html 
[2] http://www.denx.de/wiki/view/DULG/UBootCmdFDT


Pekon Gupta (3):
  ARM: dts: am335x-bone: add support for beaglebone NAND cape
  ARM: dts: am335x-bone: add support for beaglebone NOR cape
  ARM: dts: am335x-bone: add support for beaglebone LCD4 cape

 arch/arm/boot/dts/am335x-bone-display-cape.dts | 104 +++++++++++
 arch/arm/boot/dts/am335x-bone-memory-cape.dts  | 249 +++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts              |   2 +
 arch/arm/boot/dts/am335x-boneblack.dts         |   2 +
 4 files changed, 357 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-bone-display-cape.dts
 create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts

-- 
1.8.5.1.163.gd7aced9

