From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v1 0/2] ARM: dts: am335x-shc.dts: small updates for shc board
Date: Tue, 22 Jan 2019 06:26:21 +0100
Message-ID: <20190122052623.1779840-1-hs@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

small updates for am335x based shc board:
- switch DTS to SPDX identifier
- fix wrong gpio level for mmc1 cd pin


Heiko Schocher (2):
  ARM: dts: am335x-shc.dts: Switch to SPDX identifier
  ARM: dts: am335x-shc.dts: fix wrong cd pin level

 arch/arm/boot/dts/am335x-shc.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.2
