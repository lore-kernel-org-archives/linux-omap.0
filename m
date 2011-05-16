From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/4] OMAP: DSS2: Miscellaneous DSI cleanup and fixes
Date: Mon, 16 May 2011 15:17:05 +0530
Message-ID: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1EPJmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 05:42:16 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gFtb018775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:15 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gFTg010442
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:15 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Some minor fixes/cleanup for DSI:
- Remove some debug prints in dsi_dump_clocks().
- Use system workqueue instead of creating a private one.
- Add num_data_lanes and line_buffer_size and get the from DSI_GNQ register.

Archit Taneja (4):
  OMAP: DSS2: DSI: Remove DISPC pixel clock related info in
    dsi_dump_clocks()
  OMAP: DSS2: DSI: Use system workqueue for delayed work instead of a
    private workqueue
  OMAP: DSS2: DSI: Get number of DSI data lanes using DSI_GNQ register
  OMAP: DSS2: DSI: Get line buffer size from DSI_GNQ register

 drivers/video/omap2/dss/dsi.c          |  163 +++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dss_features.c |    3 +-
 drivers/video/omap2/dss/dss_features.h |    1 +
 include/video/omapdss.h                |    4 +
 4 files changed, 134 insertions(+), 37 deletions(-)

