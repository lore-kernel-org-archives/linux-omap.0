From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAP: DSS PM fixes
Date: Mon, 23 Jan 2012 14:15:27 +0200
Message-ID: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46913 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab2AWMPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 07:15:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk, Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are two fixes to get DSS work better with PM on OMAP3.

The first two patches fix the missing SYSC_HAS_ENAWAKEUP flag, which removes
the SYNC_LOST problem.

The third patch changes omapdss to use pm_runtime_put_sync functions, which
fixes the system suspend.

I've tested both only on v3.3-rc1, OMAP3 Overo. I get problems on system
suspend from TWL and MTD drivers (also without my patches =), but disabling MTD
and ignoring TWL errors shows that the warning from omapdss has disappeared,
and I get an image on the screen on resume.

The two fixes are independent, so either I can take them through dss tree (with
appropriate Acks), or the hwmod patches can go through some other tree.

The fixes should also work directly on v3.2, even though I haven't tested them
yet.

 Tomi

Tomi Valkeinen (3):
  ARM: OMAP: HWMOD: split omap2/3 dispc hwmod class
  ARM: OMAP3: HWMOD: add SYSC_HAS_ENAWAKEUP for dispc
  OMAPDSS: use sync versions of pm_runtime_put

 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   21 -----------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   22 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   24 +++++++++++++++++++-
 drivers/video/omap2/dss/dispc.c                    |    2 +-
 drivers/video/omap2/dss/dsi.c                      |    2 +-
 drivers/video/omap2/dss/dss.c                      |    2 +-
 drivers/video/omap2/dss/hdmi.c                     |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |    2 +-
 drivers/video/omap2/dss/venc.c                     |    2 +-
 9 files changed, 51 insertions(+), 28 deletions(-)

-- 
1.7.4.1

