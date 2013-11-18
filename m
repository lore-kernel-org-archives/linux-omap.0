From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAPDSS: suspend/resume improvements
Date: Mon, 18 Nov 2013 14:50:03 +0200
Message-ID: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3KRMuO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:50:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC's suspend/resume works ok on mainline, but there was recently a bug with
TI's kernel containing support for newer SoCs. The bug was that not all DISPC
registers were restored correctly on resume.

While this bug is not in the mainline, I realized that the current
suspend/resume support in DISPC is rather silly, and can be done much more
efficiently.

This series improves the suspend/resume, making introducing similar bugs as
seen in TI kernel not possible, and cleans up the code quite a bit.

There's also a patch to use runtime PM's autosuspend with DSS devices, which
should reduce the on/off cycles when e.g. starting omapdss.

 Tomi

Tomi Valkeinen (6):
  OMAPDSS: APPLY: set infos to dirty on enable
  OMAPDSS: DISPC: Remove context restore
  OMAPDSS: DSS remove ctx stuff
  OMAPDSS: remove dss_get_ctx_loss_count
  OMAPDSS: add debug print for runtime suspend/resume
  OMAPDSS: use runtime PM's autosuspend

 arch/arm/mach-omap2/display.c   |   1 -
 drivers/video/omap2/dss/apply.c |  22 ++++
 drivers/video/omap2/dss/dispc.c | 262 ++--------------------------------------
 drivers/video/omap2/dss/dsi.c   |   9 +-
 drivers/video/omap2/dss/dss.c   | 103 ++++++----------
 drivers/video/omap2/dss/dss.h   |   4 +-
 drivers/video/omap2/dss/hdmi4.c |   9 +-
 drivers/video/omap2/dss/rfbi.c  |   9 +-
 drivers/video/omap2/dss/venc.c  |   9 +-
 include/video/omapdss.h         |   1 -
 10 files changed, 101 insertions(+), 328 deletions(-)

-- 
1.8.3.2

