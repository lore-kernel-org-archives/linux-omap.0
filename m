From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 00/17] OMAP2,3: hwmod DSS Adaptation
Date: Mon, 29 Nov 2010 17:21:26 +0530
Message-ID: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60300 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab0K2Lv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 06:51:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch "master"
Commit id: 063d907edaf3fbf9776c189c3e02f2c7a129d18c
Description:  Linux-omap rebuilt: Merged serial console fixes, cleanup
----------------------------------------------------------------------------

v2 of the DSS hwmod patch series focus on fixing the review comments.
OMAP4 support will be posted after the acceptance of this basic change
in the dss2 design.

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
        - initialises DSS IP alone
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

Senthilvadivu Guruswamy (17):
  OMAP2420: hwmod data: add DSS DISPC RFBI VENC
  OMAP2430: hwmod data: add DSS DISPC RFBI VENC
  OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
  OMAP2420,OMAP2430,OMAP3xx: change dss driver name in clock files
  OMAP2,3 DSS Driver register moved to mach_omap2
  OMAP2,3 board files DSS Driver register moved to devices.c
  OMAP2,3: DSS: Build omap_device for each DSS HWIP
  OMAP2,3: DSS: Create platform_driver for each DSS HW IP
  OMAP2,3: DSS: Move clocks from core driver to dss driver
  OMAP2,3: DSS: Move dss_feature_init to dss
  OMAP2,3: DSS: DSS Move init,exit to driver
  OMAP2,3: DSS: RFBI Move init,exit to driver
  OMAP2,3: DSS: DISPC Move init,exit to driver
  OMAP2,3: DSS: VENC Move init,exit to driver
  OMAP2,3: DSS: DSI Move init, exit to driver
  OMAP2,3: DSS: Use platform device to get baseaddr
  OMAP2,3: DSS: Get DSS IRQ from platform device

 arch/arm/mach-omap2/board-3430sdp.c          |   26 +--
 arch/arm/mach-omap2/board-am3517evm.c        |   14 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   22 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   12 +-
 arch/arm/mach-omap2/board-igep0020.c         |   20 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   22 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   16 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |   16 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +-
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
 drivers/video/omap2/dss/dsi.c                |   67 ++++-
 drivers/video/omap2/dss/dss.c                |  448 +++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h                |   15 +-
 drivers/video/omap2/dss/rfbi.c               |  116 ++++---
 drivers/video/omap2/dss/venc.c               |  123 +++++---
 26 files changed, 1778 insertions(+), 764 deletions(-)

