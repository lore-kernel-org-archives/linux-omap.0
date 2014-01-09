From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 00/18] ARM: dts: Better support for Gumstix Overo
Date: Thu,  9 Jan 2014 17:47:54 +0100
Message-ID: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:40980 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbaAIQsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Hello,

This series adds a number of improvements to Gumstix Overo.

Patch 1+2: fix an issue with the vendor prefix (reported long ago by Javier Martinez Canillas)
Patch 3+4: add some missing pinctrl entries
Patch 5: completely turn off the PMIC on power off
Patch 6: enable the on-board Wifi
Patch 7: add the high-speed USB PHY
Patch 8: add specific timings for LAN9221 into a generic file
-> This might interest other people using the same chip, result in doubled bandwith

Patch 9: simplify omap3-tobi by using patch 8
Patch 10: add support for AT24C01 EEPROM used on expansion boards
Patch 11: factorize parts common to all expansion boards
Patch 12: rename omap3-tobi to omap3-overo-tobi
-> I do not know to which extent this might qualify as an API breakage,
   but the new name is far better IMHO

Patch 13 to 17: add new extension boards (Palo43, Gallop43, Alto35, Chestnut43, Summit)
Patch 18: add the HDMI output
-> this patch depends on Tomi Valkeinen's DT binding for OMAPDSS, which is
   not yet merged, so this patch will have to wait


The patches 13 to 17 are based on the hardware schematics and compile-tested, as I
do not have the necessary hardware (anyone willing to send me some boards ? :-)
We are mainly missing the support for the various LCDs, the accelerometer + probably
other small things.

This series is based on Tony's omap-for-v3.14/dt branch + work from Tomi [1] for the patch 18.

Benoit: I guess that I am too late for the 3.14... ?

Regards,

Florian


Florian Vaussard (18):
  of: add vendor prefix for Gumstix
  ARM: dts: omap3-tobi: Use the correct vendor prefix
  ARM: dts: omap3-tobi: Add missing pinctrl
  ARM: dts: omap3-overo: Add missing pinctrl
  ARM: dts: omap3-overo: Use complete poweroff
  ARM: dts: omap3-overo: Enable MMC2
  ARM: dts: omap3-overo: Add HSUSB PHY
  ARM: dts: omap: Add common file for SMSC9221
  ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
  ARM: dts: omap3-tobi: Add AT24C01 EEPROM
  ARM: dts: omap3-tobi: Create a file for common Gumstix peripherals
  ARM: dts: omap3-tobi: Rename to omap3-overo-tobi
  ARM: dts: Add support for the Overo Palo43
  ARM: dts: Add support for the Overo Gallop43
  ARM: dts: Add support for the Overo Alto35
  ARM: dts: Add support for the Overo Chestnut43
  ARM: dts: Add support for the Overo Summit
  ARM: dts: overo: Add support for DVI output

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |  58 ++++++++++
 arch/arm/boot/dts/omap3-overo-alto35.dts           |  52 +++++++++
 arch/arm/boot/dts/omap3-overo-chestnut43.dts       |  76 +++++++++++++
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi      | 108 ++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-common.dtsi          |  39 +++++++
 arch/arm/boot/dts/omap3-overo-gallop43.dts         |  51 +++++++++
 arch/arm/boot/dts/omap3-overo-palo43.dts           |  52 +++++++++
 arch/arm/boot/dts/omap3-overo-summit.dts           |  30 +++++
 .../dts/{omap3-tobi.dts => omap3-overo-tobi.dts}   |  41 +------
 arch/arm/boot/dts/omap3-overo.dtsi                 | 122 +++++++++++++++++++--
 12 files changed, 594 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-chestnut43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-gallop43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi.dts} (54%)

-- 
1.8.1.2

