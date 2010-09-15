From: "archit@ti.com" <archit@ti.com>
Subject: [PATCH v4 0/2] OMAP: DSS2: Framework to handle omap version specific DSS features
Date: Wed, 15 Sep 2010 19:39:52 +0530
Message-ID: <1284559794-4771-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab0IOOIL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 10:08:11 -0400
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
 drivers/video/omap2/dss/core.c            |    3 +
 drivers/video/omap2/dss/dispc.c           |   56 +++++----
 drivers/video/omap2/dss/dss_features.c    |  191 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h    |   50 ++++++++
 drivers/video/omap2/dss/manager.c         |   33 +++---
 drivers/video/omap2/dss/overlay.c         |   24 ++--
 8 files changed, 302 insertions(+), 88 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dss_features.c
 create mode 100644 drivers/video/omap2/dss/dss_features.h
--
Version 4:
 - all dss_features members are made const, better naming of some
   vaiables
Version 3:
 - Naming of register fields enums is changed, dss_features struct
   has some members changed as pointers to static arrays.
Version 2:
 - Features are initialized statically as opposed to runtime before,
   function naming for dss_features files has changed.
Version 1:
https://patchwork.kernel.org/patch/134431/
