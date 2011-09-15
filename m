From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 00/11] Device tree support for regulators
Date: Thu, 15 Sep 2011 16:51:56 +0530
Message-ID: <1316085727-15023-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933293Ab1IOLWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Hi Grant, Mark,

This RFC is an attempt to move the regulator mappings from
board files into device tree for OMAP. In the process I have
defined some helper routines for regulators and defined
the bindings for these.
The patches are based on top of Benoit's series which adds
DT support for i2c and twl for OMAP from here
git://gitorious.org/omap-pm/linux.git for_3.2/5_omap_dt_i2c_twl

I know Benoit is planning a respin of the series soon, in which
he intends to register all twl child nodes as platform devices,
which would mean I just drop the last patch in this series.
The first couple of patches in the series are just fixes and
cleanups leading to the regulator DT migration.

The series is tested on OMAP4SDP and OMAP4PANDA boards.

regards,
Rajendra

Rajendra Nayak (11):
  OMAP: TWL: Clean up mode and ops mask passed from board files
  regulator: Fix error check in set_consumer_device_supply
  DT: regulator: Helper routine to extract regulator_init_data
  omap4: SDP: Pass regulator_init_data from DT
  TWL: regulator: Make twl-regulator driver extract data from DT
  DT: regulator: Helper routine to extract fixed_voltage_config
  regulator: Make fixed regulator driver extract data from DT
  omap4: panda: Pass fixed regulator data from DT
  DT: regulator: Helper to extract regulator node based on supply name
  regulator: Implement consumer regulator mapping from device tree
  DT: regulator: register regulators as platform devices

 .../devicetree/bindings/regulator/regulator.txt    |   56 ++++++
 .../bindings/regulator/twl-regulator.txt           |   18 ++
 arch/arm/boot/dts/omap4-panda.dts                  |   10 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   16 ++
 arch/arm/mach-omap2/board-2430sdp.c                |    5 -
 arch/arm/mach-omap2/board-3430sdp.c                |   30 ----
 arch/arm/mach-omap2/board-4430sdp.c                |   10 -
 arch/arm/mach-omap2/board-cm-t35.c                 |   10 -
 arch/arm/mach-omap2/board-devkit8000.c             |   13 --
 arch/arm/mach-omap2/board-igep0020.c               |   11 --
 arch/arm/mach-omap2/board-ldp.c                    |    9 -
 arch/arm/mach-omap2/board-omap3beagle.c            |   10 -
 arch/arm/mach-omap2/board-omap3evm.c               |   14 --
 arch/arm/mach-omap2/board-omap3logic.c             |    5 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   26 ---
 arch/arm/mach-omap2/board-omap3stalker.c           |    8 -
 arch/arm/mach-omap2/board-omap3touchbook.c         |   10 -
 arch/arm/mach-omap2/board-overo.c                  |    5 -
 arch/arm/mach-omap2/board-rm680.c                  |    4 -
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   55 ------
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   14 --
 arch/arm/mach-omap2/twl-common.c                   |   44 -----
 drivers/mfd/twl-core.c                             |    3 +
 drivers/of/Kconfig                                 |    6 +
 drivers/of/Makefile                                |    1 +
 drivers/of/of_regulator.c                          |  183 ++++++++++++++++++++
 drivers/regulator/core.c                           |   25 +++-
 drivers/regulator/fixed.c                          |   20 ++-
 drivers/regulator/twl-regulator.c                  |   28 +++-
 include/linux/of_regulator.h                       |   42 +++++
 include/linux/regulator/driver.h                   |    3 +
 31 files changed, 406 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
 create mode 100644 drivers/of/of_regulator.c
 create mode 100644 include/linux/of_regulator.h

