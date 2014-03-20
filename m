From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 0/2] add parallel NAND support for TI's new OMAPx and AMxx platforms (Part-2)
Date: Thu, 20 Mar 2014 13:04:44 +0530
Message-ID: <1395300886-383-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39220 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbaCTHe6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 03:34:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Pekon Gupta <pekon@ti.com>

Series is rebased on following tree for OMAP DT
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap :omap-for-v3.15/dt

*changes v1 -> v2*
[PATCH v2 1/2] created new DTS for memory-capes based on following feedbacks
  http://www.spinics.net/lists/linux-omap/msg104348.html from 'Nishanth Menon <nm@ti.com>'
  http://www.spinics.net/lists/linux-omap/msg104447.html from 'Tony Lindgren <tony@atomide.com>'
[PATCH v2 2/2] <same as [PATCH v1 1/3]>


*original v1*
This patch-set adds parallel NAND support on following TI platforms
 - AM335x (am335x-bone LT, am335x-boneblack): <disabled by default>
 - AM43xx (am437x-gp-evm)

Pekon Gupta (2):
  ARM: dts: am335x-bone: add support for beaglebone NAND cape
  ARM: dts: am437x-gp-evm: add support for parallel NAND flash

 arch/arm/boot/dts/am335x-bone-memory-cape.dts | 130 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts             |   1 +
 arch/arm/boot/dts/am335x-boneblack.dts        |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts           | 107 +++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts

-- 
1.8.5.1.163.gd7aced9

