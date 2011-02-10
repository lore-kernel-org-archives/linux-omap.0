From: jean.pihet@newoldbits.com
Subject: [RFC PATCH 0/2] OMAP: PM: add devices wakeup latency constraints APIs
Date: Thu, 10 Feb 2011 20:23:25 +0100
Message-ID: <1297365807-12143-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41035 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab1BJTXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 14:23:51 -0500
Received: by eye27 with SMTP id 27so1006670eye.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 11:23:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, paul@pwsan.com, Vibhore Vardhan <vvardhan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

- Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API.
- Created arch/arm/plat-omap/omap-pm-constraints.c file from 
arch/arm/plat-omap/omap-pm-noop.c and the associated Kconfig option
OMAP_PM_CONSTRAINTS.

This code is an early submission in RFC state and is for review only.
Testing is on-going.

ToDo:
- implement the API for the SDMA device (omap_pm_set_max_sdma_lat),
- change the power domains latency figures to some more realistic values,
- add the hook to the existing kernel PM QoS interfaces (cpu_dma_latency),
   cf. Documentation/power/pm_qos_interface.txt

Jean Pihet (2):
  OMAP PM: create a PM layer plugin for the devices wakeup latency
    constraints
  OMAP: PM: implement devices wakeup latency constraints APIs

 arch/arm/mach-omap2/omap_hwmod.c              |   62 +++++-
 arch/arm/mach-omap2/powerdomain.c             |  176 +++++++++++++-
 arch/arm/mach-omap2/powerdomain.h             |   31 +++
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   60 +++++
 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  344 +++++++++++++++++++++++++
 arch/arm/plat-omap/omap_device.c              |   28 ++
 10 files changed, 710 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.2.3

