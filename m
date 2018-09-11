From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/11] dts: Update coresight device tree bindings
Date: Tue, 11 Sep 2018 11:17:01 +0100
Message-ID: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Gross <andy.gross@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, David Brown <david.brown@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, "Ivan T . Ivanov" <ivan.ivanov@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, lipengcheng8@huawei.com, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, orsonzhai@gmail.com, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Coresight DT bindings have been updated to obey the DTS rules
for label/address matching for graph nodes. The changes are in
coresight/next tree scheduled for v4.20. This series updates the
in kernel dts to match the new bindings along with updating a couple
of new examples (e.,g CATU) in the Documentation (which were missed
as they were still in flight when we created the series).

Please note that this should not be pulled for v4.19, which I assume
is a safe assumption. But please do pull it for v4.20.
The dt updates for the Juno boards were sent earlier with the original
DT update series and has been queued for v4.20.

Applies on coresight/next (which is based on v4.19) and should apply
cleanly on v4.19-rc3.


Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: David Brown <david.brown@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org
Cc: lipengcheng8@huawei.com
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: orsonzhai@gmail.com
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: xuwei5@hisilicon.com
Cc: zhang.lyra@gmail.com
Cc: arm@kernel.org

Suzuki K Poulose (11):
  Documentation: dts: Update coresight binding examples
  dts: hisilicon: Update coresight bindings for hardware ports
  dts: spreadtrum: Update coresight bindings for hardware ports
  dts: qcom: Update coresight bindings for hardware ports
  dts: arm: hisilicon: Update coresight bindings for hardware ports
  dts: arm: imx7{d,s}: Update coresight binding for hardware ports
  dts: arm: omap: Update coresight bindings for hardware ports
  dts: arm: qcom: Update coresight bindings for hardware ports
  dts: sama5d2: Update coresight bindings for hardware ports
  dts: ste-dbx5x0: Update coresight bindings for hardware port
  dts: tc2: Update coresight bindings for hardware ports

 .../devicetree/bindings/arm/coresight.txt          |  20 +-
 arch/arm/boot/dts/hip04.dtsi                       | 322 ++++++++++++---------
 arch/arm/boot/dts/imx7d.dtsi                       |  11 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  78 +++--
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  17 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  17 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  75 +++--
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 108 ++++---
 arch/arm/boot/dts/sama5d2.dtsi                     |  17 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  61 ++--
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  90 +++---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 147 ++++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  98 ++++---
 arch/arm64/boot/dts/sprd/sc9836.dtsi               |  74 +++--
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 183 +++++++-----
 15 files changed, 780 insertions(+), 538 deletions(-)

-- 
2.7.4
