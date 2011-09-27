From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/9] Device tree support for regulators
Date: Tue, 27 Sep 2011 15:42:43 +0530
Message-ID: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab1I0KNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 06:13:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

Hi Mark, Grant,

This is a respin of my RFC series I posted sometime back
and is now based on top of the latest omap i2c-twl support
series posted by Benoit
git://gitorious.org/omap-pm/linux.git for_3.2/4_omap_dt_i2c_twl

some changes done since the RFC:
1. twl driver fixed to remove hardcoded board params
2. regulator helpers moved from drivers/of to drivers/regulator
3. Better compatible definitions for specific device type
4. twl regulator driver doing internal table lookup based on
compatible rather then pdev->id
5. Seperate fixed voltage regulator bindings defined
6. Changed the way devices associate with regulators
i.e using <name>-supply = <&regulator-phandle>;

regards,
Rajendra

Rajendra Nayak (9):
  regulator: twl: Remove hardcoded board constraints from driver
  regulator: helper routine to extract regulator_init_data
  omap4: sdp: Pass regulator data from dt
  regulator: twl: Make twl-regulator driver extract data from DT
  regulator: helper routine to extract fixed_voltage_config
  regulator: make fixed regulator driver extract data from dt
  omap4: panda: Pass regulator data from DT
  regulator: helper to extract regulator node based on supply name
  regulator: map consumer regulator based on device tree

 .../bindings/regulator/fixed-regulator.txt         |   24 ++++
 .../devicetree/bindings/regulator/regulator.txt    |   42 +++++++
 .../bindings/regulator/twl-regulator.txt           |   60 +++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   54 ++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   64 ++++++++++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/core.c                           |   14 ++
 drivers/regulator/fixed.c                          |   54 ++++++++-
 drivers/regulator/of_regulator.c                   |  127 ++++++++++++++++++++
 drivers/regulator/twl-regulator.c                  |  125 ++++++++++++--------
 include/linux/regulator/driver.h                   |    3 +
 include/linux/regulator/fixed.h                    |    6 +-
 include/linux/regulator/machine.h                  |   12 +-
 include/linux/regulator/of_regulator.h             |   28 +++++
 15 files changed, 562 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h

