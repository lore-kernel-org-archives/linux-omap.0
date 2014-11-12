From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/22] OMAPDSS: Create a DSS PLL library
Date: Wed, 12 Nov 2014 13:52:02 +0200
Message-ID: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41979 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaKLLwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 06:52:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

OMAP DSS hardware contains two different PLLs at the moment: DSI and HDMI PLLs.
With the DRA7x we will have a new PLL, video PLL. The code for DSI and HDMI
PLLs are totally separate, with no shared code.

This series cleans up the PLL code for DSI and HDMI, and creates a common
framework for DSS PLLs, which will also be used by the video PLLs.

The first half of the patches clean up and rework DSI PLL code to make it more
suitable with the common PLL code. We then add the common PLL library, and make
DSI use that.

The second half does the same for HDMI.

There should be no changes visible to the user, although the exact settings for
the PLLs may be slightly different from what we currently end up programming in
to the registers.

Tested on OMAP3/4/5 boards.

This series is based on Archit's "OMAPDSS: Support multiple DPI instances"
series. I have pushed these to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/pll-library

 Tomi

Tomi Valkeinen (22):
  OMAPDSS: DSI: wait for hsdiv clocks when enabling PLL
  OMAPDSS: DSI: remove unused hsdiv wait funcs
  OMAPDSS: DSI: always power on hsclk & hsdiv
  OMAPDSS: DSI: separate LP clock info from dsi_clock_info
  OMAPDSS: DSI: remove clkin from dsi_clock_info
  OMAPDSS: DSI: remove pll_locked field
  OMAPDSS: DSI: use struct copy instead of individual field copy
  OMAPDSS: DSI: rename clkin4ddr to clkdco
  OMAPDSS: DSI: turn hsdivs fields to arrays
  OMAPDSS: DSI: features: combine dsi & dispc hsdivs
  OMAPDSS: DSI: dsi_runtime_get/put in pll_init
  OMAPDSS: Add common PLL code
  OMAPDSS: DSI: use common DSS PLL support
  OMAPDSS: HDMI: fix setting REFSEL
  OMAPDSS: HDMI5: disable interlace modes
  OMAPDSS: HDMI: rewrite HDMI PLL calculation code
  OMAPDSS: HDMI: Remove HDMI PLL reset
  OMAPDSS: HDMI: store WP pointer to hdmi_pll_data
  OMAPDSS: HDMI: split PLL enable & config
  OMAPDSS: HDMI: remove extra poweroff
  OMAPDSS: HDMI: use common DSS PLL support
  OMAPDSS: features: remove unused DSI PLL features

 drivers/video/fbdev/omap2/dss/Makefile       |   2 +-
 drivers/video/fbdev/omap2/dss/dispc.c        |  20 +-
 drivers/video/fbdev/omap2/dss/dpi.c          | 106 ++---
 drivers/video/fbdev/omap2/dss/dsi.c          | 659 ++++++++++-----------------
 drivers/video/fbdev/omap2/dss/dss.c          |  15 -
 drivers/video/fbdev/omap2/dss/dss.h          | 193 ++++----
 drivers/video/fbdev/omap2/dss/dss_features.c |  42 --
 drivers/video/fbdev/omap2/dss/dss_features.h |  12 -
 drivers/video/fbdev/omap2/dss/hdmi.h         |  34 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c        |  68 ++-
 drivers/video/fbdev/omap2/dss/hdmi5.c        |  73 ++-
 drivers/video/fbdev/omap2/dss/hdmi_phy.c     |  31 +-
 drivers/video/fbdev/omap2/dss/hdmi_pll.c     | 313 ++++++-------
 drivers/video/fbdev/omap2/dss/pll.c          | 378 +++++++++++++++
 14 files changed, 979 insertions(+), 967 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/pll.c

-- 
2.1.3

