From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM/ASoC: OMAP: McBSP config cleanup
Date: Fri,  9 Mar 2012 10:51:16 +0200
Message-ID: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:44460 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753730Ab2CIIvc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 03:51:32 -0500
Received: by lbbgn12 with SMTP id gn12so255265lbb.10
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 00:51:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Hi,

Since the McBSP driver has been moved out from arch/arm/plat-omap/ and it is
combined as a single driver with the sound/soc/omap/omap-mcbsp.c there is no
longer need to have CONFIG_OMAP_MCBSP.
This series cleans up the Kconfigs, and Makefiles.
Also it is fixes the issue that the OMAP audio drivers were not buildable as
modules (the ones using McBSP) reported by Grazvydas Ignotas <notasas@gmail.com>

I have generated this series on top of Liam's for-3.4 branch. The
arch/arm/mach-omap* patch applies cleanly on top of todays linux-next, so if
this series goes via ASoC we are not going to have conflicts with stuff coming
via l-o.

Tested on BeagleBoard, and SDP4430, compile tested for OMAP1.

This series should go via ASoC along with the rest of the McBSP changes.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
  ASoC: OMAP: Build config cleanup for McBSP

 arch/arm/mach-omap1/Kconfig  |    3 ---
 arch/arm/mach-omap1/Makefile |    4 +++-
 arch/arm/mach-omap2/Makefile |    4 +++-
 sound/soc/omap/Kconfig       |    6 ------
 sound/soc/omap/Makefile      |    3 +--
 5 files changed, 7 insertions(+), 13 deletions(-)

-- 
1.7.8.5

