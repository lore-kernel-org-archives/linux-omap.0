From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/5] OMAPDSS: HDMI audio compliance fixes
Date: Wed, 22 Apr 2015 16:22:56 +0300
Message-ID: <cover.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33280 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbbDVNXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 09:23:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

I have rebased these patches from ti-linux-3.14.y on top of Linux
4.0.0. I tested them briefly on OMAP4 and OMAP5 in my environment, but
I could not test any channel count beyond stereo. However, there were
no conflicts in the rebase and each fix makes sense when looking at
the chip TRM and the relevant HDMI specs.

All the changes are really minor, but most of them apply to OMAPDSS side,
so it is probably best to merge them trough there.

Best regards,
Jyri

Misael Lopez Cruz (5):
  OMAPDSS: HDMI4: Set correct CC for 8-channels layout
  OMAPDSS: HDMI5: Set valid sample order
  OMAPDSS: HDMI5: Fix AUDICONF3 bitfield offsets
  ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
  ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA

 drivers/video/fbdev/omap2/dss/hdmi4_core.c | 12 +++++++++++-
 drivers/video/fbdev/omap2/dss/hdmi5_core.c |  5 ++++-
 sound/soc/omap/omap-hdmi-audio.c           | 12 +++++++-----
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
1.9.1

