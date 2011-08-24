From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 0/7] OMAP: Add initial support for DT on OMAP4
Date: Wed, 24 Aug 2011 12:17:13 +0200
Message-ID: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1HXKSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 06:18:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Grant,

Here is the first part of patches to add device-tree support for OMAP4
platforms. It is partially based on initial works done by Manju for i2c.
The main difference is the usage of the notifier to create omap_device and
the addition of the hwmods bindings.
That series mainly clean the existing DT file and add an empty skeleton for
OMAP4 soc.
It adds as well a minimal OMAP4 board file for basic DT support. The goal
being to remove even the minimal static devices init in order to have a
fully generic OMAP board file.
The next one will start adding some real devices.

Patches are based on for_3.2/2_omap_device_dt + devicetree/test
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/3_omap4_dt_base

Thanks to your latest hack, for people who want to play with appended dtb:
 make uImage-dtb.omap4-panda
 make uImage-dtb.omap4-sdp

Comments are welcome.

Regards,
Benoit


Benoit Cousson (7):
  OMAP3+: boards: Fix the __initconst build error
  arm/dts: Add initial device tree support for OMAP4 SoC
  arm/dts: Update OMAP4 Panda to include common omap4.dtsi
  arm/dts: Add support for OMAP4 SDP board
  OMAP4: board-panda: Remove DT support from regular board
  OMAP4: board-dt: Add generic board with DT support
  documentation/dt: Add OMAP bindings

 .../devicetree/bindings/arm/omap/omap.txt          |   38 +++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   28 ++++-
 arch/arm/boot/dts/omap4-sdp.dts                    |   29 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   80 ++++++++++++++
 arch/arm/mach-omap2/Kconfig                        |    9 ++
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap4-dt.c               |  110 ++++++++++++++++++++
 arch/arm/mach-omap2/board-omap4panda.c             |    6 -
 arch/arm/mach-omap2/board-overo.c                  |    2 +-
 11 files changed, 293 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt
 create mode 100644 arch/arm/boot/dts/omap4-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap4.dtsi
 create mode 100644 arch/arm/mach-omap2/board-omap4-dt.c

