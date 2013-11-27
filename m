From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/5] Add more device nodes for am43x-epos-evm
Date: Wed, 27 Nov 2013 13:00:42 +0530
Message-ID: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab3K0Ha6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 02:30:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, Sourav Poddar <sourav.poddar@ti.com>

The patch series adds support for enabling pwm backlight, i2c2, spi and
matrix gpio keys on am43x-gp-evm.

Done on top of 3.13-rc1 + tero clock series(1)

[1]: https://patchwork.kernel.org/patch/3009541/

Tested on am43x-gp-evm.

There is a some bug while using regulators through backlight
driver on 3.13-rc1. So, tested pwm part with this temporary patch[2].

[2]: http://www.spinics.net/lists/arm-kernel/msg288215.html

Darren Etheridge (1):
  pinctrl: am43xx: dt-bindings: add MUX_MODE8

Sourav Poddar (4):
  arm: dts: am4372: Add pwm-cellsproperty for ecap device.
  arm: dts: am43x-epos-evm: Add I2C data.
  arm: dts: am43x-epos-evm: Add SPI data.
  ARM: dts: am43x-epos-evm: Add pwm backlight support.

 arch/arm/boot/dts/am4372.dtsi        |    9 +++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   67 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/am43xx.h |    1 +
 3 files changed, 77 insertions(+), 0 deletions(-)

