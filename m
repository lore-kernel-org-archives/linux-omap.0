From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/7] ARM: dts: overo: Add new expansion boards
Date: Tue, 11 Mar 2014 13:20:28 +0100
Message-ID: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54219 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbaCKMUy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:20:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This series adds the support for 5 new expansion boards from Gumstix:
- Palo43
- Gallop43
- Chestnut43
- Alto35
- Summit

The 1st patch is a preparatory work, in order to factorize some
peripherals that are common to most Gumstix expansion boards. Patch 2
adds the support for an accelerometer that is present on most boards.

Palo43, Gallop43 and Chestnut43 are all pretty similar. I tested
on a Gallop43 (with both OMAP35xx and OMAP36xx Overo).

Alto35 is slightly different. Again, I tested with both OMAP35xx and
OMAP36xx Overo.

Summit is pretty similar to Tobi. I do not have a Summit at hand,
but given the similarity with Tobi, it should work fine.

To avoid unnecessary duplications, I put all the common stuff for each
board inside an omap3-overo-xxx-common.dsti include file. By doing so,
I can have minimal SoC-specific omap3-overo-xxx.dts (omap34xx based)
and omap3-overo-storm-xxx.dts (omap36xx based) device trees.

This series depends on my previous Overo series [1]. A complete testing
tree (including the graphics support, soon to be posted) is available
at [2].

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/111558
[2] https://github.com/vaussard/linux.git (overo/for-3.15/review1)

Florian Vaussard (7):
  ARM: dts: overo: Create a file for common Gumstix peripherals
  ARM: dts: overo: Add LIS33DE accelerometer
  ARM: dts: Add support for the Overo Palo43
  ARM: dts: Add support for the Overo Gallop43
  ARM: dts: Add support for the Overo Alto35
  ARM: dts: Add support for the Overo Chestnut43
  ARM: dts: Add support for the Overo Summit

 arch/arm/boot/dts/Makefile                         | 10 +++
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   | 77 ++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-alto35.dts           | 22 +++++
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    | 69 ++++++++++++++++
 arch/arm/boot/dts/omap3-overo-chestnut43.dts       | 38 +++++++++
 .../boot/dts/omap3-overo-common-peripherals.dtsi   | 94 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi | 57 +++++++++++++
 arch/arm/boot/dts/omap3-overo-gallop43.dts         | 38 +++++++++
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   | 53 ++++++++++++
 arch/arm/boot/dts/omap3-overo-palo43.dts           | 38 +++++++++
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 21 +++++
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 38 +++++++++
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 38 +++++++++
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 38 +++++++++
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 30 +++++++
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi   | 31 +++++++
 arch/arm/boot/dts/omap3-overo-summit.dts           | 30 +++++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     | 38 +--------
 18 files changed, 725 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35.dts
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
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit.dts

-- 
1.8.3.2

