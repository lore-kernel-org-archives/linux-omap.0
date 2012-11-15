From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap common clock changes for v3.8 merge window
Date: Wed, 14 Nov 2012 18:56:44 -0800
Message-ID: <E1TYpds-0007HG-Ql@merlin.infradead.org>
References: <pull-1352948204-277861>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1352948204-277861>
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

The following changes since commit 89ab216b33ba9405880fd3d89531305a931bc70f:

  Merge branch 'omap-for-v3.8/pm' into omap-for-v3.8/clock (2012-11-13 13:25:38 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/clock-signed

for you to fetch changes up to 558a0780b0a04862a678f7823215424b4e5501f9:

  Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)

----------------------------------------------------------------

Common clock framework for omap2+ via Paul Walmsley <paul@pwsan.com>:

Convert the OMAP2+ clock code and data to rely on the common
clock framework for internal bookkeeping and the driver API.

Basic test logs for this branch on top of Tony's cleanup-prcm branch
at commit c9d501e5cb0238910337213e12a09127221c35d8 are here:

http://www.pwsan.com/omap/testlogs/common_clk_devel_3.8_rebase/20121112192516/

However, cleanup-prcm at c9d501e5 does not include some fixes
that are needed for a successful test.  With several reverts,
fixes, and workarounds applied, the following test logs were
obtained:

http://www.pwsan.com/omap/testlogs/TEST_common_clk_devel_3.8_rebase/20121112192300/

which indicate that the series tests cleanly.

N.B. The common clock data addition patches result in many
checkpatch warnings of the form "WARNING: static const char *
array should probably be static const char * const".  However, it
appears that resolving these would require changes to the CCF
itself.  So the resolution of these warnings is being postponed
until that can be coordinated.

These patches result in a ~55KiB increase in runtime kernel memory
usage when booting omap2plus_defconfig kernels.

Conflicts:
	arch/arm/mach-omap2/clock33xx_data.c
	arch/arm/mach-omap2/clock3xxx_data.c
	arch/arm/mach-omap2/clock44xx_data.c

Note that this is based on a merge of the omap-for-v3.8/cleanup-prcm
and omap-for-v3.8/pm as otherwise merged in with the pm changes it
would automatically resolve into a non-booting merge for omap3 as
the smartreflex clock names were changed in the pm branch.

----------------------------------------------------------------
Mike Turquette (3):
      ARM: OMAP4: clock: Convert to common clk
      ARM: OMAP2+: clockdomain: bypass clockdomain handling when disabling unused clks
      ARM: OMAP2+: clock: Cleanup !CONFIG_COMMON_CLK parts

Paul Walmsley (7):
      ARM: OMAP2xxx: clock: add APLL rate recalculation functions
      ARM: OMAP2+: clock: add OMAP CCF convenience macros to mach-omap2/clock.h
      ARM: OMAP44xx: clock: drop obsolete clock data
      ARM: OMAP3xxx: clk: drop obsolete clock data
      ARM: AM33xx: clock: drop obsolete clock data
      ARM: OMAP3+: DPLL: drop !CONFIG_COMMON_CLK sections
      ARM: OMAP2xxx: clock: drop obsolete clock data

Rajendra Nayak (15):
      ARM: OMAP: clock: Nuke plat/clock.c & reuse struct clk as clk_hw_omap
      ARM: OMAP: hwmod: Fix up hwmod based clkdm accesses
      ARM: OMAP3: clock: Convert to common clk
      ARM: OMAP2: clock: Convert to common clk
      ARM: OMAP: clock: list all clk_hw_omap clks to enable/disable autoidle
      ARM: OMAP: clock: Define a function to enable clocks at init
      ARM: OMAP: clock: Get rid of some clkdm assocations within clks
      ARM: OMAP4: clock: Add 44xx data using common struct clk
      ARM: OMAP3: clock: Add 3xxx data using common struct clk
      ARM: OMAP2: clock: Add 24xx data using common struct clk
      ARM: OMAP: clock: Switch to COMMON clk
      ARM: OMAP: hwmod: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP4: clock: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP3: clock: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP2: clock: Cleanup !CONFIG_COMMON_CLK parts

Tony Lindgren (1):
      Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/clock

Vaibhav Hiremath (2):
      ARM: OMAP2+: hwmod: Invoke init_clkdm before other init functions
      ARM: AM33XX: clock: add clock data in common clock format

 arch/arm/mach-omap2/Kconfig                  |    5 +
 arch/arm/mach-omap2/Makefile                 |   10 +-
 arch/arm/mach-omap2/cclock2420_data.c        | 1950 ++++++++++++++
 arch/arm/mach-omap2/cclock2430_data.c        | 2065 +++++++++++++++
 arch/arm/mach-omap2/cclock33xx_data.c        |  961 +++++++
 arch/arm/mach-omap2/cclock3xxx_data.c        | 3595 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cclock44xx_data.c        | 1987 ++++++++++++++
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   62 +-
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |    8 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   13 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   13 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    7 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    9 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    8 +-
 arch/arm/mach-omap2/clkt_clksel.c            |  194 +-
 arch/arm/mach-omap2/clkt_dpll.c              |   28 +-
 arch/arm/mach-omap2/clkt_iclk.c              |   30 +-
 arch/arm/mach-omap2/clock.c                  |  910 ++-----
 arch/arm/mach-omap2/clock.h                  |  329 +--
 arch/arm/mach-omap2/clock2420_data.c         | 1972 --------------
 arch/arm/mach-omap2/clock2430.c              |    8 +-
 arch/arm/mach-omap2/clock2430_data.c         | 2071 ---------------
 arch/arm/mach-omap2/clock2xxx.c              |    1 +
 arch/arm/mach-omap2/clock2xxx.h              |   41 +-
 arch/arm/mach-omap2/clock33xx_data.c         | 1109 --------
 arch/arm/mach-omap2/clock34xx.c              |   51 +-
 arch/arm/mach-omap2/clock3517.c              |   24 +-
 arch/arm/mach-omap2/clock36xx.c              |   22 +-
 arch/arm/mach-omap2/clock36xx.h              |    2 +-
 arch/arm/mach-omap2/clock3xxx.c              |    6 +-
 arch/arm/mach-omap2/clock3xxx.h              |    6 +-
 arch/arm/mach-omap2/clock3xxx_data.c         | 3613 --------------------------
 arch/arm/mach-omap2/clock44xx_data.c         | 3398 ------------------------
 arch/arm/mach-omap2/clock_common_data.c      |   22 +-
 arch/arm/mach-omap2/clockdomain.c            |   89 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h        |    5 +
 arch/arm/mach-omap2/cm-regbits-34xx.h        |   31 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |    1 +
 arch/arm/mach-omap2/dpll3xxx.c               |  183 +-
 arch/arm/mach-omap2/dpll44xx.c               |   21 +-
 arch/arm/mach-omap2/io.c                     |    9 +
 arch/arm/mach-omap2/omap_hwmod.c             |   63 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    8 +-
 arch/arm/mach-omap2/pm24xx.c                 |    4 +-
 arch/arm/mach-omap2/prm-regbits-24xx.h       |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    1 +
 arch/arm/mach-omap2/scrm44xx.h               |    2 +
 48 files changed, 11486 insertions(+), 13464 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cclock2420_data.c
 create mode 100644 arch/arm/mach-omap2/cclock2430_data.c
 create mode 100644 arch/arm/mach-omap2/cclock33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cclock3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/cclock44xx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock2420_data.c
 delete mode 100644 arch/arm/mach-omap2/clock2430_data.c
 delete mode 100644 arch/arm/mach-omap2/clock33xx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock3xxx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock44xx_data.c
