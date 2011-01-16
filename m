From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v7 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Sun, 16 Jan 2011 22:11:25 +0530
Message-ID: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44925 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1APQmH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 11:42:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

v7 of the DSS hwmod patch series fixes one issue found in testing after rebase
on top of linux-next master (next-20110115 tag).

A device rename in patch 05/18 was missed from board-zoom-peripherals.c, which
is fixed in this version.

A patch mentioned in 
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
was needed to get OMAP3 to boot up on top of the said branch. 

OMAP4 hwmod support will be posted after the acceptance of this basic change in
the dss2 design.

This patch series decouples the "Clocks for DSS in hwmod adaptation" changes
from this series.  Another series would be posted which could be discussed
w.r.t clocks in DSS across omap2,3.

Removing the SYSCONFIG settings from DSS driver would also be part of these
clock changes series and not covered in this series as it depends on some of
the omap_hwmod framework changes w.r.t opt clocks handling.

Summary of the hwmod DSS design:
================================
DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each 
corresponding to the hwmod class in the hwmod database. 

Each of these platform drivers' init / deinit are handled from core.c's
omap_dss_probe() in the exact sequence as required.

No Hardcoding of silicon data:
hwmod database abstracts the SOC data like base addr, irq numbers and are
implemented in this patch series.

Continue to have custom bus for display panels:
"omap_display" driver continues to be a platform driver that registers the custom
bus.  It also continues to register the display panels(omap_dss_device) on the
board to the panel drivers (omap_dss_driver)
For Eg:  primary lcd device would be registered with lcd panel driver.
lcd panel driver if it is on a parallel interface would use library functions 
exported from dpi.o.  if it is on a dsi interface would use library functions
exported from dsi platform driver(dsi.o).

Clocks:
Handling of clocks in DSS only is one of the design approaches, that does not
change the existing implementation.  If each of the DSS HW IPs had to handle
their own clocks, then corresponding clock changes can be requested in the hwmod
database as well which is not the current design/implementation.  As stated, 
this would be handled in another series seperately.
For Eg: VENC would need 54MCLK which is termed as dss_opt clocks as of now apart
for the dss main clocks.  Currently VENC driver needs to be aware of this and has to
use clk_get/put, clk_enable/disable, since VENC hwmod is not aware of 54MCLK.



Current dss driver:
-------------------
1.  Omapdss platform driver
        - initialises necessary Ips dss, dispc.
        - also initialises Ips like sdi, dsi, venc, rfbi
        - creates a custom bus and registers the display devices/drivers
        connected on the board to the custom bus.

2.  Suspend/resume of omapdss
        - in turn sends suspend/resume calls for each of the display devices
        registered to it.

Modified change:
---------------
Platform driver for each DSS HW IP in addition to the software "omap_display"
driver.

Omapdss platform driver
        - initialises necessary h/w IPs' platform drivers [dss, dispc, dsi, venc, rfbi]
	  and software libraries like dpi, sdi.
        - continues to have a custom bus and registers the display devices 
        and drivers connected on the board to the custom bus.
        - continues to handle suspend/resume of the display devices registered
        to the custom bus.

DSS platform driver
        - initialises DSS IP alone
	- Handles the clocks related to the DSS and other DSSHW IPs like RFBI,
	DSI, VENC, DISPC.  Previously this was a part of "omapdss" driver in core.c
	- Continues to handle the DSS IRQs.
	- No suspend/resume hooks.

DISPC platform driver
        - initialises DISPC IP alone
	- Gets the required clock from DSS platform driver.
	- No suspend/resume hooks.
	- Continues to provide DISPC library functions.

DSI platform driver
        - initialises DSI IP alone
	- Gets the required clock from DSS platform driver.
	- No suspend/resume hooks.
	- Continues to provide DSI library functions.

RFBI, VENC platform drivers
        - initialises DSI,VENC IPs
	- Gets the required clock from DSS platform driver.
	- No suspend/resume hooks.
	- Continues to provide RFBI and VENC library functions.

Testing:
---------
The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
Complete bootup with penguins on panel is done on 3430sdp.
For the rest of the mentioned platforms, kernel is built with "OMAP2_DSS"
and bootup is tested so that base address and clk_get calls are successful.

DSS was built successfully as module, though not tested yet.

Changes since v6:
-----------------
* board-zoom-peripherals.c: Added missing change of device name from omapdss to omap_display.
	Found during testing on OMAP3630 on top of 
Changes since v5:
----------------
1) Following review comments incorporated:
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42031.html
		Make sure display.c is built when DSS is enabled built-in or as a module.
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42083.html
		hwmod and omap_device headers moved to patch 8 when they're
		needed the first time.
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42094.html
		- latency set to AUTO_ADJUST
		- extra whitespaces removed.
		- pdata memset to 0 before use.
		- if omap_device_build fails, return error.
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42095.html
		renamed *_deinit_* to *_uninit_*

 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42171.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42172.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42173.html
		- added L3 and L4 firewall related data,
		- corrected handling of .idlest_idle_bit v/w .idlest_stdby_bit
		- no .idlest_*_bit setting for dependent hwmods
		- corrected .user to add SDMA
		- renamed dss_dss to dss_core
		- hwmod for 3430es1 and later 3xxx are separated out, with some
		  reuse of data.
 *	Removed forced-disable of dss clocks from omap_dss_remove.

Changes since v4:
----------------
1) Following review comments incorporated:
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41970.html
		Corrected the clocks to be enabled in omap_dss_probe.
Changes since v3:
----------------
1.) Following review comments incorporated:
 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41705.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41683.html
		Created a new display.c file for dss driver registration 
		related code.	

 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41573.html
		Changed the oh_name/dev_name handling in hwmod usage.

 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41753.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41718.html
		removed device_initcall_sync(); init / deinit of each DSS h/w IP
		platform drivers are done from omap_dss_probe() in sequence.

 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41754.html
		clock patches were cleaned up as per review comments.

 *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41756.html
		printk() => dev_dbg change was separated out.


Changes since v2:
-------------------
1.) Following review comments incorporated:
	Split the device/driver name change and registration patches logically.
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41205.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41204.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41203.html

Changes since v1:
------------------
1.) Dynamically register for OMAP2,3 specific DSS HW IPs in devices.c
2.) Following review comments incorporated:
	Updation of all the board files on l-o dss2 branch as per
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36915.html
	Comments incorporated in devices.c and display.h as per
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36919.html
	Comments incorporated in dispc.c, dss.c, dsi.c, venc.c, rfbi.c 
	so that platform_device is just above platform_driver registrations as per
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36963.html
3.) Squashed some of the patches to one patch.

Changes since RFC:
-------------------
1) All the platform driver registration except DSS, were within the file core.c.
Registeration of these driver got seperated to its own file.
2) Usage of regulators by different drivers are implemented.
For Eg: Regulator used by VENC is moved to venc driver.  But vdda_dac would be 
needed by DPI and DSI as well.
4) OMAP2420 and OMAP2430 hwmod database are generated in this v1.
5) Module support for omapdss driver can continue as the DSS HW IP specific platform
drivers are decoupled from omapdss driver.
6) Following review comments incorporated:
	Changed the hwmod device name from "dss" to "dss_dss"
	Changed name of core driver from "omapdss" to "omap_display" as it deals with panels.
	Fixed comments on return values from platform_get_resource/irq functions.

Patch Base:
===========
Patch-set rebased and tested w/ Zoom3 (OMAP3630) on top of:
url = git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
branch "master"
commit	e8883f8057c0f7c9950fa9f20568f37bfa62f34a
Description: Add linux-next specific files for 20110115
+
Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
[PATCH] OMAP: counter_32k: init clocksource as part of machine timer init

(This patch is required for OMAP bootup w/ 20110115 linux-next)

----------------------------------------------------------------------------


Senthilvadivu Guruswamy (15):
  OMAP2420: hwmod data: add DSS DISPC RFBI VENC
  OMAP2430: hwmod data: add DSS DISPC RFBI VENC
  OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
  OMAP2,3 DSS2 Change driver name to omap_display
  OMAP2,3 DSS2 Use Regulator init with driver name
  OMAP2,3: DSS2: board files: replace platform_device_register with
    omap_display_init()
  OMAP2,3: DSS2: Build omap_device for each DSS HWIP
  OMAP2,3: DSS2: DSS: create platform_driver, move init,exit to driver
  OMAP2,3: DSS2: Move clocks from core driver to dss driver
  OMAP2,3: DSS2: RFBI: create platform_driver, move init,exit to driver
  OMAP2,3: DSS2: DISPC: create platform_driver, move init,exit to
    driver
  OMAP2,3: DSS2: VENC: create platform_driver, move init,exit to driver
  OMAP2,3: DSS2: DSI: create platform_driver, move init,exit to driver
  OMAP2,3: DSS2: Use platform device to get baseaddr
  OMAP2,3: DSS2: Get DSS IRQ from platform device

Sumit Semwal (3):
  OMAP2,3: DSS2: remove forced clk-disable from omap_dss_remove
  OMAP2,3: DSS2: Create new file display.c for central dss driver
    registration.
  OMAP2,3: DSS2: replace printk with dev_dbg in init

 arch/arm/mach-omap2/Makefile                 |    3 +
 arch/arm/mach-omap2/board-3430sdp.c          |   26 +--
 arch/arm/mach-omap2/board-am3517evm.c        |   16 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   22 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   14 +-
 arch/arm/mach-omap2/board-igep0020.c         |   16 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   22 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   16 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |   22 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +-
 arch/arm/mach-omap2/board-rx51-video.c       |   15 +-
 arch/arm/mach-omap2/board-zoom-display.c     |   15 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +-
 arch/arm/mach-omap2/clock2420_data.c         |    8 +-
 arch/arm/mach-omap2/clock2430_data.c         |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   14 +-
 arch/arm/mach-omap2/display.c                |   96 ++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  311 ++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  284 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  433 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h    |   16 +
 arch/arm/plat-omap/include/plat/l3_2xxx.h    |   20 ++
 arch/arm/plat-omap/include/plat/l3_3xxx.h    |   20 ++
 arch/arm/plat-omap/include/plat/l4_2xxx.h    |   24 ++
 arch/arm/plat-omap/include/plat/l4_3xxx.h    |   10 +
 drivers/video/omap2/dss/core.c               |  448 ++------------------------
 drivers/video/omap2/dss/dispc.c              |  114 ++++---
 drivers/video/omap2/dss/dsi.c                |   78 ++++-
 drivers/video/omap2/dss/dss.c                |  411 +++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h                |   46 ++--
 drivers/video/omap2/dss/rfbi.c               |  118 ++++---
 drivers/video/omap2/dss/venc.c               |  125 +++++---
 33 files changed, 2022 insertions(+), 771 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.c
 create mode 100644 arch/arm/plat-omap/include/plat/l3_2xxx.h
 create mode 100644 arch/arm/plat-omap/include/plat/l3_3xxx.h
 create mode 100644 arch/arm/plat-omap/include/plat/l4_2xxx.h

