From: y@legion.dal.design.ti.com
Subject: [PATCH 0/2] OMAP: DSS2: Framework to handle omap version specific DSS features
Date: Thu, 26 Aug 2010 18:00:26 +0530
Message-ID: <32327.5621551604$1282825768@news.gmane.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59680 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab0HZM3Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 08:29:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

This is a simple approach to prevent scattered cpu_is_omapxxxx checks
in DSS2 by bringing all omap version specific DSS features/values to one
single place, initialize them and expose a set of functions to DSS2 driver
files which return the value/existance of a feature.

This method provides the following:
  -A set of functions which give the value of a feature.
  -Functions which add and return the start and end bits of a register field
   which varies across omaps.
  -A function which checks if a DSS2 feature exists or not on the present
   omap (omap_dss_has_feature)

Whenever a new DSS feature is introduced, its value/existance is specified
for all omaps in omap_dss_feature_init().

This patch also fills up a minimal list of features in omap_dss_features_init().
The second patch in the series makes use of dss_features to remove some of the
existing omapxxxx checks.

Archit Taneja (2):
  OMAP: DSS2: Introduce dss_features files
  OMAP: DSS2: Use dss_features framework on DSS2 code

 arch/arm/plat-omap/include/plat/display.h |   31 -----
 drivers/video/omap2/dss/Makefile          |    2 +-
 drivers/video/omap2/dss/core.c            |    5 +
 drivers/video/omap2/dss/dispc.c           |   56 +++++----
 drivers/video/omap2/dss/dss_features.c    |  197 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h    |   48 +++++++
 drivers/video/omap2/dss/manager.c         |   33 +++---
 drivers/video/omap2/dss/overlay.c         |   24 ++--
 8 files changed, 308 insertions(+), 88 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dss_features.c
 create mode 100644 drivers/video/omap2/dss/dss_features.h

