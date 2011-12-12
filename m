From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAPDSS: Miscellaneous Fixes
Date: Mon, 12 Dec 2011 11:47:40 +0530
Message-ID: <1323670663-17793-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36548 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab1LLGSY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 01:18:24 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC6INwS012851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:23 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC6INxw019063
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:23 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC6INr2011483
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:23 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

These are some minor fixes for DSS2.

Based on Tomi's master branch in:

git://gitorious.org/linux-omap-dss2/linux.git

Archit Taneja (3):
  OMAPDSS: DSI: Fix HSDIV related PLL info in dsi_dump_clocks()
  OMAPDSS: Panel NEC: Set omap_dss_device states correctly
  OMAPDSS: Displays: Make PICODLP driver depend on DPI

 drivers/video/omap2/displays/Kconfig               |    2 +-
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   61 +++++++++++++++++---
 drivers/video/omap2/dss/dsi.c                      |   14 +++--
 3 files changed, 61 insertions(+), 16 deletions(-)

-- 
1.7.4.1

