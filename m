From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 00/18] OMAPDSS: DISPC changes for writeback pipeline
Date: Tue, 25 Sep 2012 11:48:20 +0530
Message-ID: <1348553919-7905-1-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50130 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab2IYGSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 02:18:40 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

This series prepares the low level DISPC driver(dispc.c) to configure writeback
registers. Original series can be seen here:

http://marc.info/?l=linux-fbdev&m=134753851619354&w=2

Changes since v2:

- Removed patches which rename dispc_ovl_* functions to dispc_plane_*
- Revisited the scaling related code a bit. Removed the usage of 'output rate'
  to fit in writeback. Instead, added a new parameter called mem_to_mem, passed
  by APPLY. This tells whether we have to consider a display pixel clock for
  scaling limitations or not.
- All 'Scalar' references renamed to 'Scaler'.
- Minor cleanups.

Reference branch:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 1-writeback-dispc

Archit Taneja (18):
  OMAPDSS: DISPC: Constify omap_overlay_info in dispc_ovl_setup()
  OMAPDSS: DISPC: Simplify function names for setting pipeline input
    and output sizes
  OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc plane
    functions
  OMAPDSS: OVERLAY: Add position and replication as overlay caps
  OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_ovl_setup_common
  OMAPDSS: DISPC: Don't pass channel out when configuring overlays
  OMAPDSS: DIPSC: Relax scaling limitations when in memory to memory
    mode
  OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
  OMAPDSS: DISPC: Add writeback register offsets and dss features
    structs
  OMAPDSS: DISPC: Configure input and output sizes for writeback
  OMAPDSS: DISPC: Downscale chroma if plane is writeback
  OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
  OMAPDSS: DISPC: Add function to set channel in for writeback
  OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
  OMAPDSS: DISPC: Configure writeback specific parameters in
    dispc_wb_setup()
  OMAPDSS: DISPC: Configure writeback FIFOs
  OMAPDSS: DISPC: Add manager like functions for writeback
  OMAPDSS: DISPC: Configure color conversion coefficients for writeback

 drivers/video/omap2/dss/apply.c        |    2 +-
 drivers/video/omap2/dss/dispc.c        |  561 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dispc.h        |   33 ++
 drivers/video/omap2/dss/dss.h          |   25 +-
 drivers/video/omap2/dss/dss_features.c |   57 +++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 include/video/omapdss.h                |   15 +
 7 files changed, 510 insertions(+), 184 deletions(-)

-- 
1.7.9.5

