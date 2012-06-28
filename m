From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 0/4] Add LCD3 channel support
Date: Thu, 28 Jun 2012 15:10:05 +0530
Message-ID: <cover.1340874806.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54378 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab2F1JkR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:40:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone!
This following patch series enables LCD3 support which consists of two patches.

The 1st patch
 * adds enum mgr_reg_fields to describe various register fields manipulated for
   LCD support
 * replaces if-else checks for LCD implementation with simpler interface with
   the help of data from struct mgr_desc

The 2nd Patch
 * adds LCD3 channel support
 * updates DISPC registers for LCD3 support

The 3rd patch
 * enables LCD3 manager DSS feature
 * adds enables clock support for LCD3
 * adds IRQs specific to LCD3 manager

The 4th patch
 * enables dispc functions to provide dump functionality for clocks and IRQs
   specific to LCD3

This patch was based on mainline kernel v3.5rc4.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (4):
  OMAPDSS: Cleanup implementation of LCD channels
  OMAPDSS: Add support for LCD3 channel
  OMAPDSS: Add LCD3 overlay manager and Clock and IRQ support
  OMAPDSS: Add dump and debug support for LCD3

 drivers/video/omap2/dss/dispc.c        |  351 ++++++++++++++++++--------------
 drivers/video/omap2/dss/dispc.h        |   28 +++
 drivers/video/omap2/dss/dsi.c          |    6 +-
 drivers/video/omap2/dss/dss.c          |   12 +-
 drivers/video/omap2/dss/dss.h          |    6 +
 drivers/video/omap2/dss/dss_features.h |    5 +-
 drivers/video/omap2/dss/manager.c      |   16 +-
 drivers/video/omap2/dss/overlay.c      |   14 +-
 include/video/omapdss.h                |    6 +
 9 files changed, 268 insertions(+), 176 deletions(-)

