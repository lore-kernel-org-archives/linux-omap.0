From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/6] OMAPDSS: APPLY: Treat overlay manager timings as shadow registers
Date: Mon, 16 Apr 2012 12:53:41 +0530
Message-ID: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48248 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2DPHYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 03:24:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

An overlay manager's timings (the manager size, and blanking parameters if an
LCD manager) are DISPC shadow registers, and they should hence follow the
correct programming model.

This set makes the timings a manager_info parameter. The interface drivers now
set the timings in manager_info instead of directly writing to registers.

This change also prevents the need to use display resolution for overlay
checks, hence making some of the APPLY functions less dependent on the display.

These patches apply over:

git://gitorious.org/linux-omap-dss2/linux.git dev

Archit Taneja (6):
  OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lcd
    size
  OMAPDSS: DISPC: Use a common function to set manager timings
  OMAPDSS: DISPC: Clean up manager timing/size functions
  OMAPDSS: MANAGER: Make DISPC timings a manager_info parameter
  OMAPDSS: MANAGER: Check validity of manager timings
  OMAPDSS: APPLY: Remove display dependency from overlay and manager
    checks

 drivers/video/omap2/dss/apply.c        |   46 +++++++++++++-----
 drivers/video/omap2/dss/dispc.c        |   78 +++++++++++++++++++-------------
 drivers/video/omap2/dss/dpi.c          |    6 ++-
 drivers/video/omap2/dss/dsi.c          |   11 ++++-
 drivers/video/omap2/dss/dss.h          |   16 +++---
 drivers/video/omap2/dss/dss_features.c |    6 +++
 drivers/video/omap2/dss/dss_features.h |    2 +
 drivers/video/omap2/dss/hdmi.c         |    6 ++-
 drivers/video/omap2/dss/manager.c      |   39 +++++++++++++++-
 drivers/video/omap2/dss/overlay.c      |   20 ++++-----
 drivers/video/omap2/dss/rfbi.c         |   27 ++++++++++-
 drivers/video/omap2/dss/sdi.c          |    5 ++-
 drivers/video/omap2/dss/venc.c         |   17 +++++---
 include/video/omapdss.h                |    2 +
 14 files changed, 200 insertions(+), 81 deletions(-)

-- 
1.7.5.4

