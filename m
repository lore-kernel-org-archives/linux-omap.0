From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 0/3] OMAPDSS: Enable dynamic debug printing
Date: Fri, 28 Sep 2012 15:53:02 +0530
Message-ID: <cover.1348826106.git.cmahapatra@ti.com>
References: <cover.1348636132.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60716 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab2I1KZU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:25:20 -0400
In-Reply-To: <cover.1348636132.git.cmahapatra@ti.com>
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
 * replaces printk() in DSSDBG definition with pr_debug()
 * removes DSSDBGF definition and replaces its instances with DSSDBG() 
The 3rd patch
 * cleans up printk()'s in omap_dispc_unregister_isr() and 
   _dsi_print_reset_status() with pr_debug()
 * removes dss_debug variable

Changes from V1 to V2:
 * added debug messages to DSSDBG calls
 * added patch "OMAPDSS: Remove dss_debug variable"

Changes from V2 to V3
 * added patch "OMAPDSS: Move definition of DEBUG flag to Makefile"

All your comments and suggestions are welcome.

Refenence Tree:
git://gitorious.org/linux-omap-dss2/chandrabhanus-linux.git dss_cleanup

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (3):
  OMAPDSS: Move definition of DEBUG flag to Makefile
  OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
  OMAPDSS: Remove dss_debug variable

 drivers/video/omap2/dss/Makefile |    1 +
 drivers/video/omap2/dss/apply.c  |    8 +++----
 drivers/video/omap2/dss/core.c   |    5 ----
 drivers/video/omap2/dss/dispc.c  |   39 +++++++++++-------------------
 drivers/video/omap2/dss/dsi.c    |   49 ++++++++++++++++----------------------
 drivers/video/omap2/dss/dss.h    |   38 +++++------------------------
 6 files changed, 45 insertions(+), 95 deletions(-)

-- 
1.7.10

