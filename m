From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/3] Updated names for ASoC OMAP HDMI drivers
Date: Tue, 13 Nov 2012 20:30:46 -0600
Message-ID: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50872 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470Ab2KNCbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 21:31:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Hi Mark, Liam,

Now that the OMAPDSS HDMI driver will create the platform device for HDMI audio
[1], the ASoC drivers need to be updated as well. Also, I took the opportunity
to give the drivers more meaningful and descriptive names.

The last patch in the series makes the CPU DAI driver look cleaner by obtaining
its resources from the platform device and not from hard-coded value inside
the driver.

Also, I still have pending a couple of patches to update the platform device
creation. I wanted to submit these patches first in case there are comments
about the naming I propose.

BR,

Ricardo

[1]. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79795.html

Ricardo Neri (3):
  ASoC: OMAP: HDMI: Update machine driver name
  ASoC: OMAP: HDMI: Update CPU DAI driver name
  ASoC: OMAP: HDMI: Obtain DMA port from resources

 sound/soc/omap/omap-hdmi-card.c |    4 ++--
 sound/soc/omap/omap-hdmi.c      |    5 ++---
 sound/soc/omap/omap-hdmi.h      |    2 --
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
1.7.5.4

