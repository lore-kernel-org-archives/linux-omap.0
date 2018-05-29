From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/5] ARM: dts: dra7/am7xx: USB fixes and enhancements
Date: Tue, 29 May 2018 12:00:53 +0300
Message-ID: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

These are some fixes and enhancements for USB ports on dra7 and am57xx-idk EVMs.
If OK, please queue these for v4.18. Thanks.

Roger Quadros (5):
  ARM: dts: dra7: Disable metastability workaround for USB2
  ARM: dts: am57xx-idk: Enable dual role for USB2 port
  ARM: dts: dra7-evm: Add extcon to USB2 port
  ARM: dts: dra71-evm: Add VBUS GPIO to USB1/USB2 extcon
  ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon

 arch/arm/boot/dts/am571x-idk.dts         |  4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi |  4 ----
 arch/arm/boot/dts/am57xx-idk-common.dtsi |  7 ++++++-
 arch/arm/boot/dts/dra7-evm-common.dtsi   | 10 ++++++++++
 arch/arm/boot/dts/dra7-evm.dts           |  9 ---------
 arch/arm/boot/dts/dra7.dtsi              |  2 +-
 arch/arm/boot/dts/dra71-evm.dts          |  8 ++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi  |  1 +
 arch/arm/boot/dts/dra76-evm.dts          |  8 ++++++++
 9 files changed, 34 insertions(+), 19 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
