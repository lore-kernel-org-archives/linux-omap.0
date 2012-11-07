From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAPDSS: DISPC: Writeback fixes
Date: Wed, 7 Nov 2012 11:45:01 +0530
Message-ID: <1352268905-31093-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51698 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2KGGP1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 01:15:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Some issues were found in the DISPC driver when performing scaling with
writeback pipeline. This series fixes those issues.

Reference tree:
git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/writeback_fixes_dispc

Archit Taneja (3):
  OMAPDSS: DISPC: Fix calc_scaling_44xx() bugs for writeback pipeline
  OMAPDSS: DISPC: Don't allow predecimation for writeback
  OMAPDSS: DISPC: Use output width and height to calculate row/pix inc
    for writeback

 drivers/video/omap2/dss/dispc.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
1.7.9.5

