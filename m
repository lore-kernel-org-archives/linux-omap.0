From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v3 0/9] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri,  4 Mar 2011 13:18:18 +0530
Message-ID: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab1CDHsg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 02:48:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p247mXRl008026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 01:48:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding HDMI support on OMAP4.

HDMI is a driver that is similar to the VENC or the DSI driver to support
HDMI/DVI sink device.

The current design adheres to the DSS2 architecture.

It is split into the HDMI DSS driver and HDMI panel driver.

HDMI DSS driver (hdmi.c) is responsible for
1.OMAP related configuration such as
	1.Listening to the DSS_HDMI irq which signals changes such as hot-plug
		detect,physical attach/detach.
	2.calculate the PLL values based on the TV resolution that is selected
	3.configuration of the Mux/GPIO settings.
2.HDMI configuration based on the parameters read from the EDID of the 
sink device such as:
	1. Configuration of the PHY registers.
	2. Configuration of the PLL registers and setting of the TMDS clock.
	3. Configuration of the DDC to read the EDID data when available.
	4. Configuration of the core registers to set:
		a. set the video registers to the timing and format that
			is selected.
		b. set the audio registers based on the EDID value read and
			user selected parameters.
		c. Set the AVI info frame registers to configure the auxilary
			info frame which are repeated.
HDMI Panel Driver (hdmi_omap4_panel.c) . This is a panel driver which acts
as the controlling device which synchronizes the audio and video portion of the
driver.[enable ,disable , notification to audio on suspend etc].
It registers hdmi driver to the omap_dss bus and calls the functionality
of the HDMI DSS driver.
It is also provides the interface for users 
	1.To read the EDID contents and also confiure the timings based on EDID.
	2.To configure AVI Inforframe based on the the EDID(sink capability).

Note : Mux handling with hwmod is dependent on pm_runtime_sync ,so mux with hwmod
will be posted once patch series with pm_runtime_sync is done.

verified on 4430 SDP ES2.1 - Penguins on HDMI and DVI TV.
verified on PANDA ES2.1 - Penguins on HDMI and DVI TV.

1. v10 of omap2,3 hwmod DSS adaptation:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
2. v3 of OMAP2PLUS: DSS: Generalize clock names
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43338.html
3. v3 of OMAP4: hwmod DSS support:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43177.html
4. OMAP: DSS2: Adding dss_features for independent core clk divider 
https://patchwork.kernel.org/patch/529561/
5. OMAP2PLUS-DSS2-Make-members-of-dss_clk_source-generic

Changes from V2:
1. separated the gamma function from venc/hdmi clock source switch function.
2. Mutex lock fixed.
3. Removed some enum to be used later from the header file.
4. global variables in hdmi.c moved to hdmi structure.
Changes from V1:
1. HDMI to call dss_get_dispc_clock_source instead of directly setting register.
2. All HDMI enumerators are added HDMI prefix.
3. Fixed the mutex position.

Mythri P K (9):
  OMAP4 : DSS2 : Add display type HDMI to DSS2
  OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
  OMAP4 : DSS2 : HDMI: HDMI dispc gamma table disable.
  OMAP4 : DSS2 : HDMI: HDMI driver header file addition
  OMAP4 : DSS2 : HDMI: HDMI driver header file addition
  OMAP4 : DSS2 : HDMI: HDMI panel driver addition in the DSS
  OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
  OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 SDP
  OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 PANDA

 arch/arm/mach-omap2/board-4430sdp.c        |   75 ++
 arch/arm/mach-omap2/board-omap4panda.c     |   74 ++
 arch/arm/plat-omap/include/plat/display.h  |    1 +
 drivers/video/omap2/dss/Kconfig            |   16 +
 drivers/video/omap2/dss/Makefile           |    2 +
 drivers/video/omap2/dss/core.c             |    8 +
 drivers/video/omap2/dss/dispc.c            |   10 +
 drivers/video/omap2/dss/display.c          |    8 +
 drivers/video/omap2/dss/dss.c              |    5 +
 drivers/video/omap2/dss/dss.h              |   39 +-
 drivers/video/omap2/dss/dss_features.c     |    2 +-
 drivers/video/omap2/dss/hdmi.c             | 1332 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h             |  449 ++++++++++
 drivers/video/omap2/dss/hdmi_omap4_panel.c |  206 +++++
 drivers/video/omap2/dss/manager.c          |    9 +-
 drivers/video/omap2/dss/overlay.c          |    6 +-
 16 files changed, 2236 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi.c
 create mode 100644 drivers/video/omap2/dss/hdmi.h
 create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c

