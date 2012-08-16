From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/6] OMAPDSS: Pass output specific parameters from panel driver to output
Date: Thu, 16 Aug 2012 13:06:28 +0530
Message-ID: <1345102594-6222-1-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49492 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab2HPHiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 03:38:06 -0400
In-Reply-To: <343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

This is a continuation of the series below:

http://marc.info/?l=linux-omap&m=134381744304672&w=2

This series tries to pass output specific parameters from panel driver to the
connected output. These are basically parameters which can't really be shared
across different outputs. An attempt has been made to have similar looking
functions for setting DSI videomode timings and RFBI timings. But all the other
parameters in the series take output specific arguments.

After this series, the interface drivers look more independent of
omap_dss_device. It'll now be easier to add outputs as another DSS entity, and
pass them rather than passing omap_dss_device from panel drivers to
output/interface drivers.

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git pass_output_specific

Tested on 4430SDP and 3430SDP

Archit Taneja (6):
  OMAPDSS: DSI: Maintain copy of operation mode in driver data
  OMAPDSS: DSI: Rename dsi_videomode_data to dsi_videomode_timings
  OMAPDSS: DSI: Maintain copy of video mode timings in driver data
  OMAPDSS: RFBI: Maitain copy of rfbi timings in driver data
  OMAPDSS: VENC: Maintain copy of venc type in driver data
  OMAPDSS: VENC: Maintian copy of video output polarity in private data

 drivers/video/omap2/displays/panel-n8x0.c |    2 +
 drivers/video/omap2/displays/panel-taal.c |    1 +
 drivers/video/omap2/dss/dsi.c             |   94 ++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h             |    4 ++
 drivers/video/omap2/dss/rfbi.c            |   14 ++++-
 drivers/video/omap2/dss/venc.c            |   28 ++++++++-
 drivers/video/omap2/dss/venc_panel.c      |    8 +++
 include/video/omapdss.h                   |   10 ++-
 8 files changed, 126 insertions(+), 35 deletions(-)

-- 
1.7.9.5

