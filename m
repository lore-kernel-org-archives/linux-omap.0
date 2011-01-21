From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Fri, 21 Jan 2011 19:30:52 +0530
Message-ID: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52488 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1AUN5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 08:57:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

This patch series introduces support for Dynamic Voltage and Frequency Scaling
(DVFS) for OMAP devices. 

For detailed design details, refer to DVFS Documentation.

Pending Work:
1. OMAP4 support

Changes done in this series:
1. Seperated DVFS code from Voltage layer (voltage.c) and introduced DVFS layer
   in dvfs.c
2. Added support for frequency throttling and frequency locking (by introducing
   frequency list per device)
3. Added changes in omap cpufreq driver for DVFS support
4. Fixed race condition issues in DVFS layer
5. Added documentation for DVFS framework
5. Addressed comments received on V2
	V1: https://patchwork.kernel.org/patch/120132/
	V2: https://patchwork.kernel.org/patch/290542/

Contributors to conceptualization of the design include
Anand Sawant <sawant@ti.com>
Benoit Cousson <b-cousson@ti.com>,
Kevin Hilman <khilman@deeprootsystems.com>,
Paul Wamsley <paul@pwsan.com>,
Parthasarathy Basak <p-basak2@ti.com>
Thara Gopinath <thara@ti.com>
Vishwanath Sripathy <vishwanath.bs@ti.com>

This patch series is generated against latest kevin's pm branch and has been
tested on ZOOM3 for mpu, iva and core DVFS.

Thara Gopinath (6):
  OMAP: Introduce device specific set rate and get rate in omap_device
    structure
  OMAP3: Introduce custom set rate and get rate APIs for scalable
  OMAP: Disable Smartreflex across DVFS
    devices
  OMAP3: Introduce voltage domain info in the hwmod structures.
  OMAP3: Add voltage dependency table for VDD1.
  OMAP2PLUS: Enable various options in defconfig

Vishwanath BS (7):
  OMAP: Introduce accessory APIs for DVFS
  OMAP: Implement Basic DVFS
  OMAP: Introduce dependent voltage domain support
  OMAP: Introduce device scale implementation
  OMAP3: cpufreq driver changes for DVFS support
  OMAP2PLUS: Replace voltage values with Macros
  OMAP: Add DVFS Documentation

 Documentation/arm/OMAP/omap_dvfs              |  111 ++++
 arch/arm/configs/omap2plus_defconfig          |    4 +
 arch/arm/mach-omap2/Makefile                  |    2 +-
 arch/arm/mach-omap2/dvfs.c                    |  751 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    3 +
 arch/arm/mach-omap2/opp3xxx_data.c            |   47 +-
 arch/arm/mach-omap2/opp4xxx_data.c            |   13 +-
 arch/arm/mach-omap2/pm.c                      |   71 +++
 arch/arm/mach-omap2/voltage.c                 |  159 ++----
 arch/arm/plat-omap/cpu-omap.c                 |   35 +-
 arch/arm/plat-omap/include/plat/dvfs.h        |   34 ++
 arch/arm/plat-omap/include/plat/omap_device.h |    9 +
 arch/arm/plat-omap/include/plat/voltage.h     |  148 +++++
 arch/arm/plat-omap/omap_device.c              |   58 ++
 14 files changed, 1293 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/arm/OMAP/omap_dvfs
 create mode 100644 arch/arm/mach-omap2/dvfs.c
 create mode 100644 arch/arm/plat-omap/include/plat/dvfs.h

