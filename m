From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/12] rework OPP layer to handle device-based OPPs
Date: Wed, 16 Jun 2010 17:17:01 -0700
Message-ID: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51676 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab0FQARY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:24 -0400
Received: by pva4 with SMTP id 4so937484pva.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

The current OPP layer is based on a unique identifier (OPP_MPU,
OPP_DSP, OPP_L3) which is not terribly portable or scalable for future
devices.

Since we'd also like to be able to manage OPPs for any device (as
recently agreed upon during an OMAP PM meeting in TI Bangalore[1]), this
patch changes the OPP API to be device-based instead of unique-ID
based.  Essentially, this means passing a 'struct device' instead of a
unique ID to determine which set of OPPs to be used.

The main part of this patch is PATCH 08/12 where the OPP API changes
are made.   The earlier parts of the series are prep work for this and
the remaining parts are updating users of the OPP API.

Applies on top of current PM branch.

[1] http://omappedia.org/wiki/Proceedings_of_the_PM_SW_Workshop_Jun_2010

Kevin Hilman (12):
  OMAP2/3: hwmod: remove '_hwmod' suffix from names
  OMAP: hwmod: add class for DSP hwmods
  OMAP3: hwmod: add data for OMAP3 IVA2
  OMAP: omap_device: ensure hwmod tracks attached omap_device pointer
  OMAP: create omap_devices for MPU, DSP, L3
  OMAP: voltage: use device_initcall()
  OMAP: SR: use device_initcall()
  OMAP2: OPP: update API to be device-based
  OMAP3: CPUfreq: update to device-based OPP API
  OMAP: voltage: update to new device-based OPP API
  OMAP: SRF: update to new device-based OPP API
  OMAP: SRF: must be initialized before allowing constraints to be set

 arch/arm/mach-omap2/cpufreq34xx.c            |  180 +++++--------
 arch/arm/mach-omap2/devices.c                |    2 +
 arch/arm/mach-omap2/io.c                     |   68 ++++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   49 +++-
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 arch/arm/mach-omap2/resource34xx.c           |   95 ++++---
 arch/arm/mach-omap2/sr_device.c              |    2 +-
 arch/arm/mach-omap2/voltage.c                |   12 +-
 arch/arm/plat-omap/cpu-omap.c                |   12 +-
 arch/arm/plat-omap/include/plat/common.h     |    4 +
 arch/arm/plat-omap/include/plat/opp.h        |   57 ++---
 arch/arm/plat-omap/omap-pm-srf.c             |    7 +
 arch/arm/plat-omap/omap_device.c             |    8 +-
 arch/arm/plat-omap/opp.c                     |  396 +++++++++++---------------
 17 files changed, 474 insertions(+), 434 deletions(-)

