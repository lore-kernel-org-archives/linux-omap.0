From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Generic #pinctrl-cells and and pinctrl_parse_index_with_args
Date: Tue, 25 Oct 2016 09:45:34 -0700
Message-ID: <20161025164538.453-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some pinctrl changes to introduce #pinctrl-cells and a generic
parser pinctrl_parse_index_with_args that the drivers can optionally use.

Regards,

Tony


Tony Lindgren (4):
  pinctrl: Introduce generic #pinctrl-cells and
    pinctrl_parse_index_with_args
  pinctrl: single: Use generic parser and #pinctrl-cells for
    pinctrl-single,pins
  pinctrl: single: Use generic parser and #pinctrl-cells for
    pinctrl-single,bits
  ARM: dts: Add #pinctrl-cells for pinctrl-single instances

 .../bindings/pinctrl/pinctrl-bindings.txt          |  42 +++++-
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   3 +
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/boot/dts/am3517.dtsi                      |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   1 +
 arch/arm/boot/dts/da850.dtsi                       |   1 +
 arch/arm/boot/dts/dm814x.dtsi                      |   1 +
 arch/arm/boot/dts/dm816x.dtsi                      |   2 +
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/hi3620.dtsi                      |   2 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |   1 +
 arch/arm/boot/dts/keystone-k2l.dtsi                |   1 +
 arch/arm/boot/dts/omap2420.dtsi                    |   2 +
 arch/arm/boot/dts/omap2430.dtsi                    |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap34xx.dtsi                    |   1 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   1 +
 arch/arm/boot/dts/omap4.dtsi                       |   2 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +
 arch/arm/boot/dts/pxa3xx.dtsi                      |   1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   3 +
 drivers/pinctrl/devicetree.c                       | 151 ++++++++++++++++++++
 drivers/pinctrl/devicetree.h                       |  24 ++++
 drivers/pinctrl/pinctrl-single.c                   | 157 +++++++++++++++------
 24 files changed, 363 insertions(+), 43 deletions(-)

-- 
2.9.3
