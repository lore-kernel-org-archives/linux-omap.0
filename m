From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/8] ARM: OMAP2+: AM33XX: Enable few drivers in omap2plus_defconfig
Date: Fri, 14 Dec 2012 11:02:56 +0530
Message-ID: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59355 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab2LNFde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 00:33:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
leds and D_CAN drivers in omap2plus_defconfig.

These are the peripherals present in AM33XX family of devices.

Changes from v1:
	- Incorporated martinez javier's comments on v1
	  * Enabled few more triggers in omap2plus_defconfig
	- Included Igor's patch, which modifies the omap2plus
	  defconfig for AM33XX devices.

AnilKumar Ch (7):
  ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
  ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
  ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad driver
  ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
  ARM: OMAP2+: omap2plus_defconfig: Enable DCAN controller

Igor Mazanov (1):
  ARM: OMAP2+: omap2plus_defconfig: Enable tps65217 PMIC

 arch/arm/configs/omap2plus_defconfig |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
1.7.9.5

