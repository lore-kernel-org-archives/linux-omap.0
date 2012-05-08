From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 0/5] OMAPDSS: APPLY: Treat overlay manager timings as shadow registers
Date: Tue, 8 May 2012 15:28:11 +0530
Message-ID: <1336471096-21096-1-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab2EHJ7C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 05:59:02 -0400
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

Changes since v3:

- Make sure that we write to the timing registers and set go bits when calling
  dss_mgr_set_timings
- Don't create dss_mgr_get_timings(), apply should pass the timings rather than
  outside DSS dunctions querying form it.

These patches apply over:

git://gitorious.org/linux-omap-dss2/linux.git dev

Archit Taneja (5):
  OMAPDSS: APPLY: Add manager timings as extra_info in private data
  OMAPDSS: Apply manager timings instead of direct DISPC writes
  OMAPDSS: MANAGER: Create a function to check manager timings
  OMAPDSS: APPLY: Remove display dependency from overlay and manager
    checks
  OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled

 drivers/video/omap2/dss/apply.c   |  140 ++++++++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dispc.c   |    2 +-
 drivers/video/omap2/dss/dpi.c     |    6 +-
 drivers/video/omap2/dss/dsi.c     |    5 +-
 drivers/video/omap2/dss/dss.h     |   13 +++-
 drivers/video/omap2/dss/hdmi.c    |    4 +-
 drivers/video/omap2/dss/manager.c |   19 +++++-
 drivers/video/omap2/dss/overlay.c |   20 +++---
 drivers/video/omap2/dss/rfbi.c    |    4 +-
 drivers/video/omap2/dss/sdi.c     |    2 +-
 drivers/video/omap2/dss/venc.c    |    2 +-
 11 files changed, 163 insertions(+), 54 deletions(-)

-- 
1.7.5.4

