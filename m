From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.3-rc4
Date: Thu, 23 Feb 2012 15:15:28 -0800
Message-ID: <20120223231528.GE18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab2BWXPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 18:15:32 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

This contains a fix for omap4 to call memblck_steal() from
.reserve like it should be, and fixes a regression for smsc911x
using boards as they now require regulators. Also included are
fixes for errors that show up if the TWL PMIC is compiled as a
module.

Note that the top two patches are from today: The smsc911x patch
was updated for to remove an unnecessary variable, and the
mailbox compile fix I applied earlier today.

Regards,

Tony


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
  Linus Torvalds (1):
        Linux 3.3-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Arnout Vandecappelle (Essensium/Mind) (1):
      OMAP3 EVM: remove out-of-bounds array access of gpio_leds

Felipe Balbi (1):
      ARM: OMAP2+: usb-host: fix compile warning

Matt Porter (1):
      ARM: OMAP2+: gpmc-smsc911x: add required smsc911x regulators

NeilBrown (1):
      ARM: OMAP: add RCU locking to omap2_set_init_voltage.

Ohad Ben-Cohen (1):
      ARM: OMAP2: fix mailbox init code

Santosh Shilimkar (2):
      ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor.
      ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve callback

Tony Lindgren (5):
      Merge branch 'for_3.3/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
      ARM: OMAP: Fix kernel panic with HSMMC when twl4030_gpio is a module
      ARM: OMAP: Fix build error when mmc_omap is built as module
      Merge branch 'fixes-mmc' into fixes
      ARM: OMAP1: Fix out-of-bounds array access for Innovator

 arch/arm/mach-omap1/board-innovator.c         |    4 +-
 arch/arm/mach-omap2/Kconfig                   |    4 +-
 arch/arm/mach-omap2/board-n8x0.c              |    4 ++
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c             |    5 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c           |   52 +++++++++++++++++++++++++
 arch/arm/mach-omap2/hsmmc.c                   |    6 +++
 arch/arm/mach-omap2/io.c                      |    1 +
 arch/arm/mach-omap2/mailbox.c                 |   10 ++++-
 arch/arm/mach-omap2/mux.c                     |    2 +-
 arch/arm/mach-omap2/omap4-common.c            |   25 ++++++++----
 arch/arm/mach-omap2/pm.c                      |    3 +
 arch/arm/mach-omap2/usb-host.c                |    6 +-
 arch/arm/plat-omap/common.c                   |    1 +
 arch/arm/plat-omap/include/plat/omap-secure.h |    6 +++
 16 files changed, 110 insertions(+), 22 deletions(-)
