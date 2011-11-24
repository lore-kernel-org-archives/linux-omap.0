From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/5] Support for OMAP4 Digital Microphone interface
Date: Thu, 24 Nov 2011 15:54:44 +0200
Message-ID: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47311 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab1KXNzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:55:06 -0500
Received: by mail-bw0-f50.google.com with SMTP id zu17so2932957bkb.37
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 05:55:04 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hello,

The following series will add support for OMAP4 DMIC interface, and enable them
on sdp4430/Blaze boards.

Changes since v1:
- 192KHz rate support fixed (need to use different divider)
- Hold reference for dmic_fclk over the lifetime of the driver
- Removed the clkdiv callback, and replaced with frequency based configuration
  for the external components (dmic frequency)

Mark: the pm_runtime_get/put_sync can not be used in atomic context since they
can sleep so I can not move the clock enable to pcm_trigger.

Regards,
Peter
---
Peter Ujfalusi (5):
  OMAP4: hwmod: Add names for DMIC memory address space
  ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
  OMAP4: devices: Register OMAP4 DMIC platform device
  OMAP4: board-4430sdp: Register platform device for digimic codec
  ASoC: sdp4430: Add support for digital microphones

 arch/arm/mach-omap2/board-4430sdp.c        |    6 +
 arch/arm/mach-omap2/devices.c              |   22 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +
 sound/soc/omap/Kconfig                     |    5 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/omap-dmic.c                 |  509 ++++++++++++++++++++++++++++
 sound/soc/omap/omap-dmic.h                 |   73 ++++
 sound/soc/omap/sdp4430.c                   |   84 ++++-
 8 files changed, 692 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h

-- 
1.7.8.rc3

