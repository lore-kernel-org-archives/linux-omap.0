From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/15] arm: dts: Fix OPP and cooling device properties
Date: Fri, 25 May 2018 16:01:46 +0530
Message-ID: <cover.1527244200.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, Andrew Lunn <andrew@lunn.ch>, Andy Gross <andy.gross@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Chen-Yu Tsai <wens@csie.org>, David Brown <david.brown@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, Gregory Clement <gregory.clement@bootlin.com>, Heiko Stuebner <heiko@sntech.de>, Jason Cooper <jason@lakedaemon.net>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <matthias.bgg@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes missing OPP and cooling device properties for CPUs for the
ARM 32 bit platforms. This is build tested by the zero day testing
infrastructure as well.

Individual maintainers can pick the patches to their SoC trees or I will
ask ARM SoC maintainers to pick them up later.

--
viresh

Viresh Kumar (15):
  arm: dts: armada: Fix "#cooling-cells" property's name
  arm: dts: ls1021a: Add missing cooling device properties for CPUs
  arm: dts: mediatek: Add missing cooling device properties for CPUs
  arm: dts: rk322x: Add missing cooling device properties for CPUs
  arm: dts: uniphier: Add missing cooling device properties for CPUs
  arm: dts: sun: Add missing cooling device properties for CPUs
  arm: dts: exynos: Add missing cooling device properties for CPUs
  arm: dts: dra74x: Add missing cooling device properties for CPUs
  arm: dts: omap: Add missing cooling device properties for CPUs
  arm: dts: rk3288: Add missing cooling device properties for CPUs
  arm: dts: berlin: Add missing OPP properties for CPUs
  arm: dts: highbank: Add missing OPP properties for CPUs
  arm: dts: r8a7743: Add missing OPP properties for CPUs
  arm: dts: qcom: Add missing OPP properties for CPUs
  arm: dts: imx: Add missing OPP properties for CPUs

 arch/arm/boot/dts/armada-385-synology-ds116.dts |  2 +-
 arch/arm/boot/dts/berlin2.dtsi                  | 10 +++
 arch/arm/boot/dts/berlin2q.dtsi                 | 33 ++++++++++
 arch/arm/boot/dts/dra74x.dtsi                   | 10 +++
 arch/arm/boot/dts/exynos3250.dtsi               | 16 +++++
 arch/arm/boot/dts/exynos4210.dtsi               | 13 ++++
 arch/arm/boot/dts/exynos4412.dtsi               |  9 +++
 arch/arm/boot/dts/exynos5250.dtsi               | 23 +++++++
 arch/arm/boot/dts/highbank.dts                  | 30 +++++++++
 arch/arm/boot/dts/imx6dl.dtsi                   | 23 +++++++
 arch/arm/boot/dts/imx6q-cm-fx6.dts              | 66 +++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                    | 87 ++++++++++++++++++++++++-
 arch/arm/boot/dts/imx7d.dtsi                    |  5 ++
 arch/arm/boot/dts/ls1021a.dtsi                  |  1 +
 arch/arm/boot/dts/mt7623.dtsi                   |  3 +
 arch/arm/boot/dts/omap5.dtsi                    | 14 ++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi             | 24 +++++++
 arch/arm/boot/dts/r8a7743.dtsi                  |  9 +++
 arch/arm/boot/dts/rk322x.dtsi                   |  3 +
 arch/arm/boot/dts/rk3288.dtsi                   | 54 +++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                | 30 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 13 ++++
 arch/arm/boot/dts/sun8i-a33.dtsi                |  9 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                 |  9 +++
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |  3 +
 25 files changed, 495 insertions(+), 4 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
