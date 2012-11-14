From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/2] OMAPDSS: DISPC: Update manager size limits for OMAP5
Date: Wed, 14 Nov 2012 13:50:14 +0530
Message-ID: <1352881216-7490-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187Ab2KNIUm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 03:20:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Manager width and height can go up to 4K on OMAP5. Make manager width and height
register field offsets and maximum limits as dispc_features. Create a new
dispc_feature struct for OMAP5 which highlights this difference.

Archit Taneja (2):
  OMAPDSS: Add overlay manager width and height limits as a dispc
    feature
  OMAPDSS: Add a dispc_features struct for OMAP5

 drivers/video/omap2/dss/dispc.c        |   47 +++++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss_features.c |    8 ------
 drivers/video/omap2/dss/dss_features.h |    2 --
 3 files changed, 43 insertions(+), 14 deletions(-)

-- 
1.7.9.5

