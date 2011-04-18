From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS fixes for 39 rc
Date: Mon, 18 Apr 2011 10:12:41 +0300
Message-ID: <1303110761.2062.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42357 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab1DRHMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 03:12:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lethal@linux-sh.org
Cc: lo-ml <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

Hi Paul,

Here are a few OMAP DSS fixes for the next rc.

 Tomi

The following changes since commit a6360dd37e1a144ed11e6548371bade559a1e4df:

  Linux 2.6.39-rc3 (2011-04-11 17:21:51 -0700)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-paul-39-rc

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


