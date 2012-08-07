From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 0/6] OMAPDSS: Remove cpu_is checks
Date: Tue, 7 Aug 2012 13:57:12 +0530
Message-ID: <cover.1343912532.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2HGI30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 04:29:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, tony@atomide.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
the patch series aims at cleaning up of DSS of cpu_is checks thereby making it
more generic.

The 1st patch cleans up cpu_is checks from DISPC code.
The 2nd patch removes unused functions from DSS code.
The 3rd patch cleans up cpu_is checks from DSS code.
The 4th patch removes cpu_is checks from VENC code.
The 5th patch disables VENC support on OMAP4.
The 6th patch removes cpu_is checks from DPI code and replaces it with a
dss feature.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (6):
  OMAPDSS: DISPC: Remove cpu_is_xxxx checks
  OMAPDSS: DSS: Remove redundant functions
  OMAPDSS: DSS: Remove cpu_is_xxxx checks
  OMAPDSS: VENC: Remove cpu_is_xxxx checks
  ARM: OMAP: Disable venc for OMAP4
  OMAPDSS: DPI: Remove cpu_is_xxxx checks

 arch/arm/mach-omap2/display.c          |    1 -
 drivers/video/omap2/dss/dispc.c        |  386 +++++++++++++++++++-------------
 drivers/video/omap2/dss/dpi.c          |   12 +-
 drivers/video/omap2/dss/dss.c          |  155 +++++++------
 drivers/video/omap2/dss/dss.h          |   73 +++++-
 drivers/video/omap2/dss/dss_features.c |   83 +++++++
 drivers/video/omap2/dss/dss_features.h |    4 +
 drivers/video/omap2/dss/venc.c         |   11 -
 8 files changed, 465 insertions(+), 260 deletions(-)

-- 
1.7.10

