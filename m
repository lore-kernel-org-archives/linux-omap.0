From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAPDSS: naive fifomerge support
Date: Fri, 13 Jan 2012 13:46:27 +0200
Message-ID: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:44852 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752900Ab2AMLqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch set implements fifomerge and a naive version for fifo threshold
calculation when fifomerge is in use. The strategy is simple: keep the low
threshold the same for both fifomerge and non-fifomerge cases, but calculate
the high threshold using the combined fifo size when fifomerge is in use.

This should give some power savings, as the usable fifo size is much larger
when only one overlay is in use. It probably won't help fifo underflow cases,
as the low threshold is kept the same.

Tested on OMAP4 Blaze (DSI cmd mode) and OMAP3 Overo (DPI).

 Tomi

Tomi Valkeinen (6):
  OMAPDSS: FEAT: Add FIFO_MERGE feature
  OMAPDSS: APPLY: add fifo merge support funcs
  OMAPDSS: APPLY: add fifo-merge support
  OMAPDSS: DISPC: print fifo threshold values in bytes
  OMAPDSS: DISPC: move fifo threhold calc to dispc.c
  OMAPDSS: DISPC: Add naive threshold calc for fifomerge

 drivers/video/omap2/dss/apply.c        |  221 +++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dispc.c        |   51 +++++++-
 drivers/video/omap2/dss/display.c      |   10 --
 drivers/video/omap2/dss/dsi.c          |    8 -
 drivers/video/omap2/dss/dss.h          |   10 +-
 drivers/video/omap2/dss/dss_features.c |    9 +-
 drivers/video/omap2/dss/dss_features.h |    1 +
 7 files changed, 244 insertions(+), 66 deletions(-)

-- 
1.7.4.1

