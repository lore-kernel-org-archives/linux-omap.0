From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap prcm clean-up for v3.19
Date: Tue, 11 Nov 2014 09:14:29 -0800
Message-ID: <23193.7248413034$1415726202@news.gmane.org>
References: <pull-1415725783-562282>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1415725783-562282>
In-Reply-To: <pull-1415725783-562282>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/prcm-cleanup

for you to fetch changes up to 61c8621e2bd14faad9b89ab2284955b28000bcd5:

  ARM: OMAP2+: PRM: provide generic API for system reset (2014-10-27 08:39:26 -0700)

----------------------------------------------------------------
Clean-up series for omap PRCM (Power Reset Clock Module) from
Tero Kristo to move things a bit closer to becoming a proper
device driver.

----------------------------------------------------------------
Tero Kristo (26):
      ARM: DRA7: PRM: add voltage processor check behind a prm_feature flag
      ARM: AM43XX: PRM: use OMAP4 PRM driver
      ARM: OMAP2/3: hwmod: merge wait_target_ready functions for omap2/3
      ARM: AM33xx/OMAP4+: CM: remove cdoffs parameter from wait_module_idle/ready
      ARM: OMAP4/AM33xx: add cm_init / cm_exit calls for AM33xx and OMAP4+
      ARM: OMAP2+: CM: add common API for cm_wait_module_ready
      ARM: OMAP4+/AM33xx: CM: add common API for cm_wait_module_idle
      ARM: OMAP2+: CM: make clkdm_hwsup operations static
      ARM: OMAP2+: CM: add common APIs for cm_module_enable/disable
      ARM: OMAP2/3: CM: make cm_split_idlest_reg SoC calls static
      ARM: AM33xx: hwmod: remove am33xx specific module SoC opts
      ARM: AM43xx: hwmod: use OMAP4 hardreset ops instead of the AM33xx version
      ARM: AM33xx: PRM: add support for prm_init
      ARM: OMAP2+: PRM: add generic API for asserting hardware reset
      ARM: OMAP2+: PRM: add generic API for deasserting hardware reset
      ARM: OMAP2+: PRM: add generic API for checking hardreset status
      ARM: OMAP4: CM: move public definitions from cminst44xx.h to cm44xx.h
      ARM: OMAP4: CM: make cminst direct register access functions static
      ARM: OMAP4+: CM: remove omap4_cm1/cm2_* functions
      ARM: AM33xx: PRM: move global warm reset implementation to driver
      ARM: AM33xx: PRM: make direct register access functions static
      ARM: OMAP4: PRM: make omap4_prm_read/write_inst_reg calls static
      ARM: OMAP3: PRM: make PRCM interrupt handler related functions static
      ARM: OMAP4: PRM: make PRCM interrupt handler related functions static
      ARM: OMAP3+: PRM: add generic API for reconfiguring I/O chain
      ARM: OMAP2+: PRM: provide generic API for system reset

 arch/arm/mach-omap2/Makefile         |   2 +-
 arch/arm/mach-omap2/am33xx-restart.c |  12 +-
 arch/arm/mach-omap2/clock.c          |   3 +-
 arch/arm/mach-omap2/cm.h             |  18 ++-
 arch/arm/mach-omap2/cm1_44xx.h       |   2 -
 arch/arm/mach-omap2/cm1_54xx.h       |   2 -
 arch/arm/mach-omap2/cm1_7xx.h        |   2 -
 arch/arm/mach-omap2/cm2_44xx.h       |   2 -
 arch/arm/mach-omap2/cm2_54xx.h       |   2 -
 arch/arm/mach-omap2/cm2_7xx.h        |   2 -
 arch/arm/mach-omap2/cm2xxx.c         |  17 ++-
 arch/arm/mach-omap2/cm2xxx.h         |  10 +-
 arch/arm/mach-omap2/cm33xx.c         |  61 ++++++---
 arch/arm/mach-omap2/cm33xx.h         |  37 +-----
 arch/arm/mach-omap2/cm3xxx.c         |  19 +--
 arch/arm/mach-omap2/cm3xxx.h         |  12 --
 arch/arm/mach-omap2/cm44xx.c         |  49 -------
 arch/arm/mach-omap2/cm44xx.h         |   3 +
 arch/arm/mach-omap2/cm_44xx_54xx.h   |  36 -----
 arch/arm/mach-omap2/cm_common.c      |  82 +++++++++++-
 arch/arm/mach-omap2/cminst44xx.c     |  80 ++++++-----
 arch/arm/mach-omap2/cminst44xx.h     |  43 ------
 arch/arm/mach-omap2/io.c             |  11 +-
 arch/arm/mach-omap2/omap2-restart.c  |   5 +-
 arch/arm/mach-omap2/omap3-restart.c  |   7 +-
 arch/arm/mach-omap2/omap4-restart.c  |   6 +-
 arch/arm/mach-omap2/omap_hwmod.c     | 248 ++++++++---------------------------
 arch/arm/mach-omap2/prm.h            |  16 +++
 arch/arm/mach-omap2/prm2xxx.c        |   6 +-
 arch/arm/mach-omap2/prm2xxx.h        |   1 -
 arch/arm/mach-omap2/prm2xxx_3xxx.c   |  19 ++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h   |   9 +-
 arch/arm/mach-omap2/prm33xx.c        |  64 +++++++--
 arch/arm/mach-omap2/prm33xx.h        |  11 +-
 arch/arm/mach-omap2/prm3xxx.c        |  32 ++---
 arch/arm/mach-omap2/prm3xxx.h        |  16 ---
 arch/arm/mach-omap2/prm44xx.c        |  36 +++--
 arch/arm/mach-omap2/prm44xx_54xx.h   |  19 ---
 arch/arm/mach-omap2/prm_common.c     |  99 ++++++++++++++
 arch/arm/mach-omap2/prminst44xx.c    |  10 +-
 arch/arm/mach-omap2/prminst44xx.h    |   5 +-
 41 files changed, 530 insertions(+), 586 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cm44xx.c
 delete mode 100644 arch/arm/mach-omap2/cm_44xx_54xx.h
 delete mode 100644 arch/arm/mach-omap2/cminst44xx.h
