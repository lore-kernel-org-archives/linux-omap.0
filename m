From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/9] OMAPDSS: minor fixes & cleanups
Date: Wed, 17 Oct 2012 14:20:26 +0300
Message-ID: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35058 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2JQLUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 07:20:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series contains minor cleanups and fixes for omapdss.

 Tomi

Tomi Valkeinen (9):
  OMAPDSS: DSI: fix dsi_get_dsidev_from_id()
  OMAPDSS: fix registering the vsync isr in apply
  OMAPDSS: DISPC: constify function parameters
  OMAPDSS: combine LCD related config into one func
  OMAPDSS: remove declarations for non-existing funcs
  OMAPDSS: DISPC: remove struct omap_overlay use
  OMAPDSS: DISPC: cleanup lcd and digit enable
  OMAPDSS: DISPC: add dispc_mgr_get_sync_lost_irq()
  OMAPDSS: DISPC: cleanup lcd/digit enable/disable

 drivers/video/omap2/dss/apply.c |   27 ++---
 drivers/video/omap2/dss/dispc.c |  235 ++++++++++++++++++++++++---------------
 drivers/video/omap2/dss/dsi.c   |   13 ++-
 drivers/video/omap2/dss/dss.h   |   21 ++--
 4 files changed, 174 insertions(+), 122 deletions(-)

-- 
1.7.9.5

