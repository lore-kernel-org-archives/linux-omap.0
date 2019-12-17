From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] AM57xx: Fix bugs in device tree files
Date: Tue, 17 Dec 2019 14:21:21 +0530
Message-ID: <20191217085124.22480-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series
 *) Removes gpio property from endpoint device tree node (since it's
    used for driving PERST# line)
 *) Fix gpio used for driving PERST# line in AM571x IDK
 *) Model 5V0 regulator which is used for deriving the regulator
    connected to COMQ port in beagle x15

Kishon Vijay Abraham I (3):
  ARM: dts: am57xx-beagle-x15/am57xx-idk: Remove "gpios" for  endpoint
    dt nodes
  ARM: dts: am571x-idk: Fix gpios property to have the correct  gpio
    number
  ARM: dts: beagle-x15-common: Model 5V0 regulator

 arch/arm/boot/dts/am571x-idk.dts              |  6 +----
 arch/arm/boot/dts/am572x-idk-common.dtsi      |  4 ---
 .../boot/dts/am57xx-beagle-x15-common.dtsi    | 25 ++++++++++++++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.17.1
