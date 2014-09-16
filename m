From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 0/5] Beaglebone-Black HDMI audio
Date: Tue, 16 Sep 2014 23:40:13 +0300
Message-ID: <cover.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45632 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbaIPUk3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 16:40:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>

Changes since v2:
- Change compatible property from "ti,gpio-clock" to "ti,gpio-gate-clock"
- Some minor cleanups

The code has a functional dependency to:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg109264.html

Without the above patch the audio card does not probe.

The code has been rebased on top of Linux 3.17-rc5. The patches
bellow, the above dependency, and couple of commits to add BBB HDMI audio
support to omap2plus_defconfig can be pulled from:

https://github.com/jsarha/linux.git linux-master-bbb-hdmi-audio

Cheers,
Jyri

Jyri Sarha (5):
  clk: ti: add "ti,gpio-gate-clock" controlled clock
  drm/tilcdc: Add I2S HDMI audio config for tda998x
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  ARM: dts: am335x-boneblack: Add HDMI audio support

 .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |    6 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |   52 +++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/gpio.c                              |  202 ++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/davinci-evm.c                    |   82 +++++++-
 8 files changed, 395 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-gate-clock.txt
 create mode 100644 drivers/clk/ti/gpio.c

-- 
1.7.9.5

