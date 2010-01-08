From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Fri, 8 Jan 2010 10:09:12 -0800
Message-ID: <20100108180912.GC6831@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62678 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab0AHSJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 13:09:22 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 74d2e4f8d79ae0c4b6ec027958d5b18058662eea:
  Linus Torvalds (1):
        Linux 2.6.33-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Abhijit Pagare (2):
      ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.
      ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.

Alexander Shishkin (1):
      omap2/3: make serial_in_override() address the right uart port

Cory Maccarrone (5):
      OMAP1 clock: Add missing clocks for OMAP 7xx
      OMAP1 clock: Add missing clocks for OMAP 7xx
      OMAP1 clock: remove __initdata from struct clk_functions to prevent crash
      omap: gpio: Simultaneously requested rising and falling edge
      omap1: Add 7xx clocks and pin muxes for SPI

Felipe Balbi (1):
      OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is enabled

Huang Weiyi (2):
      OMAP2: remove duplicated #include
      OMAP2: remove duplicated #include

Janusz Krzysztofik (1):
      omap: McBSP: Fix possible port lockout

Kevin Hilman (2):
      OMAP3: clock: add clockdomains for UART1 & 2
      OMAP3: clock: add clockdomains for UART1 & 2

Paul Walmsley (11):
      OMAP2xxx IO mapping: mark DSP mappings as being 2420-only
      OMAP2420 IO mapping: move IVA mapping virtual address out of vmalloc space
      OMAP3 clock: McBSP 2, 3, 4 functional clock parent is PER_96M_FCLK, not CORE_96M_FCLK
      OMAP clock: remove incorrect EXPORT_SYMBOL()s
      OMAP2xxx IO mapping: mark DSP mappings as being 2420-only
      OMAP2420 IO mapping: move IVA mapping virtual address out of vmalloc space
      OMAP3 clock: McBSP 2, 3, 4 functional clock parent is PER_96M_FCLK, not CORE_96M_FCLK
      OMAP clock: remove incorrect EXPORT_SYMBOL()s
      OMAP2xxx OPP: clean up comments in OPP data
      OMAP clock/CPUFreq: add clk_exit_cpufreq_table()
      OMAP2 clock: dynamically allocate CPUFreq frequency table

Roel Kluin (3):
      omap: &&/|| confusion in iommu_put()
      omap3: add missing parentheses
      omap3: add missing parentheses

Tony Lindgren (5):
      Merge branch 'for_2_6_33_rc_a' of git://git.pwsan.com/linux-2.6 into omap-fixes-2.6.33-rc3
      Merge branch 'for_2.6.33rc_b' of git://git.pwsan.com/linux-2.6 into omap-fixes-for-linus
      omap: Remove uninitialized warning for gpio.c
      omap1: Fix compile for omap1_bl.c
      omap3: Fix booting if package is uninitialized

Tuukka Toivonen (2):
      OMAP3 clock: Add capability to change rate of dpll4_m5_ck
      OMAP3 clock: Add capability to change rate of dpll4_m5_ck

Vaibhav Hiremath (1):
      omap3: EVM: Choose OMAP_PACKAGE_CBB

Vimal Singh (1):
      omap2/3: ZOOM: Correcting key mapping for few keys

 arch/arm/mach-omap1/clock_data.c             |   10 +++-
 arch/arm/mach-omap1/devices.c                |   35 ++++++++++++++
 arch/arm/mach-omap1/mux.c                    |    8 +++
 arch/arm/mach-omap2/Kconfig                  |    1 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++--
 arch/arm/mach-omap2/clock2xxx.c              |   57 +++++++++++++++++++----
 arch/arm/mach-omap2/clock34xx.c              |    1 -
 arch/arm/mach-omap2/clock34xx_data.c         |    6 ++-
 arch/arm/mach-omap2/clockdomain.c            |    4 +-
 arch/arm/mach-omap2/io.c                     |   19 ++++----
 arch/arm/mach-omap2/mux.c                    |    6 ++-
 arch/arm/mach-omap2/opp2420_data.c           |   38 ++++++++-------
 arch/arm/mach-omap2/opp2430_data.c           |   30 ++++++------
 arch/arm/mach-omap2/pm34xx.c                 |    4 +-
 arch/arm/mach-omap2/serial.c                 |   12 ++++-
 arch/arm/plat-omap/clock.c                   |   16 ++++---
 arch/arm/plat-omap/cpu-omap.c                |    1 +
 arch/arm/plat-omap/gpio.c                    |   63 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/board.h      |    1 -
 arch/arm/plat-omap/include/plat/clock.h      |    2 +
 arch/arm/plat-omap/include/plat/control.h    |    2 +-
 arch/arm/plat-omap/include/plat/io.h         |   36 +++++++--------
 arch/arm/plat-omap/include/plat/mux.h        |    8 +++
 arch/arm/plat-omap/include/plat/omap7xx.h    |    3 +
 arch/arm/plat-omap/io.c                      |   12 +++---
 arch/arm/plat-omap/iommu.c                   |    2 +-
 arch/arm/plat-omap/mcbsp.c                   |   20 +++++++-
 drivers/video/backlight/omap1_bl.c           |    2 -
 28 files changed, 296 insertions(+), 111 deletions(-)
