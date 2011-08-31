From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/6 V4] OMAP4: Temperature sensor driver
Date: Wed, 31 Aug 2011 22:55:04 +0530
Message-ID: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40345 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756887Ab1HaRZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 13:25:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7VHPNq2031664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 12:25:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7VHPMBS023193
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 22:55:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>

The patch series for the on die temperature sensor driver.
The patch set has the device file, omap4 on die temperature sensor
hwmon driver. hwmod, clk support. The patch set compiles
on top of LO tree Master branch.

This patch series is tested for boot-up on OMAP4460. The temperature
reading and the interrupts generation on crossing the temperature
thresholds also tested.

V4:
(1) Reordered the probe sequence in the driver.
(2) Introduced iounmap in the driver in the error paths and remove function.
(3) In case of user/application programming thresholds violating t_hot > t_cold
    condition, the driver automatically changes the other threshold to adhere
    to the condition.

V3:
(1) Fixed comments on the return values in the device file
(2) Removed unnecessary error messages.
(3) Redundant braces removed.
(4) Implemented binary search in place of linear for temp to adc conversion.
(5) Wrong usage of EINVAL corrected.

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

 Documentation/hwmon/omap_temp_sensor               |   26 +
 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |   70 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   61 ++
 arch/arm/mach-omap2/temp_sensor4460_data.c         |   63 ++
 arch/arm/mach-omap2/temp_sensor_device.c           |  188 +++++
 arch/arm/plat-omap/Kconfig                         |   12 +
 .../plat-omap/include/plat/temperature_sensor.h    |   93 ++
 drivers/hwmon/Kconfig                              |   11 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/omap_temp_sensor.c                   |  881 ++++++++++++++++++++
 12 files changed, 1396 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/hwmon/omap_temp_sensor
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
 create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h
 create mode 100644 drivers/hwmon/omap_temp_sensor.c

