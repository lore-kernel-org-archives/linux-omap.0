From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/8] OMAPDSS: Misc improvements
Date: Thu, 23 Aug 2012 16:45:06 +0300
Message-ID: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:58775 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758852Ab2HWNpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:33 -0400
Received: by lagy9 with SMTP id y9so447014lag.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series contains miscellaneous improvements for omapdss, which I've made
while implementing device tree support for omapdss. This includes some changes
to arch/arm/:

* remove OMAP4 HDMI gpio handling from board files
* add vdda_hdmi_dac supply for HDMI to twl-common.c
* remove DSS clock dividers from 4430sdp board file

Tony, omapdss has dependencies to those changes, and the first change also has
a dependency to omapdss header file. Is it ok to merge them with other omapdss
changes?

Chances for conflict are probably pretty small, 1st and 3rd change are
pure display stuff, and the 2nd adds the supply to a regulator not used by
anyone else than DSS.

 Tomi

Tomi Valkeinen (8):
  OMAPDSS: HDMI: Move GPIO handling to HDMI driver
  OMAPDSS: HDMI: Add delay to wait for 5V power
  OMAP4: TWL: add vdda_hdmi_dac regulator supply
  OMAPDSS: HDMI: use vdda_hdmi_dac
  OMAPDSS: Add DSI fclk maximum to dss_features
  OMAPDSS: DSI: calculate dsi clock
  OMAP: 4430SDP: remove DSI clock config from board file
  OMAPDSS: fix use of dssdev->caps

 arch/arm/mach-omap2/board-4430sdp.c       |   73 +---------------
 arch/arm/mach-omap2/board-omap4panda.c    |   27 +-----
 arch/arm/mach-omap2/twl-common.c          |    6 ++
 drivers/video/omap2/displays/panel-n8x0.c |    1 +
 drivers/video/omap2/displays/panel-taal.c |    8 ++
 drivers/video/omap2/dss/dsi.c             |  131 +++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss_features.c    |    2 +
 drivers/video/omap2/dss/dss_features.h    |    1 +
 drivers/video/omap2/dss/hdmi.c            |  101 +++++++++++++++++-----
 drivers/video/omap2/dss/rfbi.c            |    1 -
 include/video/omapdss.h                   |    4 +
 11 files changed, 233 insertions(+), 122 deletions(-)

-- 
1.7.9.5

