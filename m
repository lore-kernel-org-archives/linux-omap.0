From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] OMAPDSS: DSI related improvements
Date: Mon, 22 Aug 2011 11:26:35 +0300
Message-ID: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:32918 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088Ab1HVI04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

These patches add support for the second DSI module on OMAP4 by fixing the DSI device naming and adding necessary powers. Also DSI pad muxing is improved to support OMAP4.

 Tomi

Tomi Valkeinen (4):
  OMAP: DSS2: Change DSI device naming
  OMAP4: TWL: Add common omapdss supplies
  OMAP: DSS2: DSI: Improve dsi_mux_pads parameters
  OMAP: DSS2: Implement dsi_mux_pads for OMAP4

 arch/arm/mach-omap2/board-devkit8000.c   |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/display.c            |   60 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/twl-common.c         |   11 ++++-
 drivers/video/omap2/dss/dsi.c            |   67 ++++++++++++++++++-----------
 include/video/omapdss.h                  |    3 +-
 6 files changed, 112 insertions(+), 33 deletions(-)

-- 
1.7.4.1

