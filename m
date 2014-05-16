From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v6 0/4]  add parallel NAND support for TI's new OMAPx and AMxx platforms (Part-2)
Date: Fri, 16 May 2014 16:33:46 +0530
Message-ID: <1400238230-26357-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47738 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806AbaEPLEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 07:04:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Pekon Gupta <pekon@ti.com>

*changes v5 -> v6*
- removed explicit disabling of GPMC and ELM in am335x-bone-memorycape.dts
  as both modules are already disabled by default in am33xx.dtsi
- fixed comments for <range> and <reg> properties. keeping it consistent
  across platforms.
- fixed <reg size> property. Using 'exact' register space as in hardware.
- fixed DT properties for wait-pin monitoring. Added gpmc,wait-pin = <>
- using lower-case letter for hex digits
Rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap :omap-for-v3.16/dt


*changes v4 -> v5*
use lower-case hexadecimal numbers
add comments for using different memory sizes in <range> and <reg> properties
fix 'reg size' property for GPMC and ELM nodes in dra7.dtsi


*changes v3 -> v4*
fixed <reg> and <range> property for all GPMC DT nodes
added fix for am335x-evm and am437x-epos-evm
rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap +omap-for-v3.16/dt


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

 arch/arm/boot/dts/am335x-bone-memory-cape.dts | 123 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts             |   1 +
 arch/arm/boot/dts/am335x-boneblack.dts        |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts           | 108 ++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts          |   2 +-
 arch/arm/boot/dts/dra7-evm.dts                | 118 ++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                   |  20 +++++
 7 files changed, 372 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts

-- 
1.8.5.1.163.gd7aced9

