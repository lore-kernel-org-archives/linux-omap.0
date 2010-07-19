From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAP: DSS2: Add Zorder Support on OMAP4
Date: Mon, 19 Jul 2010 17:40:04 +0530
Message-ID: <1279541407-17711-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47247 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760638Ab0GSMKO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 08:10:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

This patch series adds Zorder Support on OMAP4, this feature
allows deciding the visibility order of the overlays based on
the Zorder value given to a sysfs attribute of the overlay object.

Since this feature is not supported on OMAP3 and OMAP2, the sysfs
attibutes always return Zorder as 0 and do not write to dispc registers
for non OMAP4 architectures.

This patch series applies over the submitted series:

https://patchwork.kernel.org/patch/112648/

Sumit Semwal (3):
  OMAP: DSS2: Zorder enum in display.h
  OMAP: DSS2: Zorder functions for DISPC
  OMAP: DSS2: Zorder sysfs attributes, out of bound checks and initialization
---
 arch/arm/plat-omap/include/plat/display.h |    8 ++++
 drivers/video/omap2/dss/dispc.c           |   23 +++++++++++++
 drivers/video/omap2/dss/dss.h             |    3 ++
 drivers/video/omap2/dss/manager.c         |    4 ++
 drivers/video/omap2/dss/overlay.c         |   51 +++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 0 deletions(-)
