From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/9] MAP: DSS2: DSI2 for secondary lcd panel on OMAP4
Date: Wed,  4 May 2011 13:08:15 +0530
Message-ID: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab1EDHdb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:33:31 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447XUHx027825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:33:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

OMAP4 has a DSI2 module, whose lanes are connected to the secondary lcd panel on
blaze and 4430sdp.
Modify dsi.c driver to register and work multiple DSI devices. Make the
necessary changes needed to introduce DSI2 PLL clocks.

Applies over:

https://gitorious.org/linux-omap-dss2/linux/commits/master

Can be tested on:

https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/master

Note:
The patch to enable secondary lcd in through the board file is not a part of
this series. The patch in the above tree can be used to test DSI2 functionality:

TEMP: OMAP: DSS2: Add Secondary LCD data in board-4430sdp.c

Archit Taneja (9):
  OMAP: DSS2: Change DSI platform device name from "omapdss_dsi1" to
    "omapdss_dsi"
  OMAP: DSS2: DSI: Add extra omap_dss_device argument in functions
    exported by dsi
  OMAP: DSS2: Remove omap_dss_device argument from dsi_pll_init()
  OMAP: DSS2: Pass platform_device as an argument in dsi functions
  OMAP: DSS2: DSI: Use platform_device pointer to get dsi data
  OMAP: DSS2: DSI: Pass pointer to struct to packet_sent_handler isrs
  OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4
  OMAP: DSS2: DSI: Build a platform device instance for DSI2
  OMAP: DSS2: Taal: Use device name in backlight_device_register

 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/display.c                |    6 +-
 arch/arm/plat-omap/include/plat/display.h    |   39 +-
 drivers/video/omap2/displays/panel-taal.c    |  124 +-
 drivers/video/omap2/dss/core.c               |   14 +-
 drivers/video/omap2/dss/dispc.c              |   16 +-
 drivers/video/omap2/dss/dpi.c                |   36 +-
 drivers/video/omap2/dss/dsi.c                | 1734 +++++++++++++++-----------
 drivers/video/omap2/dss/dss.c                |   48 +-
 drivers/video/omap2/dss/dss.h                |   45 +-
 drivers/video/omap2/dss/dss_features.c       |    5 +-
 drivers/video/omap2/dss/dss_features.h       |    2 +
 21 files changed, 1234 insertions(+), 856 deletions(-)

