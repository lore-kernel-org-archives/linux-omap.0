From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/8] OMAPDSS: fixes
Date: Mon, 21 May 2012 12:27:58 +0300
Message-ID: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:41346 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932453Ab2EUJ2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:20 -0400
Received: by lbbgo11 with SMTP id go11so3142277lbb.3
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Here are some late fixes for omapdss. Mostly small things that were found
during testing.

One exception is the TILER support from Chandrabhanu, which adds support to
configure omapdss so that it can be used with TILER. While not a fix, it's safe
to add as the patch doesn't affect non-TILER operations.

 Tomi

Archit Taneja (2):
  OMAPDSS: HACK: VENC/DISPC: Delay dividing Y resolution for managers
    connected to VENC
  OMAPDSS: Apply VENC timings even if panel is disabled

Chandrabhanu Mahapatra (1):
  OMAPDSS: DISPC: Support rotation through TILER

Tomi Valkeinen (5):
  OMAPDSS: use DSI_FIFO_BUG workaround only for manual update displays
  OMAPDSS: DISPC: fix usage of dispc_ovl_set_accu_uv
  OMAPDSS: remove compiler warnings when CONFIG_BUG=n
  OMAPFB: remove compiler warnings when CONFIG_BUG=n
  OMAPDSS: VRFB: remove compiler warnings when CONFIG_BUG=n

 drivers/video/omap2/dss/apply.c          |    2 +-
 drivers/video/omap2/dss/dispc.c          |  130 +++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dispc.h          |   72 +++++++++++++++++
 drivers/video/omap2/dss/display.c        |    2 +
 drivers/video/omap2/dss/dsi.c            |    9 ++-
 drivers/video/omap2/dss/dss.c            |    3 +
 drivers/video/omap2/dss/dss.h            |    3 +-
 drivers/video/omap2/dss/dss_features.c   |   16 ++++
 drivers/video/omap2/dss/dss_features.h   |    3 +
 drivers/video/omap2/dss/overlay.c        |    6 ++
 drivers/video/omap2/dss/venc.c           |    9 +--
 drivers/video/omap2/omapfb/omapfb-main.c |    1 +
 drivers/video/omap2/omapfb/omapfb.h      |    1 +
 drivers/video/omap2/vrfb.c               |    4 +-
 include/video/omapdss.h                  |    5 +-
 15 files changed, 233 insertions(+), 33 deletions(-)

-- 
1.7.9.5

