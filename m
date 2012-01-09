From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP3+: Add DT support for i2c, twl6030 and EVM
Date: Mon, 9 Jan 2012 17:34:53 +0100
Message-ID: <4F0B172D.6020105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41296 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304Ab2AIQfG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 11:35:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Tony,

If this is not too late, could you please pull the various OMAP device tree patches?

This series assume that all the drivers adaptation to DT are already merged and is based on my previous interrupt controller series.
It means it has a strong dependency with i2c tree, mfd tree and rtc tree.

I added as well the patch from Vaibhav for EVM early DT support.

Thanks,
Benoit


The following changes since commit 89f504c5376bb09bd08bb3a3fe4c80949a594069:
  Benoit Cousson (1):
        ARM: OMAP2+: board-generic: Use of_irq_init API

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.3/dt_i2c_twl_evm

Benoit Cousson (9):
      ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
      arm/dts: OMAP4: Add i2c controller nodes
      arm/dts: OMAP3: Add i2c controller nodes
      arm/dts: twl6030: Add DTS file for twl6030 PMIC
      arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
      arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
      arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
      arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
      ARM: OMAP2+: board-generic: Remove i2c static init

Vaibhav Hiremath (1):
      arm/dts: Add support for TI OMAP3 EVM board

 arch/arm/boot/dts/omap3-beagle.dts  |   29 +++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts     |   20 +++++++++++++
 arch/arm/boot/dts/omap3.dtsi        |   21 ++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts   |   34 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts     |   53 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |   28 ++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi      |   21 ++++++++++++++
 arch/arm/boot/dts/twl6030.dtsi      |   22 ++++++++++++++
 arch/arm/mach-omap2/board-generic.c |   48 +------------------------------
 arch/arm/mach-omap2/pm.c            |    8 +++++
 10 files changed, 238 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm.dts
 create mode 100644 arch/arm/boot/dts/twl4030.dtsi
 create mode 100644 arch/arm/boot/dts/twl6030.dtsi
