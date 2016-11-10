From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/5] mfd: palmas: add powerhold overriding during power off
Date: Thu, 10 Nov 2016 10:39:15 +0530
Message-ID: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

The series lets one over powerhold for pmic.
The powerhold is used to keep the pmic power on even
after the DEV_CTRL On bit is set to off.

Tested on am572x-idk board, dra72-evm, dra7-evm for poweroff. 

Keerthy (5):
  Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override
    property definition
  mfd: palmas: Remove redundant check in palmas_power_off
  mfd: palmas: Reset the POWERHOLD mux during power off
  arm: dts: am57xx-beagle-x15-common: Add overide powerhold property
  arm: dts: am57xx-idk-common: Add overide powerhold property

 .../devicetree/bindings/pinctrl/pinctrl-palmas.txt        |  9 +++++++++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi           |  1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi                  |  1 +
 drivers/mfd/palmas.c                                      | 15 +++++++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

-- 
1.9.1

