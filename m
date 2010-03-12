From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v3 0/5] omap3: pm: Update TRITON power scripts and making it generic.
Date: Fri, 12 Mar 2010 20:52:16 +0530
Message-ID: <002801cac1f7$cd9a12f0$518918ac@apr.dhcp.ti.com>
References: <1268407862-22511-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38820 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934264Ab0CLPWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:22:24 -0500
In-Reply-To: <1268407862-22511-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

This patch has dependency on SmartReflex patch send by Thara Gopinath.

---
[PATCH 2/6] OMAP3: PM: Splitting voltage and smartreflex class specific code
from smartreflex driver.

1. Create voltage.c and voltage.h files and move all voltage
processor and voltage controller specific code from smartreflex.c
to these two files.
---

These patches are created on top of voltage changes done by Thara in
SmartReflex patch series.

Thanks & Regards,
Lesly A M


-----Original Message-----
From: Lesly A M [mailto:leslyam@ti.com] 
Sent: Friday, March 12, 2010 9:01 PM
To: linux-omap@vger.kernel.org
Cc: Lesly A M; Nishanth Menon; David Derrick; Samuel Ortiz
Subject: [PATCH v3 0/5] omap3: pm: Update TRITON power scripts and making it
generic. 

This series of patch implements a updated TRITON power scripts.
Also moving the sleep, wakeup & warm_reset sequence to a generic script
file,
which can be used by different OMAP3 board with the power companion chip
TWL4030.

This patch series is based off Kevin's tree origin/pm branch.

This changes are tested on OMAP3430 SDP board with:
	enable_off_mode
	voltage_off_while_idle
	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v)
enabled in cpuidle and suspned path.

Also tested for reboot and dvfs.

Lesly A M (5):
  omap3: pm: fix for twl4030 script load
  omap3: pm: Using separate clk/volt setup_time for RET and OFF states
  omap3: pm: Generic TRITON power scripts for OMAP3 based boards
  omap3: pm: Use generic TRITON power scripts for 3430SDP board
  omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP
    board

 arch/arm/mach-omap2/Makefile                  |   12 ++-
 arch/arm/mach-omap2/board-3430sdp.c           |  139
++++++++----------------
 arch/arm/mach-omap2/board-3630sdp.c           |   25 ++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   44 ++++++++-
 arch/arm/mach-omap2/board-zoom2.c             |   25 ++++-
 arch/arm/mach-omap2/board-zoom3.c             |   25 ++++-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +-
 arch/arm/mach-omap2/pm.h                      |   21 +++--
 arch/arm/mach-omap2/pm34xx.c                  |   14 ++-
 arch/arm/mach-omap2/twl4030-script.c          |  143
+++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-script.h          |   15 +++
 arch/arm/mach-omap2/voltage.c                 |   94 ++++++++++++-----
 arch/arm/mach-omap2/voltage.h                 |    1 +
 drivers/mfd/twl4030-power.c                   |    6 -
 include/linux/i2c/twl.h                       |    4 +
 15 files changed, 424 insertions(+), 146 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-script.c
 create mode 100644 arch/arm/mach-omap2/twl4030-script.h

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

