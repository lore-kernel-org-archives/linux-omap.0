From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap overo related device tree changes for v3.15
Date: Thu, 13 Mar 2014 13:02:54 -0700
Message-ID: <20140313200253.GB5981@atomide.com>
References: <20140313200135.GA5981@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbaCMUDC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:03:02 -0400
Content-Disposition: inline
In-Reply-To: <20140313200135.GA5981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-overo-signed

for you to fetch changes up to 28b191118c11719bb27db621425a70be28a40e08:

  ARM: dts: Add support for the Overo Summit (2014-03-12 10:21:16 -0700)

----------------------------------------------------------------
Updates to the .dts files to support more Gumstix boards.

These are sent separately from the rest of the .dts changes
as these depend on the fixes merged into v3.14-rc4, and
needed a bit more time to get updated on the fixes.

----------------------------------------------------------------
Florian Vaussard (16):
      ARM: dts: overo: reorganize include files
      ARM: dts: omap3-tobi: Add missing pinctrl
      ARM: dts: omap3-overo: Add missing pinctrl
      ARM: dts: omap3-overo: Enable WiFi/BT combo
      ARM: dts: omap3-overo: Add HSUSB PHY
      ARM: dts: omap: Add common file for SMSC9221
      ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
      ARM: dts: omap3-tobi: Add AT24C01 EEPROM
      ARM: dts: overo: Push uart3 pinmux down to expansion board
      ARM: dts: overo: Create a file for common Gumstix peripherals
      ARM: dts: overo: Add LIS33DE accelerometer
      ARM: dts: Add support for the Overo Palo43
      ARM: dts: Add support for the Overo Gallop43
      ARM: dts: Add support for the Overo Alto35
      ARM: dts: Add support for the Overo Chestnut43
      ARM: dts: Add support for the Overo Summit

 arch/arm/boot/dts/Makefile                         |  10 +
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |  58 ++++++
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  77 +++++++
 arch/arm/boot/dts/omap3-overo-alto35.dts           |  22 ++
 arch/arm/boot/dts/omap3-overo-base.dtsi            | 221 +++++++++++++++++++++
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  69 +++++++
 arch/arm/boot/dts/omap3-overo-chestnut43.dts       |  38 ++++
 .../boot/dts/omap3-overo-common-peripherals.dtsi   |  94 +++++++++
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  57 ++++++
 arch/arm/boot/dts/omap3-overo-gallop43.dts         |  38 ++++
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  53 +++++
 arch/arm/boot/dts/omap3-overo-palo43.dts           |  38 ++++
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     |  21 ++
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts |  38 ++++
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   |  38 ++++
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     |  38 ++++
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     |  30 +++
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       |   2 +-
 arch/arm/boot/dts/omap3-overo-storm.dtsi           |  35 ++++
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi   |  31 +++
 arch/arm/boot/dts/omap3-overo-summit.dts           |  30 +++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |  51 +----
 arch/arm/boot/dts/omap3-overo-tobi.dts             |   2 +-
 arch/arm/boot/dts/omap3-overo.dtsi                 |  97 ++-------
 24 files changed, 1063 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-base.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-chestnut43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-gallop43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-alto35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-palo43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-summit.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit.dts
