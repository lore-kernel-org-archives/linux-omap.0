From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap device tree changes for v3.6 merge window
Date: Tue, 10 Jul 2012 06:05:55 -0700
Message-ID: <49064.8885527209$1341925565@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11675 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2GJNF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 09:05:59 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-dt-for-v3.6

for you to fetch changes up to f700c4d780f14125f61b70e86d805908efe3fb89:

  arm/dts: New dts file for PandaBoardES (4460) (2012-07-09 05:37:05 -0700)

----------------------------------------------------------------
Device tree related patches for omaps

----------------------------------------------------------------
Afzal Mohammed (1):
      arm/dts: am33xx wdt node

AnilKumar Ch (4):
      arm/dts: Add initial DT support for AM33XX SoC family
      arm/dts: Add support for AM335x EVM
      arm/dts: Add support for AM335x BeagleBone
      arm/dts: remove MMC/SD and SPI related entries from am33xx.dtsi

Jon Hunter (1):
      arm/dts: OMAP2: Add support for OMAP2420H4 Board

Peter Ujfalusi (7):
      arm/dts: omap4: Add entry for OMAP McPDM IP
      arm/dts: omap4: Add entry for OMAP DMIC IP
      arm/dts: omap4-sdp: Add fixed regulator to represent VBAT
      arm/dts: omap4-sdp: Add support for twl6040
      arm/dts: omap4-sdp: Enable audio support via device tree
      arm/dts: omap4-panda: Audio support for PandaBoard 4430
      arm/dts: New dts file for PandaBoardES (4460)

Uri Yosef (1):
      arm/dts: OMAP4: Add Variscite OMAP4 System-On-Modeule support

Vaibhav Hiremath (2):
      arm/dts: Add support for TI AM3517/05 EVM board
      arm/dts: omap3-evm: Add i2c and twl4030 support

Xiao Jiang (3):
      arm/dts: add wdt node for omap3 and omap4
      ARM: OMAP: avoid build wdt platform device if with dt support
      watchdog: omap_wdt: add device tree support

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 .../devicetree/bindings/watchdog/omap-wdt.txt      |   14 ++
 arch/arm/boot/dts/am335x-bone.dts                  |   20 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   20 +++
 arch/arm/boot/dts/am33xx.dtsi                      |  158 ++++++++++++++++++++
 arch/arm/boot/dts/am3517-evm.dts                   |   32 ++++
 arch/arm/boot/dts/omap2420-h4.dts                  |   20 +++
 arch/arm/boot/dts/omap3-evm.dts                    |   28 ++++
 arch/arm/boot/dts/omap3.dtsi                       |    5 +
 arch/arm/boot/dts/omap4-panda.dts                  |   37 +++++
 arch/arm/boot/dts/omap4-pandaES.dts                |   24 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   68 +++++++++
 arch/arm/boot/dts/omap4-var_som.dts                |   96 ++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   23 +++
 arch/arm/mach-omap2/devices.c                      |    2 +-
 drivers/watchdog/omap_wdt.c                        |    7 +
 16 files changed, 556 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/omap-wdt.txt
 create mode 100644 arch/arm/boot/dts/am335x-bone.dts
 create mode 100644 arch/arm/boot/dts/am335x-evm.dts
 create mode 100644 arch/arm/boot/dts/am33xx.dtsi
 create mode 100644 arch/arm/boot/dts/am3517-evm.dts
 create mode 100644 arch/arm/boot/dts/omap2420-h4.dts
 create mode 100644 arch/arm/boot/dts/omap4-pandaES.dts
 create mode 100644 arch/arm/boot/dts/omap4-var_som.dts
