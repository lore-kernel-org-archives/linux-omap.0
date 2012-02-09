From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/3] OMAPDSS: HDMI: Add support for audio MCLK
Date: Wed, 8 Feb 2012 21:10:20 -0600
Message-ID: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42880 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757542Ab2BIDLA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 22:11:00 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q193B0DS005355
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q193B0Iq020224
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hello,

Certain OMAP4 revisions (i.e., 4430 ES2.3, 4460, and 4470) use
a pseudo clock (generated from the TMDS clock), MCLK, to drive the
generation of Audio Clock Regeneration packets. Other devices
(i.e., 4430 ES2.[0,2]) use the TMDS clock directly. 

This set of patches introduces functionality to enable the MCLK on the
relevant devices. Such clock is added as new DSS feature. The dss_features
structures are rearranged to reflect the MCLK support across several
silicon revisions.

These patches have been validated on OMAP 4430 ES2.2 and ES2.3 as well as
on 4460 ES1.0. The HDMI sinks used for validation are monitor Dell ST2210b,
AV receiver Onkyo TX-SR508 and AV receiver Yamaha RX-V367. Audio playback
is functional in all of them.

These patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.3-rc2

Ricardo Neri (3):
  OMAPDSS: Add DSS feature for HDMI MCLK for audio
  OMAPDSS: HDMI: Implement initialization of MCLK
  OMAPDSS: HDMI: Modify logic to configure MCLK

 drivers/video/omap2/dss/dss_features.c    |   31 +++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.h    |    1 +
 drivers/video/omap2/dss/hdmi.c            |    6 +++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   37 +++++++++++++++++-----------
 4 files changed, 57 insertions(+), 18 deletions(-)

