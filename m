From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Subject: [PATCH v2 0/3] Add support for Moxa UC-2100 series
Date: Fri, 28 Sep 2018 18:46:14 +0800
Message-ID: <20180928104614.30601-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>
List-Id: linux-omap@vger.kernel.org

The UC-2100 series open computing platform is designed for industrial
embedded data acquisition and processing applications. In order to
fulfill various industrial applications, there're many boards with
different peripheral devices and wireless modules in this series.

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

---
Changes from v1:
- Use property phy-handle instead of phy_id
- Separate DT binding docs and dts file
- Remove am335x-moxa-uc-2102.dts

SZ Lin (林上智) (3):
  ARM: dts: am335x: add common file for UC-2100 series
  dt-bindings: arm: omap: Add binding for Moxa UC-2101 open platform
  ARM: dts: am335x: add support for Moxa UC-2101 open platform

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  | 249 ++++++++++++++++++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  69 +++++
 4 files changed, 322 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts

-- 
2.19.0
