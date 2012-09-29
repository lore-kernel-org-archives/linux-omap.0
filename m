From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 0/5] OMAPDSS: Enable dynamic debug printing
Date: Sat, 29 Sep 2012 16:19:21 +0530
Message-ID: <cover.1348914940.git.cmahapatra@ti.com>
References: <cover.1348826106.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45406 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab2I2Kvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Sep 2012 06:51:47 -0400
In-Reply-To: <cover.1348826106.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
this patch series aims at cleaning up of DSS of printk()'s enabled with
dss_debug and replace them with generic dynamic debug printing.

The 1st patch
 * moved DEBUG flag definition to Makefile
The 2nd patch
 * created two debug config options OMAP2_DSS_DEBUG and OMAP2_DSS_DEBUGFS
The 3rd patch
 * replaces printk() in DSSDBG definition with pr_debug()
 * removes DSSDBGF definition and replaces its instances with DSSDBG() 
The 4th patch
 * cleans up printk()'s in omap_dispc_unregister_isr() and 
   _dsi_print_reset_status() with pr_debug()
The 5th patch
 * removes dss_debug variable

Changes from V1 to V2:
 * added debug messages to DSSDBG calls
 * added patch "OMAPDSS: Remove dss_debug variable"

Changes from V2 to V3
 * added patch "OMAPDSS: Move definition of DEBUG flag to Makefile"

Changes from V3 to V4:
 * added patch "OMAPDSS: Create new debug config options"
 * broke earlier patch "OMAPDSS: Remove dss_debug variable" into two parts as
   "OMAPDSS: Replace multi part debug prints with pr_debug" and
   "OMAPDSS: Remove dss_debug variable"

All your comments and suggestions are welcome.

Refenence Tree:
git://gitorious.org/linux-omap-dss2/chandrabhanus-linux.git dss_cleanup

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (5):
  OMAPDSS: Move definition of DEBUG flag to Makefile
  OMAPDSS: Create new debug config options
  OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
  OMAPDSS: Replace multi part debug prints with pr_debug
  OMAPDSS: Remove dss_debug variable

 drivers/video/omap2/dss/Kconfig  |   21 +++++++++++-----
 drivers/video/omap2/dss/Makefile |    1 +
 drivers/video/omap2/dss/apply.c  |    8 +++----
 drivers/video/omap2/dss/core.c   |   11 +++------
 drivers/video/omap2/dss/dispc.c  |   40 ++++++++++++-------------------
 drivers/video/omap2/dss/dsi.c    |   49 ++++++++++++++++----------------------
 drivers/video/omap2/dss/dss.c    |    2 +-
 drivers/video/omap2/dss/dss.h    |   40 ++++++-------------------------
 8 files changed, 66 insertions(+), 106 deletions(-)

-- 
1.7.10

