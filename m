From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/8] OMAP: DSS2: misc improvements
Date: Wed, 31 Aug 2011 16:21:40 +0300
Message-ID: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46055 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755346Ab1HaNWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:22:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some small DSS improvements, mostly HDMI related.

 Tomi

Tomi Valkeinen (8):
  OMAP: DSS2: DISPC: Fix minimum PCD value
  OMAP: DSS2: HDMI: use default dividers
  OMAP: DSS2: HDMI: change regn definition
  OMAP: DSS2: DSI: Add comment about regn
  OMAP: DSS2: DISPC: Add missing IRQ  definitions
  OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
  OMAP: DSS2: DISPC: improve dispc_mgr_enable_digit_out()
  OMAP: DSS2: HDMI: fix hdmi output enable

 arch/arm/mach-omap2/board-4430sdp.c    |    9 -----
 drivers/video/omap2/dss/dispc.c        |   63 ++++++++++++++++++++------------
 drivers/video/omap2/dss/dss.c          |   11 ++++++
 drivers/video/omap2/dss/dss.h          |    1 +
 drivers/video/omap2/dss/dss_features.c |    3 ++
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/hdmi.c         |   25 +++++++++----
 include/video/omapdss.h                |    5 +++
 8 files changed, 78 insertions(+), 40 deletions(-)

-- 
1.7.4.1

