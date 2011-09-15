From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAP: DSS: display support for 4430SDP
Date: Thu, 15 Sep 2011 10:17:32 +0300
Message-ID: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34127 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754316Ab1IOHRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 03:17:47 -0400
Received: by mail-bw0-f54.google.com with SMTP id zs8so2648565bkb.41
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 00:17:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

These patches add support for the LCD and PicoDLP outputs for 4430SDP board.

 Tomi

Tomi Valkeinen (3):
  OMAP: DSS2: Taal: remove external backlight support
  OMAP4: 4430SDP: Add panel support to board file
  OMAP4: 4430SDP: Add picodlp support to board file

 arch/arm/mach-omap2/board-4430sdp.c       |  193 +++++++++++++++++++++++++++--
 drivers/video/omap2/displays/panel-taal.c |   76 +++++-------
 include/video/omap-panel-nokia-dsi.h      |    8 +-
 3 files changed, 212 insertions(+), 65 deletions(-)

-- 
1.7.4.1

