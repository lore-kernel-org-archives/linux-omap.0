From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/6] omap non-urgent fixes for v3.13 merge window
Date: Fri, 11 Oct 2013 18:44:57 -0700
Message-ID: <2485.35692594505$1381542326@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20643 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751742Ab3JLBpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 21:45:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-signed

for you to fetch changes up to 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:

  ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)

----------------------------------------------------------------
Fixes for omaps that were not considered urgent for the -rc series.
Just minor build fixes, removal of dead code, and a patch to
use the die ID for increasing boot time entropy.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: OMAP1: fix incorrect placement of __initdata tag

Linus Walleij (1):
      ARM: OMAP2+: throw the die id into the entropy pool

Majunath Goudar (1):
      ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations.

Michael Opdenacker (1):
      ARM: OMAP: remove deprecated IRQF_DISABLED

 arch/arm/mach-omap1/common.h   |  3 +++
 arch/arm/mach-omap1/fpga.c     |  3 +--
 arch/arm/mach-omap1/gpio15xx.c |  8 ++++----
 arch/arm/mach-omap1/gpio16xx.c | 22 +++++++++++-----------
 arch/arm/mach-omap1/gpio7xx.c  | 30 +++++++++++++++---------------
 arch/arm/mach-omap1/pm.c       |  1 -
 arch/arm/mach-omap1/time.c     |  2 +-
 arch/arm/mach-omap1/timer32k.c |  2 +-
 arch/arm/mach-omap2/id.c       | 12 ++++++++++++
 arch/arm/mach-omap2/timer.c    |  2 +-
 arch/arm/plat-omap/dma.c       |  1 -
 11 files changed, 49 insertions(+), 37 deletions(-)
