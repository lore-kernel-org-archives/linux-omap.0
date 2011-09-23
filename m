From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/11] OMAP: Add initial support for DT on OMAP3 & OMAP4
Date: Fri, 23 Sep 2011 22:23:08 +0200
Message-ID: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52389 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1IWUXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 16:23:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony, Grant,

Here is the first set of patches to add device-tree support for OMAP3+
platforms. 
That series mainly adds a minimal OMAP2+ generic board file for basic
DT support on OMAP2420, OMAP2430, OMAP3, OMAP4 and beyond. The goal is
to remove even the minimal static devices init in order to have
a fully generic OMAP board file. For the moment both UART and I2C need
to be initialized statically.

That series is a respin of several RFCs I sent previously and take into
account the comments mainly done by Arnd and Grant.

Patches are based on for_3.2/2_omap_device_dt
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/3_omap_devicetree

Please note that the Device Tree source files will be stored as well
in the following repository:
git://gitorious.org/omap/devicetree.git master

Comments are welcome.

Regards,
Benoit


Benoit Cousson (11):
  OMAP2+: Add SoC specific map_io functions
  arm/dts: Add initial device tree support for OMAP4 SoC
  arm/dts: Add support for OMAP4 PandaBoard
  arm/dts: Add support for OMAP4 SDP board
  arm/dts: Add initial device tree support for OMAP3 SoC
  arm/dts: Add support for OMAP3 Beagle board
  OMAP2+: board-generic: Add DT support to generic board
  OMAP2+: board-generic: Add i2c static init
  OMAP2+: l3-noc: Add support for device-tree
  arm/dts: OMAP4: Add a main ocp entry bound to l3-noc driver
  arm/dts: OMAP3+: Add mpu, dsp and iva nodes

 Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++
 Documentation/devicetree/bindings/arm/omap/iva.txt |   19 +++
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   19 +++
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   27 ++++
 arch/arm/boot/dts/omap3-beagle.dts                 |   29 ++++
 arch/arm/boot/dts/omap3.dtsi                       |   63 ++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   29 ++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   29 ++++
 arch/arm/boot/dts/omap4.dtsi                       |  103 +++++++++++++
 arch/arm/mach-omap2/Kconfig                        |    8 +-
 arch/arm/mach-omap2/board-generic.c                |  158 ++++++++++++++-----
 arch/arm/mach-omap2/common.c                       |   18 +++
 arch/arm/mach-omap2/devices.c                      |    5 +
 arch/arm/mach-omap2/omap_l3_noc.c                  |   23 +++-
 arch/arm/mach-omap2/pm.c                           |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    4 +
 16 files changed, 501 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
 create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
 create mode 100644 arch/arm/boot/dts/omap3.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-panda.dts
 create mode 100644 arch/arm/boot/dts/omap4-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap4.dtsi

