From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 0/8] RX-51 audio drivers
Date: Thu,  8 Oct 2009 14:58:49 +0300
Message-ID: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45197 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659AbZJHMBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello everyone,

Here is a patch series with most of audio support for RX51.

Basically it includes asoc machine driver for rx51, tpa6130a2 amplifier
driver (asoc version), board file configuration and setup and the
sidetone feature of mcbsp.

On top of that, there are few patches to use regulator framework
to control vmmc2.

This series is based on linux-omap. So basically after applying it,
you can boot the device and have sound support.

Even though this patches were tested using linux-omap, the series
is applicable on top of sound-2.6 tree as well.

Please review. And as usual, comments are welcome.

BR,

---
Eduardo Valentin


Eduardo Valentin (6):
  ASoC: OMAP: RX-51 Machine driver and AIC34b_dummy driver
  OMAP: RX51: Add audio board file
  board-rx51-peripherals: split vaux3 and vmmc2 supplies
  RX-51: Audio: Add usage of regulator framework to control VMMC2
  ASoC: tlv320aic3x: add initial usage of regulator framework to
    control avdd_dac
  ASoC: tpa6130a2: Control vdd using regulator framework

Eero Nurkkala (1):
  McBSP: OMAP3: Add Sidetone feature

Peter Ujfalusi (1):
  ASoC: TPA6130A2 amplifier driver

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-rx51-audio.c       |  132 +++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |   22 +-
 arch/arm/mach-omap2/mcbsp.c                  |    2 +
 arch/arm/plat-omap/include/mach/mcbsp.h      |   43 ++
 arch/arm/plat-omap/mcbsp.c                   |  379 ++++++++++++-
 include/sound/tpa6130a2-plat.h               |   30 +
 sound/soc/codecs/Kconfig                     |    4 +
 sound/soc/codecs/Makefile                    |    2 +
 sound/soc/codecs/tlv320aic3x.c               |   26 +
 sound/soc/codecs/tpa6130a2.c                 |  396 +++++++++++++
 sound/soc/codecs/tpa6130a2.h                 |   62 ++
 sound/soc/omap/Kconfig                       |   10 +
 sound/soc/omap/Makefile                      |    2 +
 sound/soc/omap/aic34b_dummy.c                |  271 +++++++++
 sound/soc/omap/aic34b_dummy.h                |   32 +
 sound/soc/omap/rx51.c                        |  793 ++++++++++++++++++++++++++
 sound/soc/omap/rx51.h                        |   29 +
 18 files changed, 2225 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-audio.c
 create mode 100644 include/sound/tpa6130a2-plat.h
 create mode 100644 sound/soc/codecs/tpa6130a2.c
 create mode 100644 sound/soc/codecs/tpa6130a2.h
 create mode 100644 sound/soc/omap/aic34b_dummy.c
 create mode 100644 sound/soc/omap/aic34b_dummy.h
 create mode 100644 sound/soc/omap/rx51.c
 create mode 100644 sound/soc/omap/rx51.h

