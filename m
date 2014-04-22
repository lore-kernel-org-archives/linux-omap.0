From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 0/4] add parallel NAND support for TI's new OMAPx and AMxx platforms (Part-2)
Date: Tue, 22 Apr 2014 13:03:36 +0530
Message-ID: <1398152020-19391-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbaDVHeE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 03:34:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

*changes v2 -> v3*
rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap :master
merged leftover patches (dra7-evm and am43x-epos-evm fix) from Part-1 series


*changes v1 -> v2*
[PATCH v2 1/2] created new DTS for memory-capes based on following feedbacks
  http://www.spinics.net/lists/linux-omap/msg104348.html from 'Nishanth Menon <nm@ti.com>'
  http://www.spinics.net/lists/linux-omap/msg104447.html from 'Tony Lindgren <tony@atomide.com>'
[PATCH v2 2/2] <same as [PATCH v1 1/3]>


*original v1*
This patch-set adds parallel NAND support on following TI platforms
 - AM335x (am335x-bone LT, am335x-boneblack): <disabled by default>
 - AM43xx (am437x-gp-evm)


Minal Shah (1):
  ARM: dts: dra7: add support for parallel NAND flash

Pekon Gupta (3):
  ARM: dts: am335x-bone: add support for beaglebone NAND cape
  ARM: dts: am437x-gp-evm: add support for parallel NAND flash
  ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition

 arch/arm/boot/dts/am335x-bone-memory-cape.dts | 130 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts             |   1 +
 arch/arm/boot/dts/am335x-boneblack.dts        |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts           | 107 +++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts          |   2 +-
 arch/arm/boot/dts/dra7-evm.dts                | 117 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                   |  20 ++++
 7 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts

-- 
1.8.5.1.163.gd7aced9

