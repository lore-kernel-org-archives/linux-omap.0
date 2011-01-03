From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 00/17] OMAP2,3: hwmod DSS Adaptation
Date: Mon,  3 Jan 2011 18:20:52 +0530
Message-ID: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48413 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab1ACMv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 07:51:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

v3 of the DSS hwmod patch series focus on fixing the review comments. OMAP4 
hwmod support will be posted after the acceptance of this basic change in
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

No Hardcoding of silicon data:
hwmod database abstracts the SOC data like base addr, irq numbers and are
implemented in this patch series.

Continue to have custom bus for display panels:
"omapdss" driver continues to be a platform driver that registers the custom
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
Platform driver for each DSS HW IP in addition to the software "omapdss"
driver.

Omapdss platform driver
        - initialises necessary software libraries like dpi, sdi.
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
	- Continues to provide DISPC library functions.

RFBI, VENC platform drivers
        - initialises DSI,VENC IPs
	- Gets the required clock from DSS platform driver.
	- No suspend/resume hooks.
	- Continues to provide DISPC library functions.

Testing:
---------
The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
Complete bootup with penguins on panel is done on 3430sdp.
For the rest of the mentioned platforms, kernel is built with "OMAP2_DSS"
and bootup is tested so that base address and clk_get calls are successful.

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
Changes since v2:
-------------------
1.) Following review comments incorporated:
	Split the device/driver name change and registration patches logically.
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41205.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41204.html
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41203.html


Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch "master"
Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
Description:  cbus: Fix retu_rtc_do_reset
----------------------------------------------------------------------------

Senthilvadivu Guruswamy (17):
  OMAP2420: hwmod data: add DSS DISPC RFBI VENC
  OMAP2430: hwmod data: add DSS DISPC RFBI VENC
  OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
  OMAP2,3 DSS2 Change driver name to omap_display
  OMAP2,3 DSS2 Use Regulator init with driver name
  OMAP2,3 DSS2 Move DSS driver register from board file to devices.c
  OMAP2,3: DSS2: Build omap_device for each DSS HWIP
  OMAP2,3: DSS2: Create platform_driver for each DSS HW IP
  OMAP2,3: DSS2: Move clocks from core driver to dss driver
  OMAP2,3: DSS2: Move dss_feature_init to dss
  OMAP2,3: DSS2: DSS Move init,exit to driver
  OMAP2,3: DSS2: RFBI Move init,exit to driver
  OMAP2,3: DSS2: DISPC Move init,exit to driver
  OMAP2,3: DSS2: VENC Move init,exit to driver
  OMAP2,3: DSS2: DSI Move init, exit to driver
  OMAP2,3: DSS2: Use platform device to get baseaddr
  OMAP2,3: DSS2: Get DSS IRQ from platform device

 arch/arm/mach-omap2/board-3430sdp.c          |   26 +--
 arch/arm/mach-omap2/board-am3517evm.c        |   16 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   22 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   14 +-
 arch/arm/mach-omap2/board-igep0020.c         |   16 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   22 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   16 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |   16 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +-
 arch/arm/mach-omap2/board-rx51-video.c       |   15 +-
 arch/arm/mach-omap2/clock2420_data.c         |    8 +-
 arch/arm/mach-omap2/clock2430_data.c         |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   14 +-
 arch/arm/mach-omap2/devices.c                |   82 +++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  283 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  282 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  339 +++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h    |   10 +
 drivers/video/omap2/dss/core.c               |  449 +-------------------------
 drivers/video/omap2/dss/dispc.c              |  112 ++++---
 drivers/video/omap2/dss/dsi.c                |   66 ++++-
 drivers/video/omap2/dss/dss.c                |  448 +++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h                |   15 +-
 drivers/video/omap2/dss/rfbi.c               |  116 ++++---
 drivers/video/omap2/dss/venc.c               |  123 +++++---
 26 files changed, 1779 insertions(+), 757 deletions(-)

