From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/10] updates for omap PRCM (Power, Reset, Clock Management)
Date: Thu, 10 May 2012 11:39:18 -0700
Message-ID: <E1SSYHZ-0005jM-3A@merlin.infradead.org>
References: <pull-1336675159-747052>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336675159-747052>
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

The following changes since commit 1df82cd6d7673006ae2ecbe8745bcf44f61c53a8:

  Merge tag 'omap-devel-a-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod (2012-04-19 17:45:33 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-prcm-for-v3.5

for you to fetch changes up to 743a6d923f803c861a24d173e1d1818ca8ac0384:

  Merge tag 'omap-devel-b-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-prcm (2012-05-08 11:49:09 -0700)

----------------------------------------------------------------

Updates for PRCM (Power, Reset, Clock Management).

Note that this depends on omap-devel-hwmod-for-v3.5.

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4
      ARM: OMAP3: clock data: treat all AM35x devices the same
      ARM: OMAP: clock: convert AM3517/3505 detection/flags to AM35xx

Mark A. Greer (1):
      arm: omap3: clockdomain data: Remove superfluous commas from gfx_sgx_3xxx_wkdeps[]

Paul Walmsley (2):
      ARM: OMAP3: clock data: add clockdomain for HDQ functional clock
      Merge branches 'clock_am35xx_cleanup_3.5', 'prm_cm_devel_a_3.5', 'clock_devel_a_3.5' and 'pwrdm_clkdm_cleanup_3.5' into prcm_devel_a_3.5

R Sricharan (1):
      ARM: OMAP4+: Add prm and cm base init function.

Rajendra Nayak (1):
      ARM: OMAP3: Fix CM register bit masks

Santosh Shilimkar (1):
      ARM: OMAP2+: powerdomain: Get rid off duplicate pwrdm_clkdm_state_switch() API

Tarun Kanti DebBarma (1):
      ARM: OMAP2+: dmtimer: cleanup iclk usage

Tony Lindgren (1):
      Merge tag 'omap-devel-b-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into devel-prcm

Vaibhav Bedia (1):
      ARM: OMAP3+: dpll: Configure autoidle mode only if it's supported

Vaibhav Hiremath (1):
      ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common header

 arch/arm/mach-omap2/clock.c                   |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |   25 +++++++---------------
 arch/arm/mach-omap2/clock44xx_data.c          |   11 ----------
 arch/arm/mach-omap2/clockdomain.c             |    7 +++----
 arch/arm/mach-omap2/clockdomains3xxx_data.c   |    6 +++---
 arch/arm/mach-omap2/cm-regbits-34xx.h         |    4 ++--
 arch/arm/mach-omap2/cminst44xx.c              |   28 ++++++++++++++++---------
 arch/arm/mach-omap2/common.c                  |    1 +
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/dpll3xxx.c                |   23 +++++++++++++++-----
 arch/arm/mach-omap2/powerdomain.c             |   10 ---------
 arch/arm/mach-omap2/powerdomain.h             |    1 -
 arch/arm/mach-omap2/prcm-common.h             |   17 +++++++++++++++
 arch/arm/mach-omap2/prcm.c                    |    8 +++++++
 arch/arm/mach-omap2/prminst44xx.c             |   27 ++++++++++++++----------
 arch/arm/mach-omap2/timer.c                   |    7 -------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +---
 arch/arm/plat-omap/include/plat/dmtimer.h     |    2 +-
 18 files changed, 97 insertions(+), 87 deletions(-)
