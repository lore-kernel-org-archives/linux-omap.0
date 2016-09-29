From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/3] ARM: dts: omap5 uevm: add LEDs, USR1 button and EEPROM
Date: Thu, 29 Sep 2016 07:25:35 +0200
Message-ID: <cover.1475126737.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Changes V3:
* remove unit addresses from LEDs [Rob Herring]

2016-09-28 20:08:23: Changes V2:
* fixed subject of patches to correctly tell that it is for omap5 evm
* changed default triggers a little to create a nicer default pattern

2016-09-27 07:26:14: These patches configure
* the EEPROM
* the LEDs (with some default triggers)
* the USR1 gpio button
for the OMAP5 UEVM board.

H. Nikolaus Schaller (3):
  ARM: dts: omap5 uevm: add EEPROM
  ARM: dts: omap5 uevm: add LEDs
  ARM: dts: omap5 uevm: add USR1 button

 arch/arm/boot/dts/omap5-uevm.dts | 92 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

-- 
2.7.3
