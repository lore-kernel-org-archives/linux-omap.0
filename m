From: Mythri P K <mythripk@ti.com>
Subject: [PATCH 0/8] OMAP4 : DSS2 : HDMI support
Date: Fri, 25 Feb 2011 19:51:47 +0530
Message-ID: <1298643715-21540-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49068 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab1BYNyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:54:12 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1PDsBkJ030900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 07:54:11 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

Adding HDMI support to OMAP4.

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
2.HDMI configuration such asbased on the parameters read from the EDID of the
sink device :
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

Mythri P K (8):
  OMAP4 : DSS2 : Add display type HDMI to DSS2
  OMAP4 : DSS2 : Add display structure in the board file for OMAP4 sdp
  OMAP4 : DSS : HDMI: HDMI specific display controller and dss change.
  OMAP4 : DSS : HDMI: HDMI driver header file addition
  OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS drivers
    interface
  OMAP4 : DSS2 : HDMI: HDMI panel driver addition in the DSS
  OMAP4 : DSS : HDMI: Call to HDMI module init to register driver.
  OMAP4 : DSS2 : Add display structure in the board file for OMAP4
    pandaboard

 arch/arm/mach-omap2/board-4430sdp.c        |   82 ++
 arch/arm/mach-omap2/board-omap4panda.c     |   82 ++
 arch/arm/plat-omap/include/plat/display.h  |    1 +
 drivers/video/omap2/dss/Kconfig            |   16 +
 drivers/video/omap2/dss/Makefile           |    2 +
 drivers/video/omap2/dss/core.c             |    8 +
 drivers/video/omap2/dss/dispc.c            |    5 +
 drivers/video/omap2/dss/display.c          |    8 +
 drivers/video/omap2/dss/dss.c              |    7 +
 drivers/video/omap2/dss/dss.h              |   35 +
 drivers/video/omap2/dss/dss_features.c     |    2 +-
 drivers/video/omap2/dss/hdmi.c             | 1276 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h             |  700 +++++++++++++++
 drivers/video/omap2/dss/hdmi_omap4_panel.c |  190 +++++
 drivers/video/omap2/dss/manager.c          |    9 +-
 drivers/video/omap2/dss/overlay.c          |    6 +-
 16 files changed, 2424 insertions(+), 5 deletions(-)
 create mode 100644 drivers/video/omap2/dss/hdmi.c
 create mode 100644 drivers/video/omap2/dss/hdmi.h
 create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c

