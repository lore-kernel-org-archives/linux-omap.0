From: Benoit Cousson <bcousson@baylibre.com>
Subject: [GIT PULL] ARM: OMAP: Some more Device Tree for 3.13
Date: Tue, 22 Oct 2013 12:25:49 +0200
Message-ID: <526652AD.8060806@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:55014 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3JVKZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 06:25:52 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so1219427bkb.17
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 03:25:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Tony,

Please pull the branch for few more OMAP Device Tree for v3.13 or later.

Thanks,
Benoit


The following changes since commit 6cf02dbb4b71f1c0c9acec89ae2df3b2318135f4:

  ARM: dts: dra7-evm: Add mmc2 node for eMMC support (2013-10-11 21:15:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.13_late/dts_signed

for you to fetch changes up to 6a96867844895008558810853c7838af39dd317c:

  ARM: dts: AM33xx+: Add i2c aliases (2013-10-22 11:05:42 +0200)

----------------------------------------------------------------
Add i2c aliases
Add McASP and audio support
Add reset/idle on init bindings for OMAP
Add more nodes for AM4272

----------------------------------------------------------------
Darren Etheridge (1):
      ARM: dts: am335x-evm: Add audio support for am335x-evm.dts

Enric Balletbo i Serra (1):
      ARM: dts: igep0033: Add mmc1 node for SDCARD support.

George Cherian (1):
      ARM: dts: OMAP5: Add dr_mode for dwc3

Jyri Sarha (1):
      ARM: dts: AM33XX: mcasp: Add location for data port registers to reg-property

Kishon Vijay Abraham I (1):
      ARM: dts: omap5-uevm: remove always_on, boot_on from smps10_out1

Lokesh Vutla (1):
      ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes

Mugunthan V N (1):
      ARM: dts: AM4372: Update Support for EPOS EVM

Nishanth Menon (3):
      ARM: dts: omap4-panda-es: Do not reset gpio1
      ARM: dts: OMAP3+: Add i2c aliases
      ARM: dts: AM33xx+: Add i2c aliases

Pantelis Antoniou (1):
      ARM: dts: AM33XX: Add mcasp0 and mcasp1 device tree entries

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Audio support
      ARM: dts: AM4372: Add McASP nodes

Rajendra Nayak (2):
      ARM: dts: omap: Add reset/idle on init bindings for OMAP
      ARM: dts: am335x-evmsk: Do not reset gpio0

Roger Quadros (2):
      ARM: dts: omap3: Adapt USB OTG to generic PHY framework
      ARM: dts: omap3-beagle: Adapt USB OTG to generic PHY framework

Sricharan R (1):
      ARM: dts: OMAP5: Remove clock-frequency field for cpu timers

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  50 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  52 +++++
 arch/arm/boot/dts/am335x-igep0033.dtsi             |  13 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  33 +++
 arch/arm/boot/dts/am4372.dtsi                      | 240 ++++++++++++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts               | 168 +++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                        |   5 +
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +
 arch/arm/boot/dts/omap3-gta04.dts                  |   2 +
 arch/arm/boot/dts/omap3-n900.dts                   |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   3 +
 arch/arm/boot/dts/omap4-panda-es.dts               |   4 +
 arch/arm/boot/dts/omap4.dtsi                       |   7 +
 arch/arm/boot/dts/omap5-uevm.dts                   |   2 -
 arch/arm/boot/dts/omap5.dtsi                       |   9 +-
 include/dt-bindings/pinctrl/am43xx.h               |  31 +++
 17 files changed, 621 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am43xx.h
