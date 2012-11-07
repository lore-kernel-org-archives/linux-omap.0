From: Archit Taneja <archit@ti.com>
Subject: [RFC 00/11] OMAPDSS: Add writeback mem to mem mode support
Date: Wed, 7 Nov 2012 20:14:18 +0530
Message-ID: <1352299469-17609-1-git-send-email-archit@ti.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab2KGOow (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:44:52 -0500
In-Reply-To: <n>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This series adds a writeback output driver and makes changes in APPLY to get
mem to mem mode working when writeback is connected to an overlay manager.

A user of writeback is supposed to use the fuctions exported by the writeback
output driver to configure writeback and start a mem to mem transfer. The output
driver internally calls function in APPLY to configure the writeback related
DISPC registers.

An example usage of writeback in omapfb is provided as the last patch.

Reference tree:
git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/wb_mem_to_mem

Archit Taneja (11):
  OMAPDSS: Add writeback output driver
  OMAPDSS: APPLY: Add get/set info functions for writeback
  OMAPDSS: APPLY: Apply writeback configurations
  OMAPDSS: writeback: Configure writeback input size
  OMAPDSS: APPLY: Add writeback enable/disable funcs
  OMAPDSS: APPLY: configure channel_in for writeback
  OMAPDSS: writeback: add mechanism to do mem to mem updates
  OMAPDSS: APPLY: Check if overlay is connected in mem to mem mode
  OMAPDSS: FEATURES: Add writeback as supported outputs for OMAP4
    managers
  ARCH: ARM: OMAP: Create a platform device for writeback
  Example: OMAPFB: clear framebuffers using writeback

 arch/arm/mach-omap2/display.c            |    9 +
 drivers/video/omap2/dss/Kconfig          |   13 ++
 drivers/video/omap2/dss/Makefile         |    1 +
 drivers/video/omap2/dss/apply.c          |  321 ++++++++++++++++++++++++++-
 drivers/video/omap2/dss/core.c           |    6 +
 drivers/video/omap2/dss/dss.h            |   24 +++
 drivers/video/omap2/dss/dss_features.c   |    6 +-
 drivers/video/omap2/dss/writeback.c      |  345 ++++++++++++++++++++++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |  132 +++++++++++-
 include/video/omapdss.h                  |   22 ++
 10 files changed, 873 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/omap2/dss/writeback.c

-- 
1.7.9.5

