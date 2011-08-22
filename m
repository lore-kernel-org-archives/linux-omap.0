From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/10] OMAPDSS: code cleanups
Date: Mon, 22 Aug 2011 11:27:41 +0300
Message-ID: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58657 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756689Ab1HVI2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Cleanups for DSS driver, no functionality changed.

 Tomi

Tomi Valkeinen (10):
  OMAP: DSS2: Remove support for non-DISPC overlays
  OMAP: DSS2: DISPC: use lookup tables for bit shifts
  OMAP: DSS2: Add overlay caps to DSS features
  OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
  OMAP: DSS2: string parsing cleanups
  OMAP: OMAPFB: string parsing cleanups
  OMAP: DSS2: DISPC: remove non-existing func prototypes
  OMAP: DSS2: DISPC: rename overlay related funcs
  OMAP: DSS2: DISPC: rename manager related funcs
  OMAP: DSS2: reorganize functions in dss.h

 drivers/video/omap2/dss/dispc.c           |  478 +++++++++++------------------
 drivers/video/omap2/dss/display.c         |   21 +-
 drivers/video/omap2/dss/dpi.c             |   16 +-
 drivers/video/omap2/dss/dsi.c             |  205 ++-----------
 drivers/video/omap2/dss/dss.h             |   93 +++---
 drivers/video/omap2/dss/dss_features.c    |   68 ++++-
 drivers/video/omap2/dss/dss_features.h    |    3 +-
 drivers/video/omap2/dss/hdmi.c            |    6 +-
 drivers/video/omap2/dss/manager.c         |  126 +++-----
 drivers/video/omap2/dss/overlay.c         |   38 +--
 drivers/video/omap2/dss/rfbi.c            |   33 +--
 drivers/video/omap2/dss/sdi.c             |   12 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    6 +-
 include/video/omapdss.h                   |    9 +-
 14 files changed, 396 insertions(+), 718 deletions(-)

-- 
1.7.4.1

