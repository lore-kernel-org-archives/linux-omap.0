From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/13] OMAP3+: Add DT support for early devices and i2c / twl6030
Date: Mon, 26 Sep 2011 18:50:08 +0200
Message-ID: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43240 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab1IZQui (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:50:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Grant, Tony,

This series is a rework of several series:
[RFC PATCH 00/10] OMAP: Add DT support for early init OMAP4 devices
http://www.spinics.net/lists/linux-omap/msg55977.html
[PATCH 00/13] OMAP4: Add DT support for i2c and twl6030 
http://www.spinics.net/lists/linux-omap/msg56524.html
[PATCH 0/7] OMAP3: Add basic DT support + i2c + twl
http://www.spinics.net/lists/linux-omap/msg56538.html

It adds a minimal i2c and twl support to allow the removal of the static
i2c init. A couple of basic i2c devices are added for panda, beagle and
sdp4430 boards.
Some early devices (gpio, spinlock) are added as well to remove any init
previously done before the machine_init.

It fixes several comments:
- Simplify the twl children creation thanks to Arnd proposal
- Add the twl-rtc DT support needed by the usage of regular
  of_platform_populate method to create twl children.
- Fix hwspinlock driver that was not building correctly as module
- Allow lecacy device initialization mechanism to work in case no dtb is
  passed by the bootloader.


Patches are based on for_3.2/3_omap_devicetree
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/4_omap_dt_i2c_twl

Tested on PandaBoard, sdp4430 and BeagleBoard-xM with and without CONFIG_OF.

Comments are welcome.

Regards,
Benoit


Benoit Cousson (13):
  hwspinlock: OMAP4: Add spinlock support in DT
  gpio/omap: Adapt GPIO driver to DT
  arm/dts: OMAP4: Add gpio nodes
  irq: Add stub for none DT build in irqdomain.h
  i2c: OMAP: Add DT support for i2c controller
  mfd: twl-core: Add initial DT support for twl4030/twl6030
  rtc: rtc-twl: Add DT support for RTC inside twl4030/twl6030
  arm/dts: OMAP4: Add i2c controller nodes
  arm/dts: OMAP3: Add i2c controller nodes
  arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
  arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
  arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
  OMAP2+: board-generic: Remove i2c static init

 .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++
 .../bindings/hwspinlock/omap-spinlock.txt          |    5 +
 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
 .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++
 Documentation/devicetree/bindings/rtc/twl-rtc.txt  |   12 ++
 arch/arm/boot/dts/omap3-beagle.dts                 |   38 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |   27 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |   44 ++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   62 +++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  106 +++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   41 +-------
 arch/arm/mach-omap2/gpio.c                         |    8 +-
 arch/arm/mach-omap2/hwspinlock.c                   |    5 +
 drivers/gpio/gpio-omap.c                           |  108 ++++++++++++++++++--
 drivers/hwspinlock/omap_hwspinlock.c               |   11 ++
 drivers/i2c/busses/i2c-omap.c                      |   26 ++++-
 drivers/mfd/twl-core.c                             |   53 +++++++++-
 drivers/rtc/rtc-twl.c                              |   10 ++-
 include/linux/irqdomain.h                          |    2 +
 19 files changed, 609 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
 create mode 100644 Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt

