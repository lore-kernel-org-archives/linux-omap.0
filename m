From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/4] OMAPDSS: APPLY: Treat overlay manager timings as shadow registers
Date: Thu, 3 May 2012 12:37:40 +0530
Message-ID: <1336028864-13895-1-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38759 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab2ECHI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:08:29 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

An overlay manager's timings (the manager size, and blanking parameters if an
LCD manager) are DISPC shadow registers, and they should hence follow the
correct programming model.

This set makes the timings an extra_info parameter in manager's private data .
The interface drivers now apply the timings in instead of directly writing to
registers.

This change also prevents the need to use display resolution for overlay
checks, hence making some of the APPLY functions less dependent on the display.

Changes since v2:

- Manager timings are represented as extra_info.
- The DISPC related cleanups are removed since they have already been taken.

These patches apply over:

git://gitorious.org/linux-omap-dss2/linux.git dev

Archit Taneja (4):
  OMAPDSS: APPLY: Add manager timings as extra_info in private data
  OMAPDSS: Apply manager timings instead of direct DISPC writes
  OMAPDSS: MANAGER: Create a function to check manager timings
  OMAPDSS: APPLY: Remove display dependency from overlay and manager
    checks

 drivers/video/omap2/dss/apply.c   |  142 ++++++++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dpi.c     |    4 +-
 drivers/video/omap2/dss/dsi.c     |    5 +-
 drivers/video/omap2/dss/dss.h     |    9 ++-
 drivers/video/omap2/dss/hdmi.c    |    2 +-
 drivers/video/omap2/dss/manager.c |   19 +++++-
 drivers/video/omap2/dss/overlay.c |   20 +++---
 drivers/video/omap2/dss/rfbi.c    |    4 +-
 drivers/video/omap2/dss/sdi.c     |    2 +-
 drivers/video/omap2/dss/venc.c    |    2 +-
 10 files changed, 158 insertions(+), 51 deletions(-)

-- 
1.7.5.4

