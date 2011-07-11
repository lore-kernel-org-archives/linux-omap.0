From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap related MFD and ASoC patches for v3.1 merge window
Date: Mon, 11 Jul 2011 04:53:09 -0700
Message-ID: <20110711115309.GA5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110711114736.GX5783@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

The following changes since commit 727e18b429e3badda12d1de74f492bfa363a2e94:
  Tony Lindgren (1):
        Merge branch 'peter/topic/for-tony_mach-cleanup' of git://gitorious.org/omap-audio/linux-audio into cleanup-part-2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git twl-asoc

These depend on the cleanup-part-2 branch, so it was agreed with the MFD and ASoC
maintainers that they should get merged along with the other omap patches.

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

Peter Ujfalusi (17):
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

Tony Lindgren (1):
      Merge branch 'peter/topic/for-tony' of git://gitorious.org/omap-audio/linux-audio into twl-asoc

 arch/arm/mach-omap2/board-4430sdp.c                |   56 ++
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    6 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   10 +-
 arch/arm/mach-omap2/twl-common.c                   |   10 +-
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
 drivers/mfd/twl6040-core.c                         |  620 +++++++++++++++++
 drivers/mfd/twl6040-irq.c                          |  191 +++++
 include/linux/i2c/twl.h                            |   25 +-
 .../linux/mfd/{twl4030-codec.h => twl4030-audio.h} |   16 +-
 include/linux/mfd/twl6040.h                        |  228 ++++++
 sound/soc/codecs/Kconfig                           |    3 +-
 sound/soc/codecs/twl4030.c                         |   22 +-
 sound/soc/codecs/twl6040.c                         |  733 +++++++++-----------
 sound/soc/codecs/twl6040.h                         |  119 +----
 sound/soc/omap/sdp3430.c                           |    2 +-
 sound/soc/omap/sdp4430.c                           |   52 +--
 sound/soc/omap/zoom2.c                             |    2 +-
 26 files changed, 2230 insertions(+), 904 deletions(-)
 create mode 100644 drivers/input/misc/twl6040-vibra.c
 create mode 100644 drivers/mfd/twl4030-audio.c
 delete mode 100644 drivers/mfd/twl4030-codec.c
 create mode 100644 drivers/mfd/twl6040-core.c
 create mode 100644 drivers/mfd/twl6040-irq.c
 rename include/linux/mfd/{twl4030-codec.h => twl4030-audio.h} (96%)
 create mode 100644 include/linux/mfd/twl6040.h
