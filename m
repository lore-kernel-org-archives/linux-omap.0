From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] arm: am335x: am335x evm sk: add touchscreen DT node
Date: Mon, 21 Oct 2013 15:13:22 -0500
Message-ID: <1382386404-6659-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab3JUUNP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Oct 2013 16:13:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

the following patches fix a typo on TSC/ADC DT binding while
maintaining backwards compatibility and add support for the
touchscreen available on am335x-evm-sk.

Patches have been tested with am335x-evm-sk with a couple patches
(already floating around the mailing lists) to get that board
booting in mainline.

cheers

Felipe Balbi (2):
  input: touchscreen: fix spelling mistake in TSC/ADC DT binding
  arm: dts: am335x sk: add touchscreen support

 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt       |  2 +-
 arch/arm/boot/dts/am335x-evm.dts                               |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                             | 10 ++++++++++
 drivers/input/touchscreen/ti_am335x_tsc.c                      |  9 ++++++++-
 4 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.4.GIT

