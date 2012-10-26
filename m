From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap prcm cleanup for v3.8 merge window, part1
Date: Fri, 26 Oct 2012 14:23:40 -0700
Message-ID: <E1TRrO0-00087R-UM@merlin.infradead.org>
References: <pull-1351286620-406688>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1351286620-406688>
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

The following changes since commit a0212796b58061a9716178d261f318925c246643:

  Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-prcm-part1-take2-signed

for you to fetch changes up to 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33:

  Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm (2012-10-26 13:32:22 -0700)

----------------------------------------------------------------

>From Paul Walmsley <paul@pwsan.com>:

The first set of OMAP PRM/CM-related cleanup patches for 3.8.
Prepares for the future move of the PRM/CM code to drivers/.  Also
includes some prcm.[ch] cleanup patches from the WDTIMER cleanup
series that don't need external acks.

----------------------------------------------------------------
Paul Walmsley (9):
      ARM: OMAP2+: PRM: remove PRM weak functions
      ARM: OMAP2+: PRM: split PRM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2+: powerdomain/PRM: move the low-level powerdomain functions into PRM
      ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2/3: clockdomain/PRM/CM: move the low-level clockdomain functions into PRM/CM
      ARM: OMAP2+: PRM: prepare for use of prm_ll_data function pointers
      ARM: OMAP2+: CM: prepare for use of cm_ll_data function pointers
      ARM: OMAP1: create read_reset_sources() function (for initial use by watchdog)
      ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver

Tony Lindgren (2):
      Merge tag 'omap-cleanup-a-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/cleanup-prcm
      Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm

 arch/arm/mach-omap1/common.h                    |    2 +
 arch/arm/mach-omap1/reset.c                     |   38 +++
 arch/arm/mach-omap2/Makefile                    |  110 ++++---
 arch/arm/mach-omap2/clkt2xxx_apll.c             |    2 +-
 arch/arm/mach-omap2/clkt2xxx_dpll.c             |    2 +-
 arch/arm/mach-omap2/clock.c                     |    3 +-
 arch/arm/mach-omap2/clock2420_data.c            |    2 +-
 arch/arm/mach-omap2/clock2430.c                 |    2 +-
 arch/arm/mach-omap2/clock2430_data.c            |    2 +-
 arch/arm/mach-omap2/clock34xx.c                 |    2 +-
 arch/arm/mach-omap2/clock3517.c                 |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c            |    2 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c      |  341 -------------------
 arch/arm/mach-omap2/clockdomain33xx.c           |   74 -----
 arch/arm/mach-omap2/clockdomain44xx.c           |  151 ---------
 arch/arm/mach-omap2/cm.h                        |   12 +
 arch/arm/mach-omap2/cm2xxx.c                    |  255 ++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h                    |   66 ++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h               |  119 +++----
 arch/arm/mach-omap2/cm33xx.c                    |   56 ++++
 arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} |  307 +++++++++--------
 arch/arm/mach-omap2/cm3xxx.h                    |   86 +++++
 arch/arm/mach-omap2/cm_common.c                 |   71 ++++
 arch/arm/mach-omap2/cminst44xx.c                |  142 +++++++-
 arch/arm/mach-omap2/control.c                   |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c                |   51 ++-
 arch/arm/mach-omap2/pm24xx.c                    |    4 +-
 arch/arm/mach-omap2/pm34xx.c                    |    5 +-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c      |  242 --------------
 arch/arm/mach-omap2/powerdomain33xx.c           |  229 -------------
 arch/arm/mach-omap2/powerdomain44xx.c           |  285 ----------------
 arch/arm/mach-omap2/prm-regbits-24xx.h          |    6 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h          |   12 +-
 arch/arm/mach-omap2/prm.h                       |   53 +++
 arch/arm/mach-omap2/prm2xxx.c                   |  126 +++++++
 arch/arm/mach-omap2/prm2xxx.h                   |  132 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c              |  332 +++++++------------
 arch/arm/mach-omap2/prm2xxx_3xxx.h              |  277 ++++------------
 arch/arm/mach-omap2/prm33xx.c                   |  202 ++++++++++++
 arch/arm/mach-omap2/prm3xxx.c                   |  403 +++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h                   |  160 +++++++++
 arch/arm/mach-omap2/prm44xx.c                   |  355 +++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h                   |    2 +
 arch/arm/mach-omap2/prm_common.c                |  104 +++---
 arch/arm/mach-omap2/sdrc2xxx.c                  |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                 |    4 +-
 arch/arm/mach-omap2/sram242x.S                  |    4 +-
 arch/arm/mach-omap2/sram243x.S                  |    4 +-
 arch/arm/mach-omap2/sram34xx.S                  |    2 +-
 49 files changed, 2750 insertions(+), 2099 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.h
 rename arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} (72%)
 create mode 100644 arch/arm/mach-omap2/cm3xxx.h
 create mode 100644 arch/arm/mach-omap2/cm_common.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.h
 create mode 100644 arch/arm/mach-omap2/prm3xxx.c
 create mode 100644 arch/arm/mach-omap2/prm3xxx.h
