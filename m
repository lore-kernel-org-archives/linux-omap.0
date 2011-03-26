From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap-fixes for -rc1
Date: Sat, 26 Mar 2011 12:00:52 -0700
Message-ID: <20110326190052.GB571@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

This series includes a fix for GPMC (General Purpose Memory Controller)
interrupts to work for omap2 and 4 in addition to omap3, and get
rid of the related warnings. It also fixes a mystery shutdown issue
on Panda board by removing unused regulators. Other fixes are quite
trivial, also included is the change to make hwspinlock depend on
ARCH_OMAP4.

Regards,

Tony


The following changes since commit 16c29dafcc86024048f1dbb8349d31cb22c7c55a:

  Merge branch 'syscore' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6 (2011-03-25 21:07:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (2):
      arm: mach-omap2: devices: fix omap3_l3_init() return value
      arm: mach-omap2: omap_l3_smx: fix irq handler setup

Balaji T K (1):
      ARM: OMAP2+: Fix warnings for GPMC interrupt

David Anders (1):
      OMAP4: PandaBoard: remove unused power regulators

Ohad Ben-Cohen (1):
      hwspinlock: depend on OMAP4

 arch/arm/mach-omap2/board-omap4panda.c |   28 ----------------------------
 arch/arm/mach-omap2/devices.c          |    2 +-
 arch/arm/mach-omap2/gpmc.c             |   13 ++++++++-----
 arch/arm/mach-omap2/omap_l3_smx.c      |   11 ++++-------
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 drivers/hwspinlock/Kconfig             |    1 +
 6 files changed, 15 insertions(+), 42 deletions(-)
