From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/3] ARM: dts: OMAP3: Use constants with MTD devices
Date: Tue, 11 Jun 2013 16:48:55 +0200
Message-ID: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:42729 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751489Ab3FKOtM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:49:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

Legacy board files use constants from sizes.h and mtd/partitions.h
to declare MTD partitions. This series performs the same with DT.

Necessary headers are added (patch 1), a NAND node is added to
omap3-overo (patch 2), and remaining DTS are converted (patch 3).

Patch 2 was tested on the real hardware. For patch 3, the resulting
DTB were diff'ed. The MTDPART_SIZ_FULL constant was used in DTS, when
it was the case in legacy board files. The size cell is thus changed
inside the binary output, so testing on the hardware is welcome, even
if it should work transparently.

Note that inside omap3430-sdp.dts (nor@0,0), it appears with
this series that partitions 'kernel-nor' and 'filesystem-nor' overlaps
by (2*SZ_128K), which is probably not desired.

Regards,

Florian

Florian Vaussard (3):
  ARM: dts: Add headers with constants for MTD partitions
  ARM: dts: Add omap3-overo NAND flash memory binding
  ARM: dts: OMAP3: Use MTD constants for OMAP3 boards

 arch/arm/boot/dts/omap3-devkit8000.dts |   10 +++---
 arch/arm/boot/dts/omap3-igep0020.dts   |   10 +++---
 arch/arm/boot/dts/omap3-igep0030.dts   |   10 +++---
 arch/arm/boot/dts/omap3-overo.dtsi     |   50 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi           |    2 +
 arch/arm/boot/dts/omap3430-sdp.dts     |   28 ++++++++--------
 include/dt-bindings/mtd/partitions.h   |   12 +++++++
 include/dt-bindings/sizes.h            |   52 ++++++++++++++++++++++++++++++++
 8 files changed, 145 insertions(+), 29 deletions(-)
 create mode 100644 include/dt-bindings/mtd/partitions.h
 create mode 100644 include/dt-bindings/sizes.h

-- 
1.7.5.4

