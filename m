From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAPDSS: APPLY: Misc Fixes
Date: Wed, 7 Nov 2012 14:47:21 +0530
Message-ID: <1352279844-10494-1-git-send-email-archit@ti.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2KGJRs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 04:17:48 -0500
In-Reply-To: <n>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This series resolves a few minor issues with APPLY. Tested on a 4430sdp, checked
switching overlays between DSI command mode and HDMI displays for any unexpected
behavior.

Reference tree:
git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/apply_fixes

Archit Taneja (3):
  OMAPDSS: APPLY: Don't treat an overlay's channel out as shadow bits
  OMAPDSS: APPLY: Remove unnecessary variable in dss_apply_irq_handler
  OMAPDSS: APPLY: Remove unnecessary call to mg_clear_shadow_dirty

 drivers/video/omap2/dss/apply.c |   48 +++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

-- 
1.7.9.5

