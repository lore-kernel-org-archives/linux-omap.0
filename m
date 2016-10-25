From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/2] DT Fixes for OMAP5 boards
Date: Tue, 25 Oct 2016 18:48:24 +0200
Message-ID: <cover.1477414105.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds DT nodes for:
* twl6040 enable jack_detection (e.g. OMAP5EVM)
* twl6037 gpadc for omap5 based boards (e.g. OMAP5EVM)


H. Nikolaus Schaller (2):
  dts: omap5: baord-common: add phandle to reference Palmas gpadc
  dts: omap5: baord-common: enable twl6040 headset jack detection

 arch/arm/boot/dts/omap5-board-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.3
