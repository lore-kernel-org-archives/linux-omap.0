From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH resent v3 0/3] DT Fixes for OMAP5 boards
Date: Tue, 25 Oct 2016 19:38:08 +0200
Message-ID: <cover.1477417090.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

2016-10-25 19:29:49: Changes V3:
* fix property name to enable twl6040 jack-detection and not jack_detection (Peter Ujfalusi)
* fix typo on bindings documentation
* fix typos in commit messages (Tony Lindgren)

2016-10-25 18:48:28: This patch series adds DT nodes for:
* twl6040 enable jack_detection (e.g. OMAP5EVM)
* twl6037 gpadc for omap5 based boards (e.g. OMAP5EVM)


H. Nikolaus Schaller (3):
  dts: omap5: board-common: add phandle to reference Palmas gpadc
  dts: omap5: board-common: enable twl6040 headset jack detection
  ASoC: omap-abe-twl6040: fix typo in bindings documentation

 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt | 2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi                    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.3
