From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAP: DSS2: Generalize DSS clock source names
Date: Mon, 28 Feb 2011 12:20:34 +0530
Message-ID: <1298875837-6305-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51582 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1B1GsA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:48:00 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6lx4N021029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:47:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The OMAP Display Subsystem has multiple clock sources available for its
modules. One of these sources has to be selected through a global control
register called DSS_CTRL.

For example, on OMAP4, the Display Controller Module's (DISPC) functional
clock can be derived from:
a) output of DPLL_PER's M5 divisor
b) output of DSI1 PLL's M4 divisor
c) output of DSI2 PLL's M4 divisor
d) output of HDMI PLL

There is, hence, an enum called 'dss_clk_source' which is used throughout
DSS2, to select clock sources for various DSS sub modules. These clock
source names are currently specific to OMAP2/3 TRM clock names.

All enum members, variables, functions which are based on these clock
source names have been made generic such that they can be used for future
OMAPs as well.

Archit Taneja (3):
  OMAP2PLUS: DSS2: Make members of dss_clk_source generic
  OMAP2PLUS: DSS2: Use dss features to get clock source names of
    current OMAP
  OMAP2PLUS: DSS2: DSI: Generalize DSI PLL Clock Naming

 arch/arm/plat-omap/include/plat/display.h |    4 +-
 drivers/video/omap2/dss/dispc.c           |   11 +-
 drivers/video/omap2/dss/dpi.c             |    8 +-
 drivers/video/omap2/dss/dsi.c             |  178 ++++++++++++++++-------------
 drivers/video/omap2/dss/dss.c             |   43 +++++---
 drivers/video/omap2/dss/dss.h             |   33 ++++--
 drivers/video/omap2/dss/dss_features.c    |   23 ++++
 drivers/video/omap2/dss/dss_features.h    |    1 +
 8 files changed, 185 insertions(+), 116 deletions(-)

