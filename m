From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/6] omap3/4: Add l3-interconnect error logging support
Date: Mon, 21 Feb 2011 19:16:24 +0530
Message-ID: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33909 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab1BUNqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:46:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LDkWIU031752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 07:46:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, b-cousson@ti.com, r.sricharan@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series introduces L3 error reporting drivers for OMAP3XXX
and OMAP4XXX SOCs. Interconnect error reporting is very useful
feature to hunt down the bugs which are at times untracable. Some
of these errors get lost in the interconnect and we will never know
about it. We found it very useful during OMAP4 power management
develoment and its being used quite extensively.

Initial idea was to add this as a library but since we are now
targetting maximum hwmod covresions, these drivers too are
converted.

The l3 interconnect logs all the errors that occur during the
OCP transactions and can interrupt MPU as an when they occur.
These errors helps to provide a quick insight to debug the aborts. 

The below are few examples of l3 error that can be generated on OMAP3:
1)./readmem 0x4b00a000
  - Address Hole Error seen by MPU  at address 4b00a000.

  This generates a address hole error seen by MPU. That is MPU is
  trying to access a address to which it is not connected.

2)./readmem 0x480ba000
  - In-band Error Error seen by MPU  at address 0

  This generates a in-band error. The MPU tries to access the
  address to which it is connected to, but the target did
  not respond(MCSPI4).

3)./readmem 0x40000000 0x1234
  - Unsupported Command Error seen by MPU  at address 40000000.

  This generates a Un-Supported Command error. The MPU tries
  to write to the internal ROM which is not permitted.


The OMAP4 interconnect error reporting is different than omap3.
The two interconnect IP are different. 
Two Types of errors :
	1) Custom errors in L3 :
		Target like DMM/FW/EMIF generates SRESP=ERR error
	2) Standard L3 error:
		- Unsupported CMD.
			L3 tries to access target while it is idle
		- OCP disconnect.
		- Address hole error:
			If DSS/ISS/FDIF/USBHOSTFS access a target where they
			do not have connectivity, the error is logged in
			their default target which is DMM2.

	3) On High Secure devices, firewall errors are possible and those
	   can be trapped as well. But the trapping is implemented as part
	   secure software and hence need not be implemented here.

The error logging feature is not fully supported by current
L4 interconnect IPs and hence not included in the patches.

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

Felipe Balbi (1):
  omap3: l3: Introduce l3-interconnect error handling driver

Santosh Shilimkar (1):
  omap4: l3: Introduce l3-interconnect error handling driver

sricharan (4):
  omap3: hwmod_data: Add l3 error log data to hwmod database.
  omap3: Initialise the l3 device with the hwmod data.
  omap4: hwmod_data: Add l3 errorlog data to hwmod database.
  omap4: Initialise the l3 device with the hwmod data.

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/devices.c              |   46 ++++
 arch/arm/mach-omap2/l3_interconnect_3xxx.c |  314 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/l3_interconnect_3xxx.h |  338 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/l3_interconnect_4xxx.c |  254 +++++++++++++++++++++
 arch/arm/mach-omap2/l3_interconnect_4xxx.h |  132 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   22 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 +++
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +
 9 files changed, 1138 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/l3_interconnect_3xxx.c
 create mode 100644 arch/arm/mach-omap2/l3_interconnect_3xxx.h
 create mode 100644 arch/arm/mach-omap2/l3_interconnect_4xxx.c
 create mode 100644 arch/arm/mach-omap2/l3_interconnect_4xxx.h

