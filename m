From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 00/10] OMAP4: DSS2: VIDEO3, zorder and misc DSS patches
Date: Wed, 14 Sep 2011 17:53:26 +0530
Message-ID: <1316003008-24192-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756527Ab1INMWP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:22:15 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECMFNj013047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:15 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECMFpi021273
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:15 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECMFBc028967
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:15 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This contains support for VIDEO3 pipeline and zorder support for OMAP4 Display
controller. Apart form this the patches do some code clean up or minor fixes.

The patch set is based on Tomi's master branch and some additional patch sets
posted by Tomi on linux-omap. The patches can be tested on the branch below:

https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/dispc_mix

Tested on 4430sdp, 3430sdp.

Archit Taneja (10):
  OMAP: DSS2: Reduce the number of arguments in dispc_ovl_setup()
  OMAP: DSS2: Pass overlay replication and fifo thresholds as arguments
    to dispc_ovl_setup()
  OMAP4: DSS2: Fix incorrect OMAP3-alpha compatibility setting
  OMAP4: DSS2: VIDEO3 pipeline support
  OMAP4: DSS2: zorder support for DSS overlays
  OMAP: DSS2: Create helper function dispc_mgr_is_lcd()
  OMAP2PLUS: DSS2: Get correct pixel clock for TV manager
  OMAP2PLUS: DSS2: DISPC: Remove hardcoded use of PPL in five tap clock
    calculation
  OMAP2PLUS: DSS2: Clean up DISPC scaling related clock and five tap
    calculations
  OMAP2PLUS: DSS2: FEATURES: Create a range param to get max
    downscaling

 drivers/video/omap2/dss/dispc.c        |  362 +++++++++++++++++++-------------
 drivers/video/omap2/dss/dispc.h        |   57 +++++
 drivers/video/omap2/dss/dss.h          |   33 ++--
 drivers/video/omap2/dss/dss_features.c |   43 +++--
 drivers/video/omap2/dss/dss_features.h |    6 +-
 drivers/video/omap2/dss/hdmi.c         |    6 +
 drivers/video/omap2/dss/manager.c      |   61 +++---
 drivers/video/omap2/dss/overlay.c      |   77 +++++++
 drivers/video/omap2/dss/venc.c         |    8 +-
 include/video/omapdss.h                |    9 +-
 10 files changed, 452 insertions(+), 210 deletions(-)

