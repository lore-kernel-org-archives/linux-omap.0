From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 00/10] OMAP4: Add DT support for i2c and twl6030
Date: Fri, 9 Dec 2011 14:50:21 +0100
Message-ID: <1323438631-28124-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57544 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab1LINvA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 08:51:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony and Rob,

Here is the updated version of the i2c + twl DT adaptation.

This update, compared to v1 [1], is mainly due to the merge into 3.2 of
Andy's i2c cleanup series that was introducing a lot of pdata accesses
at runtime.

The pm.c was updated to prevent the SR / VP initialization in the DT
context since none of them is DT aware for the moment.

A couple of basic i2c devices are added for panda, beagle and sdp board.

Patches are based on for_3.3/2_dt_irq, to get the latest GIC binding,
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.3/3_omap_dt_i2c_twl

Tested on Beagle and sdp4430.

Comments are welcome.

Regards,
Benoit

[1] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-September/007821.html


Benoit Cousson (10):
  ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
  i2c: OMAP: Add DT support for i2c controller
  mfd: twl-core: Add initial DT support for twl4030/twl6030
  rtc: rtc-twl: Add DT support for RTC inside twl4030/twl6030
  arm/dts: OMAP4: Add i2c controller nodes
  arm/dts: OMAP3: Add i2c controller nodes
  arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
  arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
  arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
  ARM: OMAP2+: board-generic: Remove i2c static init

 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   42 ++++++++
 .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++
 Documentation/devicetree/bindings/rtc/twl-rtc.txt  |   12 +++
 arch/arm/boot/dts/omap3-beagle.dts                 |   38 ++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   28 ++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   45 +++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   63 ++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   28 ++++++
 arch/arm/mach-omap2/board-generic.c                |   48 +---------
 arch/arm/mach-omap2/pm.c                           |    8 ++
 drivers/i2c/busses/i2c-omap.c                      |  100 +++++++++++++-------
 drivers/mfd/twl-core.c                             |   53 ++++++++++-
 drivers/rtc/rtc-twl.c                              |   10 ++-
 13 files changed, 435 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt

