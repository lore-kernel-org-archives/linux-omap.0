From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/12] OMAPDSS: use DSI PLL clk for DPI
Date: Tue, 30 Oct 2012 18:09:57 +0200
Message-ID: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52981 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab2J3QKT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

The aim of this series is to enable using DSI PLL as the pixel clock source for
DPI output. There are the following main parts:

* first 4 patches are slightly related generic improvements/fixes
* fix DSI PLL problem related to non-50% duty cycle
* fix DSI PLL problem related to powering
* changes to the clock handling to always use DSI PLL for DPI when possible

I've tested the series on OMAP4 Panda, OMAP4 SDP and OMAP3 Beagle.

 Tomi

Tomi Valkeinen (12):
  OMAPFB: remove use of extended edid block
  OMAPFB: improve mode selection from EDID
  OMAPDSS: fix DPI & DSI init order
  OMAPDSS: fix DSI2 PLL clk names
  OMAPDSS: DSI: skip odd dividers when pck >= 100MHz
  OMAPDSS: DSI: workaround for HSDiv problem
  OMAPDSS: add dss_calc_clock_rates() back
  OMAPDSS: setup default dss fck
  OMAPDSS: hide dss_select_dispc_clk_source()
  OMAPDSS: DPI: use dpi.dsidev to see whether to use dsi pll
  OMAPDSS: DPI: verify if DSI PLL is operational
  OMAPDSS: DPI: always use DSI PLL if available

 drivers/video/omap2/dss/core.c           |   12 ++--
 drivers/video/omap2/dss/dpi.c            |   99 +++++++++++++++++++++---------
 drivers/video/omap2/dss/dsi.c            |   14 ++++-
 drivers/video/omap2/dss/dss.c            |   67 +++++++++++++++++++-
 drivers/video/omap2/dss/dss.h            |    2 +-
 drivers/video/omap2/dss/hdmi.c           |    8 ---
 drivers/video/omap2/omapfb/omapfb-main.c |   16 ++---
 7 files changed, 160 insertions(+), 58 deletions(-)

-- 
1.7.10.4

