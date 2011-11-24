From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/13] OMAPDSS: DSI fixes
Date: Thu, 24 Nov 2011 15:29:28 +0200
Message-ID: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47258 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753878Ab1KXN3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:29:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

First a few patches to flush posted writes, and then DSI patches related to the
DSI lane handling. I'm not sure if the lane handling is still as clean as it
could be, but at least it feels cleaner than currently.

Tested entering ULPS on display disable on blaze tablet, and it seems to work.
However, I have no way to ensure that ULPS was actually entered, as I would
need a scope for that.

 Tomi

Tomi Valkeinen (13):
  OMAPDSS: DSI: flush posted write when entering ULPS
  OMAPDSS: DSI: flush posted write in send_bta
  OMAPDSS: DISPC: Flush posted writes when enabling outputs
  OMAPDSS: DSI: count with number of lanes
  OMAPDSS: DSI: Parse lane config
  OMAPDSS: DSI: Use new lane config in dsi_set_lane_config
  OMAPDSS: DSI: use lane config in dsi_get_lane_mask
  OMAPDSS: DSI: use lane config in dsi_cio_wait_tx_clk_esc_reset
  OMAPDSS: DSI: use lane config in dsi_cio_enable_lane_override
  OMAPDSS: DSI: remove dsi_get_num_lanes_used
  OMAPDSS: DSI: fix lane handling when entering ULPS
  OMAPDSS: DSI: improve wait_for_bit_change
  OMAPDSS: DSI: disable DDR_CLK_ALWAYS_ON when entering ULPS

 drivers/video/omap2/dss/dispc.c |   10 +-
 drivers/video/omap2/dss/dsi.c   |  429 +++++++++++++++++++++------------------
 2 files changed, 242 insertions(+), 197 deletions(-)

-- 
1.7.4.1

