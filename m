From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Thu, 13 Sep 2012 17:44:44 +0530
Message-ID: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39450 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757902Ab2IMMPB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

DSS HW on OMAP4 onwards supports a new pipeline called writeback. Unlike other
pipelines(called overlays in OMAPDSS), writeback takes pixel data from an
overlay output or a overlay manager output and writes it back into a specified
address in memory.

writeback pipeline allows us to take benefit of the hardware processing
available inside the DISPC like color space conversion, rescaling, compositing
etc and do either a) perform memory-to-memory transfer with data processing,
b) capture a displayed frame. The former is known as memory to memory mode of
the writeback pipeline, and the latter is known as capture mode. More details
about writeback can be found in the Display Subsystem section of the OMAP4/5 TRMs.

witeback has properties of both overlays and overlay managers. It is like an
overlay as it has programmable base addresses and contains blocks like scalar,
color conversion unit, truncation unit, DISPC DMA FIFO. It is like a manager as
enabling it immediately starts transfer to the memory, and it has a GO bit to use
a new writeback configuration.

This series prepares the low level DISPC driver(dispc.c) to configure writeback
registers. The aim is to reuse most of the code as most of its registers are
like overlay or manager registers, and are configured in the same way in most
cases. The first few patches rename dispc_ovl_* functions to dispc_plane_*
functions. The next few patches change how overlay caps are used within the
dispc functions, this helps reusing more functions between overlays and
writeback. The patches in the end add writeback register offsets, and make
changes in the code where writeback behaves differently than

The changes are made only keeping writeback mem to mem support in mind. There
would be a few changes required when capture mode is added, but those are
minimal.

Reference branch:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 1-writeback-dispc

Archit Taneja (21):
  OMAPDSS: DISPC: Constify omap_overlay_info in dispc_ovl_setup()
  OMAPDSS: DISPC: Rename scalar related functions from dispc_ovl_* to
    dispc_plane_*
  OMAPDSS: DISPC: Rename fifo/burst related functions from dispc_ovl_*
    to dispc_plane_*
  OMAPDSS: DISPC: Rename misc functions from dispc_ovl_* to
    dispc_plane_*
  OMAPDSS: DISPC: Simplify function names for setting pipeline input
    and output sizes
  OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc plane
    functions
  OMAPDSS: OVERLAY: Add position and replication as overlay caps
  OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_plane_setup
  OMAPDSS: DISPC: Calculate scaling limits in a more generic way
  OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
  OMAPDSS: DISPC: Add writeback register offsets and dss features
    structs
  OMAPDSS: DISPC: Configure input and output sizes for writeback
  OMAPDSS: DISPC: Pass dummy scalar output rates for writeback pipeline
  OMAPDSS: DISPC: Downscale chroma if plane is writeback
  OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
  OMAPDSS: DISPC: Add function to set channel in for writeback
  OMAPDSS: DISPC: Configure overlay-like parameters in dispc_wb_setup
  OMAPDSS: DISPC: Configure writeback specific parameters in
    dispc_wb_setup()
  OMAPDSS: DISPC: Configure writeback FIFOs
  OMAPDSS: DISPC: Add manager like functions for writeback
  OMAPDSS: DISPC: Configure color conversion coefficients for writeback

 drivers/video/omap2/dss/apply.c        |    4 +-
 drivers/video/omap2/dss/dispc.c        |  659 +++++++++++++++++++++-----------
 drivers/video/omap2/dss/dispc.h        |   35 +-
 drivers/video/omap2/dss/dispc_coefs.c  |    2 +-
 drivers/video/omap2/dss/dss.h          |   26 +-
 drivers/video/omap2/dss/dss_features.c |   57 ++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 include/video/omapdss.h                |   15 +
 8 files changed, 564 insertions(+), 235 deletions(-)

-- 
1.7.9.5

