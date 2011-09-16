From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/3] OMAPDSS: DISPC: VIDEO3 and ZORDER support
Date: Fri, 16 Sep 2011 12:09:10 +0530
Message-ID: <1316155153-24351-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35142 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab1IPGhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 02:37:42 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8G6bgdb012741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 01:37:42 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8G6bgMj009383
	for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 01:37:42 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8G6bgMs024205
	for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 01:37:42 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: hvaibhav@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This contains support for VIDEO3 pipeline and zorder support for OMAP4 Display
controller.

This set originally had some more miscellaneous patches. Those patches have been
separated out and this set is created since it makes some trivial changes in the
omap_vout driver.

The patch set is based on Tomi's master branch. It can be tried on:

https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/dispc_misc

Tested on 4430sdp, 3430sdp.

Archit Taneja (3):
  OMAPDSS/OMAP_VOUT: Fix incorrect OMAP3-alpha compatibility setting
  OMAPDSS: DISPC: VIDEO3 pipeline support
  OMAPDSS: DISPC: zorder support for DSS overlays

 drivers/media/video/omap/omap_vout.c   |   16 +++++--
 drivers/video/omap2/dss/dispc.c        |   65 ++++++++++++++++++++------
 drivers/video/omap2/dss/dispc.h        |   57 +++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h          |    4 +-
 drivers/video/omap2/dss/dss_features.c |   40 +++++++++++-----
 drivers/video/omap2/dss/dss_features.h |    5 +-
 drivers/video/omap2/dss/manager.c      |   28 ++++++++----
 drivers/video/omap2/dss/overlay.c      |   77 ++++++++++++++++++++++++++++++++
 include/video/omapdss.h                |    9 +++-
 9 files changed, 253 insertions(+), 48 deletions(-)

