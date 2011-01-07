From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v5 00/17] OMAP2,3: hwmod DSS Adaptation
Date: Fri, 07 Jan 2011 14:56:07 +0200
Message-ID: <1294404967.3968.69.camel@nubuntu>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:34124 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab1AGM4O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 07:56:14 -0500
In-Reply-To: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, ext Sumit Semwal <sumit.semwal@ti.com>

Hi Tony,

The patch set below is based on l-o tree, as it touches OMAP
hwmod/clock/board stuff. It doesn't even apply to my mainline based
tree.

I'm still in the process of reviewing the latest changes, but is it ok
for you to apply these to your tree after I've acked the DSS parts? Or
do you have a stable branch (going to Linus soon) that I can use as a
base?

 Tomi

On Fri, 2011-01-07 at 16:55 +0530, ext Sumit Semwal wrote:
> v4 of the DSS hwmod patch series focusses on fixing the review comments. OMAP4 
> hwmod support will be posted after the acceptance of this basic change in
> the dss2 design.
> 
> This patch series decouples the "Clocks for DSS in hwmod adaptation" changes
> from this series.  Another series would be posted which could be discussed
> w.r.t clocks in DSS across omap2,3.
> 
> Removing the SYSCONFIG settings from DSS driver would also be part of these
> clock changes series and not covered in this series as it depends on some of
> the omap_hwmod framework changes w.r.t opt clocks handling.
> 
> Summary of the hwmod DSS design:
> ================================
> DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each 
> corresponding to the hwmod class in the hwmod database. 
> 
> Each of these platform drivers' init / deinit are handled from core.c's
> omap_dss_probe() in the exact sequence as required.
> 
> No Hardcoding of silicon data:
> hwmod database abstracts the SOC data like base addr, irq numbers and are
> implemented in this patch series.
> 
> Continue to have custom bus for display panels:
> "omapdss" driver continues to be a platform driver that registers the custom
> bus.  It also continues to register the display panels(omap_dss_device) on the
> board to the panel drivers (omap_dss_driver)
> For Eg:  primary lcd device would be registered with lcd panel driver.
> lcd panel driver if it is on a parallel interface would use library functions 
> exported from dpi.o.  if it is on a dsi interface would use library functions
> exported from dsi platform driver(dsi.o).
> 
> Clocks:
> Handling of clocks in DSS only is one of the design approaches, that does not
> change the existing implementation.  If each of the DSS HW IPs had to handle
> their own clocks, then corresponding clock changes can be requested in the hwmod
> database as well which is not the current design/implementation.  As stated, 
> this would be handled in another series seperately.
> For Eg: VENC would need 54MCLK which is termed as dss_opt clocks as of now apart
> for the dss main clocks.  Currently VENC driver needs to be aware of this and has to
> use clk_get/put, clk_enable/disable, since VENC hwmod is not aware of 54MCLK.
> 
> 
> 
> Current dss driver:
> -------------------
> 1.  Omapdss platform driver
>         - initialises necessary Ips dss, dispc.
>         - also initialises Ips like sdi, dsi, venc, rfbi
>         - creates a custom bus and registers the display devices/drivers
>         connected on the board to the custom bus.
> 
> 2.  Suspend/resume of omapdss
>         - in turn sends suspend/resume calls for each of the display devices
>         registered to it.
> 
> Modified change:
> ---------------
> Platform driver for each DSS HW IP in addition to the software "omapdss"
> driver.
> 
> Omapdss platform driver
>         - initialises necessary h/w IPs' platform drivers [dss, dispc, dsi, venc, rfbi]
> 	  and software libraries like dpi, sdi.
>         - continues to have a custom bus and registers the display devices 
>         and drivers connected on the board to the custom bus.
>         - continues to handle suspend/resume of the display devices registered
>         to the custom bus.
> 
> DSS platform driver
>         - initialises DSS IP alone
> 	- Handles the clocks related to the DSS and other DSSHW IPs like RFBI,
> 	DSI, VENC, DISPC.  Previously this was a part of "omapdss" driver in core.c
> 	- Continues to handle the DSS IRQs.
> 	- No suspend/resume hooks.
> 
> DISPC platform driver
>         - initialises DISPC IP alone
> 	- Gets the required clock from DSS platform driver.
> 	- No suspend/resume hooks.
> 	- Continues to provide DISPC library functions.
> 
> DSI platform driver
>         - initialises DSI IP alone
> 	- Gets the required clock from DSS platform driver.
> 	- No suspend/resume hooks.
> 	- Continues to provide DSI library functions.
> 
> RFBI, VENC platform drivers
>         - initialises DSI,VENC IPs
> 	- Gets the required clock from DSS platform driver.
> 	- No suspend/resume hooks.
> 	- Continues to provide RFBI and VENC library functions.
> 
> Testing:
> ---------
> The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
> Complete bootup with penguins on panel is done on 3430sdp.
> For the rest of the mentioned platforms, kernel is built with "OMAP2_DSS"
> and bootup is tested so that base address and clk_get calls are successful.
> 
> DSS was built successfully as module, though not tested yet.
> 
> Changes since v4:
> ----------------
> 1) Following review comments incorporated:
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41970.html
> 		Corrected the clocks to be enabled in omap_dss_probe.
> Changes since v3:
> ----------------
> 1.) Following review comments incorporated:
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41705.html
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41683.html
> 		Created a new display.c file for dss driver registration 
> 		related code.	
> 
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41573.html
> 		Changed the oh_name/dev_name handling in hwmod usage.
> 
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41753.html
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41718.html
> 		removed device_initcall_sync(); init / deinit of each DSS h/w IP
> 		platform drivers are done from omap_dss_probe() in sequence.
> 
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41754.html
> 		clock patches were cleaned up as per review comments.
> 
>  *	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41756.html
> 		printk() => dev_dbg change was separated out.
> 
> 
> Changes since v2:
> -------------------
> 1.) Following review comments incorporated:
> 	Split the device/driver name change and registration patches logically.
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41205.html
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41204.html
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41203.html
> 
> Changes since v1:
> ------------------
> 1.) Dynamically register for OMAP2,3 specific DSS HW IPs in devices.c
> 2.) Following review comments incorporated:
> 	Updation of all the board files on l-o dss2 branch as per
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36915.html
> 	Comments incorporated in devices.c and display.h as per
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36919.html
> 	Comments incorporated in dispc.c, dss.c, dsi.c, venc.c, rfbi.c 
> 	so that platform_device is just above platform_driver registrations as per
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36963.html
> 3.) Squashed some of the patches to one patch.
> 
> Changes since RFC:
> -------------------
> 1) All the platform driver registration except DSS, were within the file core.c.
> Registeration of these driver got seperated to its own file.
> 2) Usage of regulators by different drivers are implemented.
> For Eg: Regulator used by VENC is moved to venc driver.  But vdda_dac would be 
> needed by DPI and DSI as well.
> 4) OMAP2420 and OMAP2430 hwmod database are generated in this v1.
> 5) Module support for omapdss driver can continue as the DSS HW IP specific platform
> drivers are decoupled from omapdss driver.
> 6) Following review comments incorporated:
> 	Changed the hwmod device name from "dss" to "dss_dss"
> 	Changed name of core driver from "omapdss" to "omap_display" as it deals with panels.
> 	Fixed comments on return values from platform_get_resource/irq functions.
> 
> Patch Base:
> ===========
> url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch "master"
> Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
> Description:  cbus: Fix retu_rtc_do_reset
> ----------------------------------------------------------------------------
> 
> Senthilvadivu Guruswamy (15):
>   OMAP2420: hwmod data: add DSS DISPC RFBI VENC
>   OMAP2430: hwmod data: add DSS DISPC RFBI VENC
>   OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
>   OMAP2,3 DSS2 Change driver name to omap_display
>   OMAP2,3 DSS2 Use Regulator init with driver name
>   OMAP2,3: DSS2: board files: replace platform_device_register with
>     omap_display_init()
>   OMAP2,3: DSS2: Build omap_device for each DSS HWIP
>   OMAP2,3: DSS2: DSS: create platform_driver, move init,exit to driver
>   OMAP2,3: DSS2: Move clocks from core driver to dss driver
>   OMAP2,3: DSS2: RFBI: create platform_driver, move init,exit to driver
>   OMAP2,3: DSS2: DISPC: create platform_driver, move init,exit to
>     driver
>   OMAP2,3: DSS2: VENC: create platform_driver, move init,exit to driver
>   OMAP2,3: DSS2: DSI: create platform_driver, move init,exit to driver
>   OMAP2,3: DSS2: Use platform device to get baseaddr
>   OMAP2,3: DSS2: Get DSS IRQ from platform device
> 
> Sumit Semwal (2):
>   OMAP2,3: DSS2: Create new file display.c for central dss driver
>     registration.
>   OMAP2,3: DSS2: replace printk with dev_dbg in init
> 
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/board-3430sdp.c          |   26 +--
>  arch/arm/mach-omap2/board-am3517evm.c        |   16 +-
>  arch/arm/mach-omap2/board-cm-t35.c           |   22 +-
>  arch/arm/mach-omap2/board-devkit8000.c       |   14 +-
>  arch/arm/mach-omap2/board-igep0020.c         |   16 +-
>  arch/arm/mach-omap2/board-omap3beagle.c      |   14 +-
>  arch/arm/mach-omap2/board-omap3evm.c         |   22 +-
>  arch/arm/mach-omap2/board-omap3pandora.c     |   16 +-
>  arch/arm/mach-omap2/board-omap3stalker.c     |   16 +-
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +-
>  arch/arm/mach-omap2/board-rx51-video.c       |   15 +-
>  arch/arm/mach-omap2/clock2420_data.c         |    8 +-
>  arch/arm/mach-omap2/clock2430_data.c         |    8 +-
>  arch/arm/mach-omap2/clock3xxx_data.c         |   14 +-
>  arch/arm/mach-omap2/display.c                |  101 ++++++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  283 ++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  282 ++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  339 +++++++++++++++++++
>  arch/arm/plat-omap/include/plat/display.h    |   10 +
>  drivers/video/omap2/dss/core.c               |  450 ++------------------------
>  drivers/video/omap2/dss/dispc.c              |  114 ++++---
>  drivers/video/omap2/dss/dsi.c                |   78 ++++-
>  drivers/video/omap2/dss/dss.c                |  443 +++++++++++++++++++++++++-
>  drivers/video/omap2/dss/dss.h                |   46 ++--
>  drivers/video/omap2/dss/rfbi.c               |  118 ++++---
>  drivers/video/omap2/dss/venc.c               |  125 +++++---
>  27 files changed, 1851 insertions(+), 751 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/display.c
> 


