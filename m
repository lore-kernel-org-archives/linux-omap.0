From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/10] OMAP4: ASoC: Support for PandaBoard family
Date: Wed, 14 Dec 2011 11:46:53 +0200
Message-ID: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54459 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab1LNJtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:05 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id i14so217320lam.6
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hello,

the following series will add ASoC support for PandaBoards.
PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
the differences not that big to justify a new ASoC machine driver.

Main changes:
- Rename the sdp4430 ASoC machine driver to use generic name: omap-abe-twl6040
- Convert the ASoC machine driver to platform driver
- The type of the board, and the desired sound card name is passed via platform
  data to the ASoC machine driver
- Based on the board type the driver selects different audio routings
- Registration of the needed platform devices in board files (sdp4403, panda)

After this series the sound card names will be different for easier UCM
integration:
"OMAP4-SDP4430" for SDP4430/Blaze boards
"OMAP4-Panda" for PandaBoard 4430
"OMAP4-PandaES" for PandaBoard ES (4460)

The series has been tested on Blaze, and PandaBoard ES.

Regards,
Peter
---
Peter Ujfalusi (10):
  ASoC: sdp4430: Correct author e-mail address
  ASoC: OMAP4: Rename the sdp4430 machine driver
  ASoC: omap-abe-twl6040: Correct internal prefix, Kconfig entry
  include: platform_data: Platform data header for OMAP4 ASoC audio
  OMAP4: 4430sdp: Register platform device for OMAP4 audio
  ASoC: omap-abe-twl6040: Convert to platform deriver
  ASoC: omap-abe-twl6040: Add support for PandaBoard
  OMAP4: omap4panda: Enable audio support
  ASoC: omap-abe-twl6040: Add missing audio route information
  ASoC: omap-abe-twl6040: Fix DAPM widget type for FM input

 arch/arm/mach-omap2/board-4430sdp.c              |   15 ++
 arch/arm/mach-omap2/board-omap4panda.c           |   48 +++++-
 include/linux/platform_data/omap-abe-twl6040.h   |   33 ++++
 sound/soc/omap/Kconfig                           |   14 +-
 sound/soc/omap/Makefile                          |    4 +-
 sound/soc/omap/{sdp4430.c => omap-abe-twl6040.c} |  198 ++++++++++++++++------
 6 files changed, 251 insertions(+), 61 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h
 rename sound/soc/omap/{sdp4430.c => omap-abe-twl6040.c} (52%)

-- 
1.7.8

