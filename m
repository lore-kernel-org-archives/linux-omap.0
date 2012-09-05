From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 0/2] gpio-twl4030: add new device tree properties
Date: Wed,  5 Sep 2012 09:46:24 +0200
Message-ID: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:58397 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751395Ab2IEHqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 03:46:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

A number of platform data are missing when using twl4030/gpio from a
device tree. This patchset adds the missing properties, updates the 
documentation with the new bindings, and updates existing device trees.
It mainly enables LEDA and LEDB outputs, as well as pullups /
pulldowns on GPIOs.

The 1st patch changes the device driver and updates the documentation.
The 2nd patch updates the device trees for BeagleBoard and omap3-evm.

Changes since v1: 
- Patches on driver and documentation merged into the same patch
- Put device trees' values in hexadecimal
- Handle bool property using of_property_read_bool()
- Prefix the patches with the correct convention

Tested on Gumstix Overo. V1 was tested on omap3-evm by Vaibhav Hiremath.

BTW: who will merge this?

Regards,
Florian


Florian Vaussard (2):
  gpio/twl4030: get platform data from device tree
  ARM: dts: omap3: Add gpio-twl4030 properties for BeagleBoard and
    omap3-EVM

 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
 arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
 arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
 drivers/gpio/gpio-twl4030.c                        |   84 +++++++++++++------
 4 files changed, 96 insertions(+), 27 deletions(-)

-- 
1.7.5.4

