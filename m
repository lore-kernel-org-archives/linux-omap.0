From: Keerthy <j-keerthy@ti.com>
Subject: [RFC PATCH 0/6 V2] OMAP4: Temperature sensor driver
Date: Thu, 18 Aug 2011 16:22:09 +0530
Message-ID: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1HRKw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 06:52:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7IAqMxZ017442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 05:52:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7IAqMBu027116
	for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 16:22:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>

Hello,

The rfc patch series for the on die temperature sensor driver. I need
feedback on the overall structure of the driver.
The rfc patch set has the device file, omap4 on die temperature sensor
hwmon driver. hwmod, clk support. The patch set compiles
on top of LO tree Master branch.

This patch series is tested for boot-up on OMAP4460. The temperature
reading and the interrupts generation on crossing the temperature
thresholds also tested.

V2:
(1) Fixed comments on return values in the driver.
(2) Moved the TEMPSOFF setting code to the activate/deactivate hooks.
(3) Used idr to pass for the device id.

Benoit Cousson (1):
  OMAP4: Hwmod: OMAP temperature sensor

Keerthy (5):
  OMAP4: Clock: Associate clocks for OMAP temperature sensor
  OMAP4: Adding the temperature sensor register set bit fields
  OMAP4460: Temperature sensor data
  OMAP4: Temperature sensor device support
  hwmon: OMAP4: On die temperature sensor driver

 Documentation/hwmon/omap_temp_sensor               |   27 +
 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |   70 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   61 ++
 arch/arm/mach-omap2/temp_sensor4460_data.c         |   63 ++
 arch/arm/mach-omap2/temp_sensor_device.c           |  178 ++++
 arch/arm/plat-omap/Kconfig                         |   12 +
 .../plat-omap/include/plat/temperature_sensor.h    |   89 ++
 drivers/hwmon/Kconfig                              |   11 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/omap_temp_sensor.c                   |  918 ++++++++++++++++++++
 12 files changed, 1420 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/hwmon/omap_temp_sensor
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
 create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h
 create mode 100644 drivers/hwmon/omap_temp_sensor.c

