From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 00/16] OMAP3: hwmod DSS Adaptation
Date: Wed,  6 Oct 2010 16:44:43 +0530
Message-ID: <1286363699-9614-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758875Ab0JFLPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch "pm-core"
Commit id: 1dce15672f62296d059c44e70684600a2c80d3d0 
Description:  Merge branch 'pm-suspend' into pm-reset
----------------------------------------------------------------------------

v1 of the DSS HWMOD patch series focus on fixing the review comments and incorporating
TODO listed in the RFC patch of HWMOD adaptation to the current DSS
driver.

This patch series decouples the "Clocks for DSS in HWMOD adaptation" changes from
this series.  Another series would be posted which could be discussed w.r.t clocks
in DSS across omap2,3,4.

v1 patch series got delayed as we could not get a conclusion on the clock adaptation
across OMAP2,3,4, along with HWMOD hence decided to take up as a discussion in 
seperate series.

Summary of the HWMOD DSS design:
================================
DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each 
corresponding to the HWMOD class in the HWMOD database. 

No Hardcoding of silicon data:
HWMOD database abstracts the SOC data like base addr, irq numbers and are
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
Handling of clocks in DSS only is one of the design approach, that does not
change the existing implementation.  If each of the DSS HW IPs had to handle
their own clocks, then corresponding clock changes are requested in the HWMOD
database as well which is not the present scenario.  As stated, this would be
handled in another series seperately.
For Eg: VENC would need 54MCLK which is termed as dss_opt clocks as of now apart
for the dss main clocks.  Currently VENC driver needs to be aware of this and has to
use clk_get/put, clk_enable/disable, since VENC HWMOD is not aware of 54MCLK.


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

The patches are tested on OMAP3430 and 3630.

Changes since RFC:
------------------
1) All the platform driver registration except DSS, were within the file core.c.
Registeration of these driver got seperated to its own file.
2) Usage of regulators by different drivers are implemented.
For Eg: Regulator used by VENC is moved to venc driver.  But vdda_dac would be 
needed by DPI and DSI as well.
4) OMAP2420 and OMAP2430 HWMOD database are generated in this v1.
5) Module support for omapdss driver can continue as the DSS HW IP specific platform
drivers are decoupled from omapdss driver.
6) Following review comments incorporated:
	Changed the HWMOD device name from "dss" to "dss_dss"
	Changed name of core driver from "omapdss" to "omapdisplay" as it deals with panels.
	Fixed comments on return values from platform_get_resource/irq functions.

TODO:
1.) SYSCONFIG of each of the dss HW IP has to be removed from the driver.
HWMOD framework is supposed to take care of it.  This change would be done in 
the next version of the patch series.
2.) Dynamically register for OMAP2,3,4 specific DSS HW IPs in devices.c

Senthilvadivu Guruswamy (16):
  OMAP2420: hwmod data: add DSS DISPC RFBI VENC
  OMAP2430: hwmod data: add DSS DISPC RFBI VENC
  OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
  OMAP3: hwmod data: change dss_hwmod to dss_dss_hwmod
  OMAP3 DSS Driver register moved to mach_omap2
  OMAP3: hwmod DSS: Build omap_device for each DSS HWIP
  OMAP3: hwmod DSS: Create platform_driver for each DSS HW IP
  OMAP3: clock data: change dss driver name
  OMAP3: hwmod DSS: Move clocks from core driver to dss driver
  OMAP3: hwmod DSS: DSS Move init,exit to driver
  OMAP3: hwmod DSS: RFBI Move init,exit to driver
  OMAP3: hwmod DSS: DISPC Move init,exit to driver
  OMAP3: hwmod DSS: VENC Move init,exit to driver
  OMAP3: hwmod DSS: DSI Move init, exit to driver
  OMAP3: hwmod DSS: Use platform device to get baseaddr
  OMAP3: hwmod DSS: Get DSS IRQ from platform device

 arch/arm/mach-omap2/board-3430sdp.c        |   26 +--
 arch/arm/mach-omap2/clock3xxx_data.c       |   14 +-
 arch/arm/mach-omap2/devices.c              |   78 +++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  278 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  278 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  333 +++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h  |   14 +
 drivers/video/omap2/dss/core.c             |  447 +---------------------------
 drivers/video/omap2/dss/dispc.c            |   50 +++-
 drivers/video/omap2/dss/dsi.c              |   66 ++++-
 drivers/video/omap2/dss/dss.c              |  448 +++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h              |   14 +-
 drivers/video/omap2/dss/rfbi.c             |   51 +++-
 drivers/video/omap2/dss/venc.c             |   67 ++++-
 14 files changed, 1668 insertions(+), 496 deletions(-)

