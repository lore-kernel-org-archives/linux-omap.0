From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/5] OMAP: DSS: fixes for rc
Date: Fri, 15 Apr 2011 11:11:06 +0300
Message-ID: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59709 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab1DOIL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 04:11:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some small fixes to OMAP DSS for the next rc.

I will send a pull request to Paul Mundt soon if there are no problems with the
patches.

Note that DSS doesn't still work for OMAP4. It needs a clock patch which has
been discussed on l-o, and Paul Walmsley will handle that patch.

 Tomi

Archit Taneja (1):
  OMAP: DSS2: Fix: Return correct lcd clock source for OMAP2/3

Tomi Valkeinen (4):
  OMAP: DSS2: DSI: fix use_sys_clk & highfreq
  OMAP: DSS2: DSI: fix dsi_dump_clocks()
  OMAP: DSS2: DSI: Fix DSI PLL power bug
  OMAP: DSS2: fix panel Kconfig dependencies

 drivers/video/omap2/displays/Kconfig   |    9 +++++----
 drivers/video/omap2/dss/dsi.c          |   14 +++++++++-----
 drivers/video/omap2/dss/dss.c          |   10 ++++++++--
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 ++
 5 files changed, 25 insertions(+), 12 deletions(-)

