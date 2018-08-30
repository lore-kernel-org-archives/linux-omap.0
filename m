From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Subject: [PATCH 0/3] ARM: dts: am335x: add support for Moxa UC-2100 series
Date: Thu, 30 Aug 2018 12:09:26 +0800
Message-ID: <20180830040929.23357-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>
List-Id: linux-omap@vger.kernel.org

The UC-2100 series open computing platform is designed for industrial embedded 
data acquisition and processing applications. In order to fulfill various 
industrial applications, there're many boards with different peripheral
devices and wireless modules in this series.

The features of UC-2100 series are:
* eMMC
* SPI flash
* {1,2}x LAN (100/1000 Mbps in option)
* {1,2}x RS-232/422/485 ports, software-selectable
* EEPROM
* TPM 2.0
* Watchdog
* RTC
* User gpio-keys
* User LEDs
* User button
* GPS (option)
* 2x CANBus (option)
* Cellular module (option)
* Mini PCIe form factor with USB signal (option)
* MicroSD slot (option)

SZ Lin (林上智) (3):
  ARM: dts: am335x: add common file for UC-2100 series
  ARM: dts: am335x: add support for Moxa UC-2101 open platform
  ARM: dts: am335x: add support for Moxa UC-2102 open platform

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  | 249 ++++++++++++++++++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  63 +++++
 arch/arm/boot/dts/am335x-moxa-uc-2102.dts     | 200 ++++++++++++++
 5 files changed, 517 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2102.dts

-- 
2.19.0.rc1
