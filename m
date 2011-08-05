From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/5] OMAP: DSS2: Miscellaneous DISPC Patches
Date: Fri, 5 Aug 2011 13:12:47 +0530
Message-ID: <1312530172-24095-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab1HEHeN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 03:34:13 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p757YDQt025793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p757YD4V011115
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:13 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p757YDc2026851
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:13 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Reduce the size of the large functions dispc_dump_regs(), dispc_save_context()
and dispc_restore_context() and _dispc_setup_color_conv_coef().

Add support for VIDEO3 pipeline on OMAP4.

Applies over master branch of:

git://gitorious.org/linux-omap-dss2/linux.git

Archit Taneja (5):
  OMAP: DSS2: DISPC: Prepare dispc_dump_regs() for shortening
  OMAP: DSS2: DISPC: Shorten dispc_dump_regs()
  OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context()
    cleanup
  OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
  OMAP4: DSS2: VIDEO3 pipeline support

 drivers/video/omap2/dss/dispc.c        |  819 ++++++++++++--------------------
 drivers/video/omap2/dss/dispc.h        |   57 +++
 drivers/video/omap2/dss/dss_features.c |   14 +-
 drivers/video/omap2/dss/dss_features.h |    2 +-
 drivers/video/omap2/dss/overlay.c      |    7 +
 include/video/omapdss.h                |    5 +-
 6 files changed, 375 insertions(+), 529 deletions(-)

