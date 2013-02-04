From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] omap PM changes for v3.9 merge window
Date: Mon, 4 Feb 2013 11:55:47 -0800
Message-ID: <E1U2S9T-0002ss-OU@merlin.infradead.org>
References: <pull-1360007747-30585>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1360007747-30585>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/pm-signed

for you to fetch changes up to 0e084c9c843320995b0e219f02880f910d439b37:

  Merge tag 'omap-cleanup-b-for-3.9' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.9/pm (2013-01-30 14:03:05 -0800)

----------------------------------------------------------------

OMAP PM related updates via Paul Walmsley <paul@pwsan.com>:

Remove some dead OMAP clock and device integration code and data.
Also, clean up the way that the OMAP device integration code blocks
WFI/WFE to use a consistent mechanism, controlled by a data flag.

Several OMAP2+ power management fixes, optimizations, and cleanup.
This series is a prerequisite for the functional powerdomain
conversion series.

----------------------------------------------------------------
Jean Pihet (1):
      ARM: OMAP2+: powerdomain: fix powerdomain trace integration

Paul Walmsley (19):
      ARM: OMAP2+: omap_device: remove obsolete pm_lats and early_device code
      ARM: OMAP4: clock/hwmod data: start to remove some IP block control "clocks"
      ARM: OMAP4: clock/hwmod data: remove MODULEMODE entries in mux + gate combos
      ARM: OMAP2xxx: clock data: clean up unused null clocks
      ARM: OMAP2xxx: powerdomain: core powerdomain missing logic retention states
      ARM: OMAP3xxx: CPUIdle: simplify the PER next-state code
      ARM: OMAP2+: hwmod: add support for blocking WFI when a device is active
      ARM: OMAP2420: hwmod data/PM: use hwmod to block WFI when I2C active
      ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()
      ARM: OMAP4: MPUSS PM: remove unnecessary shim functions for powerdomain control
      ARM: OMAP2+: clockdomain: add pwrdm_state_switch() call to clkdm_sleep()
      ARM: OMAP2xxx: PM: clean up some crufty powerstate programming code
      ARM: OMAP2: PM/powerdomain: drop unnecessary pwrdm_wait_transition()
      ARM: OMAP2+: PM/powerdomain: move omap_set_pwrdm_state() to powerdomain code
      ARM: OMAP2+: powerdomain/clockdomain: add a per-powerdomain spinlock
      ARM: OMAP2xxx: CM: remove autodep handling
      ARM: OMAP2+: clockdomain: work on wkdep/sleepdep functions
      ARM: OMAP2+: clockdomain: convert existing atomic usecounts into spinlock-protected shorts/ints
      ARM: OMAP2+: powerdomain: fix whitespace, improve flag comments

Tony Lindgren (2):
      Merge tag 'omap-cleanup-a-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/pm
      Merge tag 'omap-cleanup-b-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/pm

 arch/arm/mach-omap2/am35xx-emac.c                |   2 +-
 arch/arm/mach-omap2/cclock2420_data.c            |  16 +-
 arch/arm/mach-omap2/cclock2430_data.c            |  16 +-
 arch/arm/mach-omap2/cclock44xx_data.c            | 578 +++++------------------
 arch/arm/mach-omap2/clockdomain.c                | 569 ++++++++++++++--------
 arch/arm/mach-omap2/clockdomain.h                |  17 +-
 arch/arm/mach-omap2/cm2xxx.c                     |  33 +-
 arch/arm/mach-omap2/cm3xxx.c                     |  14 +-
 arch/arm/mach-omap2/cminst44xx.c                 |   2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |  79 ++--
 arch/arm/mach-omap2/devices.c                    |  25 +-
 arch/arm/mach-omap2/display.c                    |   2 +-
 arch/arm/mach-omap2/dma.c                        |   2 +-
 arch/arm/mach-omap2/drm.c                        |   3 +-
 arch/arm/mach-omap2/gpio.c                       |   3 +-
 arch/arm/mach-omap2/gpmc.c                       |   2 +-
 arch/arm/mach-omap2/hdq1w.c                      |   2 +-
 arch/arm/mach-omap2/hsmmc.c                      |   2 +-
 arch/arm/mach-omap2/hwspinlock.c                 |   3 +-
 arch/arm/mach-omap2/i2c.c                        |   3 +-
 arch/arm/mach-omap2/mcbsp.c                      |   2 +-
 arch/arm/mach-omap2/msdi.c                       |   2 +-
 arch/arm/mach-omap2/omap-iommu.c                 |   3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c        |  44 +-
 arch/arm/mach-omap2/omap_device.c                | 537 +++------------------
 arch/arm/mach-omap2/omap_device.h                |  79 +---
 arch/arm/mach-omap2/omap_hwmod.c                 |   8 +
 arch/arm/mach-omap2/omap_hwmod.h                 |   9 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c       |   7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       |  99 ++--
 arch/arm/mach-omap2/pm-debug.c                   |   6 +-
 arch/arm/mach-omap2/pm.c                         |  69 +--
 arch/arm/mach-omap2/pm.h                         |   1 -
 arch/arm/mach-omap2/pm24xx.c                     |  43 +-
 arch/arm/mach-omap2/pmu.c                        |   3 +-
 arch/arm/mach-omap2/powerdomain.c                | 232 +++++++--
 arch/arm/mach-omap2/powerdomain.h                |  52 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   4 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   9 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |  44 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |   3 +-
 arch/arm/mach-omap2/serial.c                     |   3 +-
 arch/arm/mach-omap2/sr_device.c                  |   3 +-
 arch/arm/mach-omap2/timer.c                      |   3 +-
 arch/arm/mach-omap2/usb-host.c                   |  16 +-
 arch/arm/mach-omap2/usb-musb.c                   |   2 +-
 arch/arm/mach-omap2/wd_timer.c                   |   3 +-
 47 files changed, 1002 insertions(+), 1657 deletions(-)
