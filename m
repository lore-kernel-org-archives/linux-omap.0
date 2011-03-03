From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] OMAP: DSS2: Cleanup patches
Date: Thu, 3 Mar 2011 10:35:24 +0200
Message-ID: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757253Ab1CCIff (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 03:35:35 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p238ZZbf027331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:35 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZYPW005504
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:34 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZYHH005541
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:34 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are some patches to cleanup the DSS init a bit. 

Tomi Valkeinen (4):
  OMAP: DSS2: Remove FB_OMAP_BOOTLOADER_INIT support
  OMAP: DSS2: Remove pdev argument from dpi_init
  OMAP: DSS2: Move DPI & SDI init into DSS plat driver
  OMAP: DSS2: Remove unneeded cpu_is_xxx checks

 drivers/video/omap2/dss/core.c |   43 ++++-------------------------
 drivers/video/omap2/dss/dpi.c  |    2 +-
 drivers/video/omap2/dss/dss.c  |   58 ++++++++++++++++++++++------------------
 drivers/video/omap2/dss/dss.h  |    8 +++---
 drivers/video/omap2/dss/sdi.c  |   40 ++++++---------------------
 5 files changed, 52 insertions(+), 99 deletions(-)

