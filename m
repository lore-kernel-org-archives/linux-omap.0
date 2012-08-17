From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAPDSS: Miscellaneous cleanup patches
Date: Fri, 17 Aug 2012 16:19:08 +0530
Message-ID: <1345200551-28712-1-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756708Ab2HQKuo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 06:50:44 -0400
In-Reply-To: <343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

These are minor cleanup patches which will be useful for the future series on
outputs. It's harder to add output entities in DSS when there are more
omap_dss_device references in the driver. The first 2 reduces that a bit. The
third patch just removes some left over fields from omap_dss_device

Refenence Tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 1-misc-clean-for-outputs

Archit Taneja (3):
  OMAPDSS: DSI: Pass dsi platform device wherever possible
  OMAPDSS: APPLY: Remove omap_dss_device references in wait_for_go
    functions
  OMAPDSS: Remove unnecessary acb/acbi pin fields from omap_dss_device

 drivers/video/omap2/dss/apply.c |   32 +++++++++-----
 drivers/video/omap2/dss/dsi.c   |   89 +++++++++++++++++----------------------
 include/video/omapdss.h         |    4 --
 3 files changed, 60 insertions(+), 65 deletions(-)

-- 
1.7.9.5

