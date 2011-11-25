From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/5] Support for OMAP4 Digital Microphone interface
Date: Fri, 25 Nov 2011 14:20:31 +0200
Message-ID: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38076 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755099Ab1KYMVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 07:21:09 -0500
Received: by mail-bw0-f51.google.com with SMTP id t8so3688346bka.38
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 04:21:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hello,

The following series will add support for OMAP4 DMIC interface, and enable them
on sdp4430/Blaze boards.

Changes since v2:
- Use module_platform_driver
- convert to use devm_
- Add clk_id for the output clock
- Extend the comment to explain why the driven can change the divider for 192KHz
  sampling rate.

Changes since v1:
- 192KHz rate support fixed (need to use different divider)
- Hold reference for dmic_fclk over the lifetime of the driver
- Removed the clkdiv callback, and replaced with frequency based configuration
  for the external components (dmic frequency)

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
 sound/soc/omap/omap-dmic.c                 |  511 ++++++++++++++++++++++++++++
 sound/soc/omap/omap-dmic.h                 |   69 ++++
 sound/soc/omap/sdp4430.c                   |   85 ++++-
 8 files changed, 691 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h

-- 
1.7.8.rc3

