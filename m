From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap device tree changes for v3.15, part 2
Date: Fri, 7 Mar 2014 09:58:36 -0800
Message-ID: <20140307175835.GA23749@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36244 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaCGR6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 12:58:46 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit f777ba1780584b100ab9664cc06d04f3bb273a84:

  Merge tag 'for_3.15/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.15/dt (2014-03-02 14:22:03 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-part2

for you to fetch changes up to 18c49af3ee9e32a535413a949672bea726699f04:

  ARM: dts: am335x-evmsk: enable dual_emac mode (2014-03-05 11:53:36 -0800)

----------------------------------------------------------------
Part two of omap device tree changes enabling driver features
in the dts files.

----------------------------------------------------------------
Andrii.Tseglytskyi (2):
      ARM: dts: OMAP36xx: Add device node for ABB
      ARM: dts: OMAP4: Add device nodes for ABB

Balaji T K (3):
      ARM: dts: am437x gp-evm: add sd card dt nodes
      ARM: dts: am335x-evm: add SD card hotplug support
      ARM: dts: am43x-epos-evm: add SD card hotplug support

Florian Vaussard (1):
      ARM: dts: Add support for OMAP4 Gumstix DuoVero/Parlor

Imre Kaloz (1):
      ARM: OMAP2+: Use pdata quirks for wl12xx on the AM335x EV-MSK

Kishon Vijay Abraham I (1):
      ARM: dts: omap5: added dt properties to adapt to the new phy framwork

Nishanth Menon (1):
      ARM: dts: DRA7: Add device nodes for ABB

Roger Quadros (3):
      ARM: OMAP2+: Remove legacy_init_ehci_clk()
      ARM: dts: Get rid of incompatible ids for hci-omap USB host nodes
      ARM: dts: Update echi-omap DT binding example usage

Yegor Yefremov (1):
      ARM: dts: am335x-evmsk: enable dual_emac mode

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 .../devicetree/bindings/usb/ehci-omap.txt          |   2 +-
 .../devicetree/bindings/usb/ohci-omap3.txt         |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-evm.dts                   |   9 +
 arch/arm/boot/dts/am335x-evmsk.dts                 |  43 ++++
 arch/arm/boot/dts/am4372.dtsi                      |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |  27 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   9 +
 arch/arm/boot/dts/dra7.dtsi                        | 132 +++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   4 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |  20 ++
 arch/arm/boot/dts/omap4-duovero-parlor.dts         | 146 ++++++++++++
 arch/arm/boot/dts/omap4-duovero.dtsi               | 252 +++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
 arch/arm/boot/dts/omap4.dtsi                       |  30 ++-
 arch/arm/boot/dts/omap443x.dtsi                    |  26 +++
 arch/arm/boot/dts/omap4460.dtsi                    |  37 +++
 arch/arm/boot/dts/omap5-uevm.dts                   |   8 +-
 arch/arm/boot/dts/omap5.dtsi                       |   9 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  26 +--
 21 files changed, 758 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-duovero-parlor.dts
 create mode 100644 arch/arm/boot/dts/omap4-duovero.dtsi
