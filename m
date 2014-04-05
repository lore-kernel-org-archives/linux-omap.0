From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/5] DT support for N900 soundcard (rx51-audio)
Date: Sat,  5 Apr 2014 23:35:48 +0200
Message-ID: <1396733753-9820-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds DT support in rx51-audio. I tested it on my
Nokia N900 and was able to play a wav file using aplay. I have
not tested the whole functionality, but output via speakers,
headphones and the related enable controls seem to work.

The patches can be applied cleanly to torvalds/linux.git:master
and broonie/sound.git:for-next.

-- Sebastian

Pali Roh=C3=A1r (1):
  ASoC: omap: rx51: Use devm_snd_soc_register_card

Sebastian Reichel (4):
  ASoC: Allow Aux Codecs to be specified using DT
  ASoC: RX-51: Add DT support to sound driver
  ASoC: RX-51: Convert to table based DAPM setup
  ASoC: tlv320aic3x: fix shared reset pin for DT

 .../devicetree/bindings/sound/nokia,rx51.txt       |  27 +++
 include/sound/rx51.h                               |  18 ++
 include/sound/soc.h                                |  13 +-
 sound/soc/codecs/tlv320aic3x.c                     |   9 +-
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 sound/soc/omap/omap-mcbsp.h                        |   2 +-
 sound/soc/omap/rx51.c                              | 248 +++++++++++++=
--------
 sound/soc/soc-core.c                               |  68 +++---
 8 files changed, 266 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nokia,rx51.=
txt
 create mode 100644 include/sound/rx51.h

--=20
1.9.1
