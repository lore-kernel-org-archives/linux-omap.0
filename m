From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/5] Support for OMAP4 Digital Microphone interface
Date: Mon, 28 Nov 2011 15:45:38 +0200
Message-ID: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:36506 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab1K1NqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 08:46:03 -0500
Received: by mail-fx0-f43.google.com with SMTP id n18so1069737fag.2
        for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 05:46:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hello,

The following series will add support for OMAP4 DMIC interface, and enable them
on sdp4430/Blaze boards.

Changes since v3:
- dmic clk divider selection moved to hw_params phase to allow fixed rate
  configuration from machine driver init.

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
 sound/soc/omap/omap-dmic.c                 |  549 ++++++++++++++++++++++++++++
 sound/soc/omap/omap-dmic.h                 |   69 ++++
 sound/soc/omap/sdp4430.c                   |   85 ++++-
 8 files changed, 729 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h

-- 
1.7.8.rc3

