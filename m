From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/7] OMAPDSS: use components (fix probing problems)
Date: Tue, 16 Jun 2015 13:16:22 +0300
Message-ID: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34953 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871AbbFPKRG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 06:17:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

I noticed that on some platforms omapdss did not probe successfully. Some
resource was not available yet, but omapdss did not manage to handle deferred
probing. The reason was the use of platform_driver_probe() in combination with
how the omapdss module handles the drivers.

To fix this properly, the component system felt fine for the job, and it seems
to work nicely.

 Tomi

Tomi Valkeinen (7):
  OMAPDSS: move 'dss_initialized' to dss driver
  OMAPDSS: refactor dss probe function
  OMAPDSS: fix dss_init_ports error handling
  OMAPDSS: remove uses of __init/__exit
  OMAPDSS: reorder uninit calls
  OMAPDSS: componentize omapdss
  OMAPDSS: simplify submodule reg/unreg code

 drivers/video/fbdev/omap2/dss/core.c  |  80 ++++--------
 drivers/video/fbdev/omap2/dss/dispc.c |  42 +++++--
 drivers/video/fbdev/omap2/dss/dpi.c   |  36 ++++--
 drivers/video/fbdev/omap2/dss/dsi.c   |  27 +++-
 drivers/video/fbdev/omap2/dss/dss.c   | 223 +++++++++++++++++++++++-----------
 drivers/video/fbdev/omap2/dss/dss.h   |  32 ++---
 drivers/video/fbdev/omap2/dss/hdmi4.c |  28 ++++-
 drivers/video/fbdev/omap2/dss/hdmi5.c |  28 ++++-
 drivers/video/fbdev/omap2/dss/rfbi.c  |  32 ++++-
 drivers/video/fbdev/omap2/dss/sdi.c   |  35 ++++--
 drivers/video/fbdev/omap2/dss/venc.c  |  31 +++--
 11 files changed, 396 insertions(+), 198 deletions(-)

-- 
2.1.4

