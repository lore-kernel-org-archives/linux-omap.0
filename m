From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/3] gpio-twl4030: add new device tree properties
Date: Mon,  3 Sep 2012 15:54:48 +0200
Message-ID: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40793 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753479Ab2ICNzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 09:55:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

A number of platform data are missing when using twl4030/gpio from a
device tree. This patchset adds the missing properties, updates
existing device trees and updates the documentation of bindings.
It mainly enables LEDA and LEDB outputs, as well as pullups /
pulldowns on GPIOs.

The 1st patch changes the device driver.
The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
The 3rd patch updates the documentation of bindings.

Tested:
- Boot tested on Gumstix Overo for "ti,use-leds". Corresponding
  patch is not provided, as the device tree is not yet merged.
  The support can be found in the git tree [1], branch
  omap3-devel-dt-overo.
- Device trees for BeagleBoard and omap3-evm were compiled, but not
  tested on hardware.

Would someone be willing to test on BeagleBoard / omap3-evm?

Regards,
Florian

[1] https://github.com/vaussard/linux.git (not safe for merge)


Florian Vaussard (3):
  gpio-twl4030: get platform data from device tree
  gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM
  gpio-twl4030: updates the bindings for new dt properties

 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
 arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
 arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
 drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
 4 files changed, 98 insertions(+), 27 deletions(-)

-- 
1.7.5.4

