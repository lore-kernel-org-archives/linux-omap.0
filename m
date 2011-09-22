From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/6] system control module device and support for temperature sensor
Date: Thu, 22 Sep 2011 20:59:15 +0530
Message-ID: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48259 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1IVP30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTNID019383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTM3s025715
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

The patch series adds support of system control module device and adds support
temperature sensor. The patch series adds hwmod for system control module
and enables the clocks for temperature sensor. The OMAP4460 specific register
set data for the on die mpu temperature sensor is also part of this series.

Benoit Cousson (1):
  OMAP4: Hwmod: system control module hwmod

Keerthy (4):
  OMAP4: Adding the temperature sensor register set bit fields
  OMAP4: Clock: Associate clocks for OMAP temperature sensor
  OMAP4460: Temperature sensor data
  OMAP4: System control module device support

Vishwanath BS (1):
  OMAP4460: Clock: Adding support for 4460 specific clocks

 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/clock44xx_data.c               |   16 +-
 .../include/mach/ctrl_module_core_44xx.h           |   70 +++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   71 ++++++++
 arch/arm/mach-omap2/scm_device.c                   |  125 ++++++++++++++
 arch/arm/mach-omap2/temp_sensor4460_data.c         |  115 +++++++++++++
 arch/arm/plat-omap/Kconfig                         |   12 ++
 arch/arm/plat-omap/include/plat/scm.h              |  175 ++++++++++++++++++++
 8 files changed, 565 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-omap2/scm_device.c
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/scm.h

