From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/7] OMAP: DSS2: DSI2 for secondary lcd panel on OMAP4
Date: Thu, 12 May 2011 17:26:23 +0530
Message-ID: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab1ELLvr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:51:47 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CBplEo018995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:51:47 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4CBpkTP008347
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:51:46 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

OMAP4 has a DSI2 module, whose lanes are connected to the secondary lcd panel on
blaze and 4430sdp.
Modify dsi.c driver to register and work multiple DSI devices. Make the
necessary changes needed to introduce DSI2 PLL clocks.

Changes since v1:
-Rename functions used for getting dsidev
-Remove FEAT_DSS_DSI2
-Rework debugfs usage for dsi

Applies over:

https://gitorious.org/linux-omap-dss2/linux/commits/master

Archit Taneja (7):
  OMAP: DSS2: DSI: Add extra omap_dss_device argument in functions
    exported by dsi
  OMAP: DSS2: Remove omap_dss_device argument from dsi_pll_init()
  OMAP: DSS2: Pass platform_device as an argument in dsi functions
  OMAP: DSS2: DSI: Use platform_device pointer to get dsi data
  OMAP: DSS2: DSI: Pass pointer to struct to packet_sent_handler isrs
  OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4
  OMAP: DSS2: Taal: Use device name in backlight_device_register

 drivers/video/omap2/displays/panel-taal.c |  124 +-
 drivers/video/omap2/dss/core.c            |    6 +-
 drivers/video/omap2/dss/dispc.c           |   16 +-
 drivers/video/omap2/dss/dpi.c             |   36 +-
 drivers/video/omap2/dss/dsi.c             | 1783 +++++++++++++++++------------
 drivers/video/omap2/dss/dss.c             |   44 +-
 drivers/video/omap2/dss/dss.h             |   45 +-
 drivers/video/omap2/dss/dss_features.c    |    2 +
 drivers/video/omap2/dss/dss_features.h    |    1 +
 include/video/omapdss.h                   |   39 +-
 10 files changed, 1261 insertions(+), 835 deletions(-)

