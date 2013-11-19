From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/9] Beaglebone-Black HDMI audio
Date: Tue, 19 Nov 2013 14:12:20 +0200
Message-ID: <cover.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51539 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3KSMNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 07:13:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This set of patches implements PCM HDMI audio driver for
Beaglebone-Black HDMI output. The patches have been rebased
on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound topic/davinci

There is couple of earlier RFC versions of the clk patch floating
around, but the one here is the latest version.

I'll send the associated dts changes shortly as a separate patch.

Best regards,
Jyri

Jyri Sarha (9):
  clk: add gpio controlled clock
  ASoC: davinci-evm: Add named clock reference to DT bindings
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: hdmi-codec: Add devicetree binding with documentation
  ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE playback format
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  drm/tilcdc: Add I2C HDMI audio config for tda998x
  ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc and TDA998X HDMI
    support
  ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
    support

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |   12 +-
 Documentation/devicetree/bindings/sound/hdmi.txt   |   17 ++
 arch/arm/configs/omap2plus_defconfig               |    5 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  209 ++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 include/linux/clk-provider.h                       |   25 +++
 sound/soc/codecs/hdmi.c                            |   12 +-
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |  227 +++++++++++++++++++-
 12 files changed, 558 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5

