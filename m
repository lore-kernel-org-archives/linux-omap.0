From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/9] Beaglebone-Black HDMI audio
Date: Wed, 6 Aug 2014 16:47:15 +0300
Message-ID: <cover.1407332062.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The code has a functional dependency to:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg108199.html

Without the above patch the audio card does not probe.

The code has been rebased on top of Linux 3.16 merged with 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
with http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg108199.html
cherry-picked on top.

All patches have gone trough some cleaning up since the RFC version of
these patches over half a year ago.

Jyri Sarha (9):
  ASoC: mcasp: Fix implicit BLCK divider setting
  clk: add gpio controlled clock
  drm/tilcdc: Add I2S HDMI audio config for tda998x
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  ARM: dts: am33xx: Add external clock provider
  ARM: dts: am335x-boneblack: Add HDMI audio support
  ARM: OMAP2+: omap2plus_defconfig: TDA998X HDMI trough tilcdc,slave
  ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
    support

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |    4 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |   54 +++++
 arch/arm/boot/dts/am33xx.dtsi                      |   10 +
 arch/arm/configs/omap2plus_defconfig               |    5 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  206 ++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 include/linux/clk-provider.h                       |   23 +++
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/davinci-evm.c                    |   82 +++++++-
 sound/soc/davinci/davinci-mcasp.c                  |   14 +-
 12 files changed, 449 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
