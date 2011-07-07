From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: [GIT PULL] TWL6040 MFD and followups
Date: Thu, 7 Jul 2011 14:48:10 +0300
Message-ID: <5898202.Q4JP1WeJj2@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab1GGLsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 07:48:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Tony,

As it has been discussed I'm sending this pull request, which includes =
the
following series (all patch acked-by the corresponding maintainer):
1. v6 of MFD/ASoC/Input: TWL4030/TWL60X0 changes (18 patch)
2. v3 of MFD/input/ASoC: twl6040: irq registration changes (5 patch)
3. v1 of ASoC/MFD: twl6040: PLL handling changes (6 patch)
4. ASoC: twl6040: Add back support for legacy mode (single patch)

The first series starts with a cleanup in the mach-omap2 directory
(twl-common.c file created), and that is the reason we agreed that you
are going to take this pull request.
The rest of the changes are well contained, and should not cause merge
conflict for 3.1. We have not sent patches for these components, so the
changes to these are coming from one source.

As you have requested I have created the series on top of your
devel-cleanup branch.

Best regards,
P=E9ter

---
The following changes since commit 48cb1258e8b0f8c81cfb699b42326c5b2147=
b3f8:

  Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/pub/scm/linux/=
kernel/git/khilman/linux-omap-pm into devel-cleanup (2011-06-29 04:45:1=
6 -0700)

are available in the git repository at:

  git://gitorious.org/omap-audio/linux-audio.git peter/topic/for-tony

Axel Castaneda Gonzalez (1):
      ASoC: twl6040: Configure ramp step based on platform

Liam Girdwood (3):
      ASoC: twl6040: add all ABE DAIs
      ASoC: twl6040: Support other sample rates in constraints.
      ASoC: twl6040: set default constraints.

Misael Lopez Cruz (5):
      mfd: twl6040: Add initial support
      ASoC: twl6040: Convert into TWL6040 MFD child
      input: Add initial support for TWL6040 vibrator
      ASoC: twl6040: Remove pll and headset mode dependency
      OMAP4: SDP4430: Add twl6040 codec platform support

Peter Ujfalusi (21):
      OMAP: New twl-common for common TWL configuration
      OMAP4: Move common twl6030 configuration to twl-common
      OMAP3: Move common twl configuration to twl-common
      OMAP3: Move common regulator configuration to twl-common
      MFD: twl4030-codec: Rename internals from codec to audio
      MFD: twl4030-codec -> twl4030-audio: Rename the driver
      MFD: twl4030-audio: Rename platform data
      MFD: twl6040: Change platform data for soc codec driver
      OMAP4: SDP4430: Add twl6040 vibrator platform support
      MFD: twl6040: Use resource to provide irq number for slaves
      input: twl6040-vibra: Do not use wrapper for irq request
      ASoC: twl6040: Do not use wrapper for irq request
      MFD: twl6040: Demand valid interrupt configuration
      MFD: twl6040: Remove wrapper for threaded irq request
      ASoC: twl6040: Use neutral name for power mode text/enum
      ASoC: twl6040: Move PLL selection to codec driver
      ASoC: twl6040: Simplify sample rate constraint handling
      ASoC: twl6040: Configure PLL only once
      MFD: twl6040: Remove enum for PLL tracking
      ASoC: twl6040: No need to convert the PLL ID
      ASoC: twl6040: Add back support for legacy mode

 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   89 +---
 arch/arm/mach-omap2/board-4430sdp.c                |  185 ++----
 arch/arm/mach-omap2/board-cm-t35.c                 |   51 +--
 arch/arm/mach-omap2/board-devkit8000.c             |   38 +-
 arch/arm/mach-omap2/board-igep0020.c               |   44 +-
 arch/arm/mach-omap2/board-ldp.c                    |   15 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   62 +--
 arch/arm/mach-omap2/board-omap3evm.c               |   70 +--
 arch/arm/mach-omap2/board-omap3pandora.c           |   62 +--
 arch/arm/mach-omap2/board-omap3stalker.c           |   72 +--
 arch/arm/mach-omap2/board-omap3touchbook.c         |   61 +--
 arch/arm/mach-omap2/board-omap4panda.c             |  146 +----
 arch/arm/mach-omap2/board-overo.c                  |   61 +--
 arch/arm/mach-omap2/board-rm680.c                  |    8 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   46 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   89 +--
 arch/arm/mach-omap2/common-board-devices.c         |   21 -
 arch/arm/mach-omap2/common-board-devices.h         |   26 +-
 arch/arm/mach-omap2/twl-common.c                   |  304 ++++++++
 arch/arm/mach-omap2/twl-common.h                   |   59 ++
 arch/arm/plat-omap/include/plat/irqs.h             |   12 +-
 drivers/input/misc/Kconfig                         |   13 +-
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/twl4030-vibra.c                 |   12 +-
 drivers/input/misc/twl6040-vibra.c                 |  423 +++++++++++
 drivers/mfd/Kconfig                                |    8 +-
 drivers/mfd/Makefile                               |    3 +-
 drivers/mfd/twl-core.c                             |   13 +-
 drivers/mfd/twl4030-audio.c                        |  277 ++++++++
 drivers/mfd/twl4030-codec.c                        |  277 --------
 drivers/mfd/twl6040-core.c                         |  620 ++++++++++++=
+++++
 drivers/mfd/twl6040-irq.c                          |  191 +++++
 include/linux/i2c/twl.h                            |   25 +-
 .../linux/mfd/{twl4030-codec.h =3D> twl4030-audio.h} |   16 +-
 include/linux/mfd/twl6040.h                        |  228 ++++++
 sound/soc/codecs/Kconfig                           |    3 +-
 sound/soc/codecs/twl4030.c                         |   22 +-
 sound/soc/codecs/twl6040.c                         |  733 +++++++++---=
--------
 sound/soc/codecs/twl6040.h                         |  119 +----
 sound/soc/omap/sdp3430.c                           |    2 +-
 sound/soc/omap/sdp4430.c                           |   52 +--
 sound/soc/omap/zoom2.c                             |    2 +-
 43 files changed, 2703 insertions(+), 1860 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl-common.c
 create mode 100644 arch/arm/mach-omap2/twl-common.h
 create mode 100644 drivers/input/misc/twl6040-vibra.c
 create mode 100644 drivers/mfd/twl4030-audio.c
 delete mode 100644 drivers/mfd/twl4030-codec.c
 create mode 100644 drivers/mfd/twl6040-core.c
 create mode 100644 drivers/mfd/twl6040-irq.c
 rename include/linux/mfd/{twl4030-codec.h =3D> twl4030-audio.h} (96%)
 create mode 100644 include/linux/mfd/twl6040.h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
