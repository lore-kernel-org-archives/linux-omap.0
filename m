From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH v2 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date: Wed, 11 Jul 2018 09:32:27 +0200
Message-ID: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@dominion.thruhere.net>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
but with the following differences:

 * Gigabit capable PHY
 * Extra USB hub, optional i2c control
 * lps3331ap barometer connected over i2c
 * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
 * 1GiB DDR3 RAM
 * RTL8723 Wifi/Bluetooth connected over USB

This series adds the Sancloud vendor prefix as well as the actual dts.

v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix barometer compatible string
v1: Initial submission, not the dts actually tested :/

Koen Kooi (2):
  dt-bindings: Add vendor prefix for Sancloud
  ARM: dts: am335x: add am335x-sancloud-bbe board support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 146 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts

-- 
2.0.1
