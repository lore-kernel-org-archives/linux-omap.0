From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAPDSS: Miscellaneous DISPC Fixes
Date: Tue, 21 Feb 2012 19:36:29 +0530
Message-ID: <1329833192-16529-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51416 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428Ab2BUOGq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:06:46 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1LE6kWB000395
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:46 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1LE6kRA025457
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:46 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: lajos@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

These are some minor Display Controller fixes.

Tested on 4430sdp and 3430sdp on the tree:

git://gitorious.org/linux-omap-dss2/linux.git dev

Lajos Molnar (3):
  OMAPDSS: DISPC: Fix OMAP4 supported color formats
  OMAPDSS: DISPC: Fix FIR coefficients
  OMAPDSS: DSS: Add runtime_pm protection around wait_for_vsync.

 drivers/video/omap2/dss/dispc.c        |   24 +++++++++++++++---------
 drivers/video/omap2/dss/dispc_coefs.c  |    9 ++++-----
 drivers/video/omap2/dss/dss_features.c |    3 ++-
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
1.7.5.4

