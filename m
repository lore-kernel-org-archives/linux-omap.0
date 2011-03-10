From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 16:14:08 +0530
Message-ID: <1299753858-12222-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44166 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab1CJKuz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAoqoT021439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:54 -0600
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

Changes from V4:
1. default timing to be picked by FB is changed to VGA.
2. changed the ERRNO based on comments from sanjeev.
3. Found an issue with set_timings while testing and that is fixed.
Changes from V3:
1. compile hdmi_omap4_panel.c as part of OMAPDSS , for OMAPDSS to work as module.
2. Function cleanup to take enum as parameter.
3. Rebased on Tomi's master branch Tree.
Changes from V2:
1. separated the gamma function from venc/hdmi clock source switch function.
2. Mutex lock fixed.
3. Removed some enum to be used later from the header file.
4. global variables in hdmi.c moved to hdmi structure.
Changes from V1:
1. HDMI to call dss_get_dispc_clock_source instead of directly setting register.
2. All HDMI enumerators are added HDMI prefix.
3. Fixed the mutex position.

Mythri P K (10):
  OMAP4 : DSS2 : Add display type HDMI to DSS2
  OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
  OMAP4 : DSS2 : HDMI: Dispc gamma enable set/reset function for TV.
  OMAP4 : DSS2 : HDMI: HDMI driver header file addition
  OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
  OMAP4 : DSS2 : HDMI: HDMI panel driver addition in the DSS
  OMAP4 : DSS2 : HDMI: Add makefile and kconfig changes to enable HDMI
    in OMAP4
  OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
  OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 SDP
  OMAP4 : HDMI : Add HDMI structure in the board file for OMAP4 PANDA

 arch/arm/mach-omap2/board-4430sdp.c        |   75 ++
 arch/arm/mach-omap2/board-omap4panda.c     |   74 ++
 arch/arm/plat-omap/include/plat/display.h  |    1 +
 drivers/video/omap2/dss/Kconfig            |    8 +
 drivers/video/omap2/dss/Makefile           |    2 +
 drivers/video/omap2/dss/core.c             |    9 +
 drivers/video/omap2/dss/dispc.c            |   13 +
 drivers/video/omap2/dss/display.c          |    5 +
 drivers/video/omap2/dss/dss.c              |    5 +
 drivers/video/omap2/dss/dss.h              |   43 +
 drivers/video/omap2/dss/dss_features.c     |    2 +-
 drivers/video/omap2/dss/hdmi.c             | 1332 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h             |  415 +++++++++
 drivers/video/omap2/dss/hdmi_omap4_panel.c |  222 +++++
 drivers/video/omap2/dss/manager.c          |    9 +-
 drivers/video/omap2/dss/overlay.c          |    6 +-
 16 files changed, 2216 insertions(+), 5 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi.c
 create mode 100644 drivers/video/omap2/dss/hdmi.h
 create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c

