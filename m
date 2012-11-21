From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in omap2plus_defconfig
Date: Wed, 21 Nov 2012 12:29:16 +0530
Message-ID: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42858 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab2KUG7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 01:59:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
leds and D_CAN drivers in omap2plus_defconfig.

These are the peripherals present in AM33XX family of devices.

AnilKumar Ch (7):
  ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
  ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
  ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad driver
  ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
  ARM: OMAP2+: omap2plus_defconfig: Enable DCAN controller

 arch/arm/configs/omap2plus_defconfig |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
1.7.9.5

