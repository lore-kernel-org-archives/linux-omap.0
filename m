From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/8] Beaglebone-Black HDMI audio
Date: Tue, 19 Aug 2014 00:46:38 +0300
Message-ID: <cover.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Changes since v1 of the patch set:
- Move gpio-clock under drivers drivers/clk/ti/ and change compatible
  string to "ti,gpio-clock" to get it accepted
- Drop already applied "ASoC: mcasp: Fix implicit BLCK divider setting"
- Fix typo from "ARM: dts: am33xx: Add external clock provider" commit
  message

The code has a functional dependency to:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg108199.html

Without the above patch the audio card does not probe.

The code has been rebased on top of Linux 3.17-rc1 merged with 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
with http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg108199.html
cherry-picked on top.

Cheers,
Jyri

Jyri Sarha (8):
  clk: ti: add gpio controlled clock
  drm/tilcdc: Add I2S HDMI audio config for tda998x
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  ARM: dts: am33xx: Add external clock provider
  ARM: dts: am335x-boneblack: Add HDMI audio support
  ARM: OMAP2+: omap2plus_defconfig: TDA998X HDMI trough tilcdc,slave
  ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
    support

 .../devicetree/bindings/clock/ti/gpio-clock.txt    |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |    4 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |   54 ++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   10 +
 arch/arm/configs/omap2plus_defconfig               |    5 +
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/gpio.c                              |  202 ++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/davinci-evm.c                    |   82 +++++++-
 10 files changed, 411 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-clock.txt
 create mode 100644 drivers/clk/ti/gpio.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
