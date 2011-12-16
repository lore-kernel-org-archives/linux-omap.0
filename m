From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Fri, 16 Dec 2011 01:03:09 -0600
Message-ID: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44900 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab1LPHDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:03:44 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG73hHG005381
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:03:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

It has been detected that HDMI audio is broken in K3.2-rcX due to
the most recent updates in the DSS. This set of patches aims to repair such
break. It also improves the implementation of the ASoC codec to better follow
the DSS design by clearly separating functions that need acess to IP-
specific data.

This set of patches is based on
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.2-rc5

and is available at
git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/fix-hdmi-audio-3.2

Validation was performed on HDMI TV. Penguins were present on the display
and audio playback was performed with aplay at 32, 44.1 and 48kHz with S16_LE
and S24_LE sample formats. Validation was performed on SDP4430 ES2.2.

Ricardo Neri (4):
  ASoC: OMAP: HDMI: Introduce driver data for audio codec
  ASoC: OMAP: HDMI: Correct signature of ASoC functions
  OMAPDSS: HDMI: Create function to enable HDMI audio
  ASoC: OMAP: HDMI: Move HDMI codec trigger function to generic HDMI
    driver

 drivers/video/omap2/dss/dss_features.c    |    4 ++
 drivers/video/omap2/dss/hdmi.c            |   46 +++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi.h         |   10 +++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   37 ++++-------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    3 --
 5 files changed, 64 insertions(+), 36 deletions(-)

