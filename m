From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/5] OMAP: DSS2: Video3 pipeline support for OMAP4
Date: Mon, 19 Jul 2010 17:25:39 +0530
Message-ID: <1279540544-12682-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621Ab0GSLzy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 07:55:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

This patch incorporates the Video3 pipeline of OMAP4 in the exisiting
DSS2 framework. It introduces the Video3 pipeline registers and adds
a new overlay object to support this pipeline.

Apart from this, bit field changes have been introduced for all
video pipeline registers on OMAP4. In particular, changes for
VID_ACCUi, VID_BUF_THRESHOLD and VID_BUF_SIZE_STATUS have been
introduced.

Sumit Semwal (4):
  OMAP: DSS2: Add Video3 pipeline in display.h
  OMAP: DSS2: Add Video3 pipeline functionality in DISPC
  OMAP: DSS2: Add new overlay object for Video3 pipeline
  OMAP: DSS2: Video3 pipeline IRQs

Mayuresh Janorkar (1):
  OMAP: DSS2: Context Save and Restore of Video3 pipeline registers
---
 arch/arm/plat-omap/include/plat/display.h |    7 +-
 drivers/video/omap2/dss/dispc.c           |  299 ++++++++++++++++++++++++++---
 drivers/video/omap2/dss/manager.c         |   13 +-
 drivers/video/omap2/dss/overlay.c         |   18 ++-
 4 files changed, 302 insertions(+), 35 deletions(-)
