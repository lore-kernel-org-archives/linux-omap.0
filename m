From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/5] DT Fixes for OMAP4 and OMAP5 boards
Date: Mon, 18 Apr 2016 20:20:56 +0200
Message-ID: <cover.1461003660.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds DT nodes for:
* twl6030 gpadc for omap4 based boards (Pandaboard ES)
* twl6037 gpadc for omap5 based board (OMAP5EVM)
* omap5-board-common: ckobuffer (needed for high quality twl6040 audio)
* fix range problem with omap5 pinmux


H. Nikolaus Schaller (5):
  ARM: dts: twl6030: describe gpadc
  ARM: dts: omap5-board-common: describe gpadc for Palmas
  ARM: dts: omap5: fix range of permitted wakeup pinmux registers
  ARM: dts: omap5: describe control for ckobuffer
  ARM: dts: omap5-board-common: set up ckobuffer for twl6040

 arch/arm/boot/dts/omap5-board-common.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi              | 12 +++++++++++-
 arch/arm/boot/dts/twl6030.dtsi            |  6 ++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.7.3
