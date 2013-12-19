From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 0/9] Add device nodes for am43x epos and gp evm.
Date: Thu, 19 Dec 2013 18:03:32 +0530
Message-ID: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756992Ab3LSMd4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 07:33:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

The patch series adds support for enabling pwm backlight, i2c2, spi and
matrix gpio keys on am43x-epos-evm, while adding support for pwm, gpio keys
on gp evm.

Originally, this patches was divided into two seperate series,
merging them into one and rebasing them on top of Benoit for_3.14/dts 
branch so that it can be pushed at once.


Boot tested with Benoit for_3.14 +  tero clock series(1)
Tested on am43x-epos-evm, m43x-gp-evm.

There is a some bug while using regulators through backlight
driver on 3.13-rc1. So, tested pwm part with this temporary patch[2].

[1]: https://patchwork.kernel.org/patch/3009541/
[2]: http://www.spinics.net/lists/arm-kernel/msg288215.html

Patches are available at:
git://gitorious.org/linux-connectivity/linux-connectivity.git for_3.14

v1->v2:
No code change, just squash two series into one
and rebased it on benoit for_3.14/dts

Darren Etheridge (1):
  pinctrl: am43xx: dt-bindings: add MUX_MODE8

Lokesh Vutla (1):
  arm: dts: am437x-gp-evm: Add gp dts.

Sourav Poddar (6):
  arm: dts: am4372: Add pwm-cells property for ecap device.
  arm: dts: am43x-epos-evm: Add I2C2 data.
  arm: dts: am43x-epos-evm: Add SPI data.
  arm: dts: am437x-gp-evm: Add pwm backlight support.
  arm: dts: am437x-gp-evm: Enable gpio.
  arm: dts: am43x-gp-evm: Add matrix gpio keys.
  ARM: dts: am43x-epos-evm: Add pwm backlight support.

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/am4372.dtsi                      |    9 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  100 ++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   67 +++++++++++++
 include/dt-bindings/pinctrl/am43xx.h               |    1 +
 6 files changed, 181 insertions(+)
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm.dts

-- 
1.7.9.5

