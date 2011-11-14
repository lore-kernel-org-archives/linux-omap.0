From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAPDSS: fixes for rc
Date: Mon, 14 Nov 2011 17:01:42 +0200
Message-ID: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52151 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1KNPBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 10:01:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

A few fixes for the next -rc.

One for the old omapfb, and two for the omapdss fixing issues related to HDMI.

 Tomi

Tomi Valkeinen (3):
  OMAPDSS: HDMI: fix returned HDMI pixel clock
  OMAPFB: fix compilation warnings due to missing include
  OMAPDSS: DISPC: skip scaling calculations when not scaling

 drivers/video/omap/dispc.c      |    2 +-
 drivers/video/omap2/dss/dispc.c |   11 +++++------
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.7.4.1

