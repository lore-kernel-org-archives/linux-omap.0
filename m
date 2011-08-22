From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAPDSS: Cleanup after HWMOD fixes
Date: Mon, 22 Aug 2011 11:26:08 +0300
Message-ID: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48235 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752339Ab1HVI0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

After the patch-set "[PATCHv2 0/5] OMAP DSS HWMOD fixes" we can revert the DSS
hacks added to circumvent broken HWMOD data, and clean up unneeded clock
handling.

Tomi

Tomi Valkeinen (3):
  Revert "HACK: OMAP: DSS2: clk hack for OMAP2/3"
  Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
  OMAP: DSS2: remove unneeded fck enable/disables

 drivers/video/omap2/dss/dispc.c |    2 --
 drivers/video/omap2/dss/dsi.c   |   12 +-----------
 drivers/video/omap2/dss/dss.c   |    7 -------
 drivers/video/omap2/dss/dss.h   |    2 --
 drivers/video/omap2/dss/hdmi.c  |   14 --------------
 drivers/video/omap2/dss/rfbi.c  |    5 +----
 drivers/video/omap2/dss/venc.c  |   19 +------------------
 7 files changed, 3 insertions(+), 58 deletions(-)

-- 
1.7.4.1

