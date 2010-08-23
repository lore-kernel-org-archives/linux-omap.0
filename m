From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [RFC PATCH 00/20] HWMOD Adaptation for DSS
Date: Mon, 23 Aug 2010 21:27:49 +0530
Message-ID: <1282579089-10487-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55694 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab0HWP6W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch "pm-wip/hwmods-omap4"
Commit id: f6f7f1103b80b4dc0ace8a0314d95d1b1ebca726 
Description:  Merge branch 'pm-wip/hwmods' into pm-wip/hwmods-omap4-base
----------------------------------------------------------------------------

RFC focus on the proposed design of the HWMOD adaptation to the current DSS
driver.  DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each 
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
database as well which is not the present scenario.
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

Proposed change:
----------------
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

The below points are yet to be done, still the RFC is put out to start the
discussion on the design approach taken.

Yet to be implemented:
1) All the platform driver registration except DSS, are within the file core.c.
Registeration of these driver would go out of order when seperated to its own file.
Will test the implementation and send in the next version for review.
2) Usage of regulators by different drivers needs to implemented.
For Eg: Regulator used by VENC is moved to venc driver.  But vdda_dac would be 
needed by DPI and DSI as well.  Need to verify if a patch like this would work.
/* VPLL2 for digital video outputs */
static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "dss_dsi1"),
};
3) SYSCONFIG of each of the dss HW IP has to be removed from the driver.
HWMOD framework is supposed to take care of it.  This change would be done in 
the next version of the patch series.
4) OMAP2 HWMOD database is yet to be generated.
5) Number of DSS HW IPs in a silicon are hardcoded in devices.c.
It is not evident from HWMOD database.  Need to find a cleaner way to register for OMAP2,3,4.
6) Module support for omapdss driver as per current DSS2 design.


Senthilvadivu Guruswamy (20):
  DSS HWMOD database generation for OMAP3
  Move DSS driver register from board to mach_omap2
  Build omap_device for each DSS HW IP
  Create platform_driver for each DSS HW IP
  Move dss platform driver to dss.c
  DSS driver name change in clock database
  Move clock functions from core driver to dss driver
  Replace clk_enable/disable APIs with HWMOD APIs
  Move dss_init to dsshw_probe
  Move rfbi init to rfbi probe
  Move dispc init to dispc probe
  Move venc init to venc probe
  Move dsi init to dsi probe
  Pass platform_device argument to rfbi,dispc
  Use platform device to get DSS base addr
  Get DISPC base addr with platform device
  Get VENC base addr from platform device
  Get DSI base addr with platform device
  Get RFBI baseaddr with platform device
  Get DSS IRQ with platform device

 arch/arm/mach-omap2/board-3430sdp.c        |   25 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |   14 +-
 arch/arm/mach-omap2/devices.c              |   78 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  346 ++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h  |   14 +
 drivers/video/omap2/dss/core.c             |  585 +++++++---------------------
 drivers/video/omap2/dss/dispc.c            |    7 +-
 drivers/video/omap2/dss/dsi.c              |    5 +-
 drivers/video/omap2/dss/dss.c              |  450 +++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h              |   20 +-
 drivers/video/omap2/dss/rfbi.c             |    7 +-
 drivers/video/omap2/dss/venc.c             |   24 +-
 12 files changed, 1085 insertions(+), 490 deletions(-)


