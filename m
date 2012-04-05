From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.4-rc1
Date: Wed, 4 Apr 2012 17:42:57 -0700
Message-ID: <20120405004256.GB10780@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46489 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2DEAnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 20:43:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Note that this also contains a set of fixes that are not regressions
or oopses to properly deal with the smsc911x regulator issue.

Basically the regulators must be per board file as the regulators
can also come from drivers, such as twl4030. So it's best to dumb
down gpmc-smsc911x.c to not even care about the regulators.

Regards,

Tony


The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
  Linus Torvalds (1):
        Linux 3.4-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Igor Grinberg (1):
      ARM: OMAP: fix section mismatches in usb-host.c

Mark A. Greer (2):
      arm: omap3: pm34xx.c: Fix omap3_pm_init() error out paths
      arm: omap3: pm34xx.c: Replace printk() with appropriate pr_*()

Ming Lei (1):
      ARM: OMAP3+: fix oops triggered in omap_prcm_register_chain_handler(v1)

Nishanth Menon (1):
      ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present

R Sricharan (1):
      ARM: OMAP2+: Fix omap2+ build error

Rajendra Nayak (1):
      ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK

Russ Dill (5):
      ARM: OMAP2+: smsc911x: Remove odd gpmc_cfg/board_data redirection
      ARM: OMAP2+ smsc911x: Fix possible stale smsc911x flags
      ARM: OMAP2+: smsc911x: Remove unused rate calculation
      ARM: OMAP2+: smsc911x: Remove regulator support from gmpc-smsc911x
      ARM: OMAP2+: smsc911x: Add fixed board regulators

Santosh Shilimkar (1):
      ARM: OMAP4: Workaround the OCP synchronisation issue with 32K synctimer.

Tero Kristo (1):
      ARM: OMAP4: prm: fix interrupt register offsets

Tony Lindgren (3):
      Merge branch 'misc_devel_3.4' of git://git.pwsan.com/linux-2.6 into fixes
      Merge branch 'fixes-smsc911x' into fixes
      Merge branch 'for_3.4/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes

 arch/arm/include/asm/barrier.h              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c          |   16 +++++++
 arch/arm/mach-omap2/board-igep0020.c        |    6 +++
 arch/arm/mach-omap2/board-ldp.c             |    7 +++
 arch/arm/mach-omap2/board-omap3evm.c        |   15 +++----
 arch/arm/mach-omap2/board-omap3logic.c      |    7 +++
 arch/arm/mach-omap2/board-omap3stalker.c    |   16 +++----
 arch/arm/mach-omap2/board-overo.c           |    8 +++
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 ++++
 arch/arm/mach-omap2/gpmc-smsc911x.c         |   65 +--------------------------
 arch/arm/mach-omap2/omap_hwmod.c            |    8 ++-
 arch/arm/mach-omap2/opp.c                   |    4 +-
 arch/arm/mach-omap2/pm34xx.c                |   38 ++++++++-------
 arch/arm/mach-omap2/pm44xx.c                |   10 +++-
 arch/arm/mach-omap2/prm44xx.c               |   21 +++++----
 arch/arm/mach-omap2/prm_common.c            |    2 +-
 arch/arm/mach-omap2/usb-host.c              |   10 +++--
 17 files changed, 122 insertions(+), 122 deletions(-)
