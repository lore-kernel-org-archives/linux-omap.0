From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/5] OMAP: DSS2: miscellaneous patches
Date: Wed, 13 Apr 2011 09:50:12 +0300
Message-ID: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47569 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320Ab1DMGuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 02:50:35 -0400
Received: by ewy28 with SMTP id 28so107728ewy.39
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 23:50:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some small miscellaneous fixes/improvements for DSS2.

 Tomi

Tomi Valkeinen (5):
  OMAP: DSS2: Convert simple/strict_strto* to kstrto*
  OMAP: DSS2: DSI: fix dsi_dump_clocks()
  OMAP: DSS2: improve clock debugfs output
  OMAP: DSS2: DSI: fix use_sys_clk & highfreq
  OMAP: DSS2: fix panel Kconfig dependencies

 drivers/video/omap2/displays/Kconfig               |    9 ++--
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    8 ++-
 drivers/video/omap2/dss/display.c                  |   44 +++++++++++++-------
 drivers/video/omap2/dss/dsi.c                      |    9 ++--
 drivers/video/omap2/dss/dss.c                      |   13 +++++-
 drivers/video/omap2/dss/overlay.c                  |   22 ++++++++--
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |   21 ++++++---
 7 files changed, 87 insertions(+), 39 deletions(-)

