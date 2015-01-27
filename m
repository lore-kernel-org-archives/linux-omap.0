From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/14] OMAPDSS: Add TI DRA7xx support
Date: Tue, 27 Jan 2015 12:50:28 +0200
Message-ID: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60755 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361AbbA0Ku4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:50:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds DSS support for Texas Instrument's DRA7xx SoCs. The DSS on
DRA7xx is very much like OMAP5's DSS. The main differences are in the
integration of the DSS.

There are three main differences to OMAP5:
* DRA7xx has one (DRA72x) or two (DRA74x) video PLLs, which are almost like
  OMAP5's DSI PLLs, except integrated slightly differently.
* DRA7xx supports 3 DPI outputs, instead of 1 DPI output.
* need to set various bits in CONTROL module, which is handled via syscon

This series only adds the support to DSS driver. arch/arm/ changes are not yet
finalized. The main issue there is the missing support for DSS_DESHDCP clock,
which probably needs to be handled via regmap.

My plan is to merge the driver side changes first for 3.20, and the arch/arm/
changes for 3.21 (if solutions to the issues have been found). This will also
make the merging easier, as there won't be a merge-window cross dependency
between arm and fbdev trees.

These patches, and the additional arch/arm/ patches needed to get DSS working
on DRA7xx, can be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dra7-dss

 Tomi

Tomi Valkeinen (14):
  OMAPDSS: Add enum dss_pll_id
  OMAPDSS: PLL: add dss_pll_wait_reset_done()
  OMAPDSS: constify port arrays
  OMAPDSS: OMAP5: fix digit output's allowed mgrs
  OMAPDSS: encoder-tpd12s015: Fix race issue with LS_OE
  OMAPDSS: add define for DRA7xx HW version
  Doc/DT: Add DT binding doc for DRA7xx DSS
  OMAPDSS: DSS: Add DRA7xx base support
  OMAPDSS: Add functions for external control of PLL
  OMAPDSS: Add Video PLLs for DRA7xx
  OMAPDSS: DISPC: Add DRA7xx support
  OMAPDSS: DISPC: program dispc polarities to control module
  OMAPDSS: HDMI: Add DRA7xx support
  OMAPDSS: DPI: DRA7xx support

 .../devicetree/bindings/video/ti,dra7-dss.txt      |  69 +++++++
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  57 +-----
 drivers/video/fbdev/omap2/dss/Makefile             |   2 +-
 drivers/video/fbdev/omap2/dss/dispc.c              |  54 +++++
 drivers/video/fbdev/omap2/dss/dpi.c                |  26 +++
 drivers/video/fbdev/omap2/dss/dsi.c                |   1 +
 drivers/video/fbdev/omap2/dss/dss.c                | 219 ++++++++++++++++++++-
 drivers/video/fbdev/omap2/dss/dss.h                |  22 +++
 drivers/video/fbdev/omap2/dss/dss_features.c       |   3 +-
 drivers/video/fbdev/omap2/dss/hdmi5.c              |   1 +
 drivers/video/fbdev/omap2/dss/hdmi_phy.c           |   1 +
 drivers/video/fbdev/omap2/dss/hdmi_pll.c           |   6 +
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c  |   1 +
 drivers/video/fbdev/omap2/dss/pll.c                |  10 +
 drivers/video/fbdev/omap2/dss/video-pll.c          | 211 ++++++++++++++++++++
 include/video/omapdss.h                            |   1 +
 16 files changed, 627 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/ti,dra7-dss.txt
 create mode 100644 drivers/video/fbdev/omap2/dss/video-pll.c

-- 
2.2.2

