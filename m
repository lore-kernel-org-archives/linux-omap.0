From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap clean-up for v4.2
Date: Wed, 20 May 2015 15:36:04 -0700
Message-ID: <9446.35615819625$1432161390@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery3.ore.mailhop.org ([54.213.22.21]:10289 "HELO
	pmta2.delivery3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753681AbbETWgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 18:36:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/clean

for you to fetch changes up to fd0dbc83c6602ad57f34d1ec0b120fea25fcca56:

  Merge branch 'omap-for-v4.2/legacy' into omap-for-v4.2/cleanup (2015-05-20 14:51:05 -0700)

----------------------------------------------------------------
Clean-up for omaps for v4.2 merge window:

Drop more omap3 legacy board-*.c files for v4.2. This time we're
dropping the board files for beagle, overo and cm-t35.

The reason for dropping these now rather than later is that now
we can simply revert the patches in case of unexpected issues as
we are not dropping any platform data at this point.

This leaves us with only the following board-*.c files:

BOARD                   REASON NEEDED
board-ldp.c             Still used in RMKs boot test system
board-omap3logic.c      Getting a .dts file for v4.2
board-omap3pandora.c    Got a .dts file for v4.1
board-rx51-*.c          Needs /proc/atags support for user space

I'm hoping we can drop the remaining board-*.c for v4.3 merge
window, then keep the platform data around for one more merge
window in case of reverting needed, then drop the platform data
too for v4.4 if no issues needing reverting are found.

Also, few patches to clean-up the usage of Linux generic
macros:

- Use define for console loglevel

- Use const for struct irq_domain_ops

- Use PTR_ERR_OR_ZERO instead of PTR_RET

----------------------------------------------------------------
Alexander Kuleshov (1):
      ARM: OMAP2+: use symbolic defines for console loglevels instead of numbers

Krzysztof Kozlowski (1):
      ARM: OMAP2+: Constify irq_domain_ops

Nicholas Krause (2):
      ARM: OMAP2+: Remove calls to deprecacted marco,PTR_RET in the files,fb.c and pmu.c
      mach-omap2: Remove use of deprecated marco, PTR_RET in devices.c

Tony Lindgren (4):
      ARM: OMAP2+: Remove legacy booting support for cm-t35
      ARM: OMAP2+: Remove legacy booting support for Overo
      ARM: OMAP2+: Remove legacy booting support for Beagleboards
      Merge branch 'omap-for-v4.2/legacy' into omap-for-v4.2/cleanup

 arch/arm/mach-omap2/Kconfig             |  22 -
 arch/arm/mach-omap2/Makefile            |   3 -
 arch/arm/mach-omap2/board-cm-t35.c      | 769 --------------------------------
 arch/arm/mach-omap2/board-omap3beagle.c | 595 ------------------------
 arch/arm/mach-omap2/board-overo.c       | 571 ------------------------
 arch/arm/mach-omap2/devices.c           |   4 +-
 arch/arm/mach-omap2/fb.c                |   2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c    |   2 +-
 arch/arm/mach-omap2/pmu.c               |   2 +-
 arch/arm/mach-omap2/serial.c            |   2 +-
 10 files changed, 6 insertions(+), 1966 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-cm-t35.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 delete mode 100644 arch/arm/mach-omap2/board-overo.c
