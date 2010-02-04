From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for 2.6.33-rc6
Date: Thu, 4 Feb 2010 14:07:16 -0800
Message-ID: <20100204220716.GU22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62370 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab0BDWHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 17:07:20 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git=
 omap-fixes-for-linus

Regards,

Tony
The following changes since commit abe94c756c08d50566c09a65b9c7fe72f830=
71c5:
  Linus Torvalds (1):
        Linux 2.6.33-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.g=
it omap-fixes-for-linus

Kevin Hilman (2):
      OMAP2/3: IRQ: ensure valid base address
      OMAP2/3: GPMC: ensure valid clock pointer

Marek Skuczynski (1):
      omap: Fix access to already released memory in clk_debugfs_regist=
er_one()

Sriram (1):
      ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP

Tony Lindgren (4):
      omap: Remove old unused defines for OMAP_32KSYNCT_BASE
      omap: Fix 3630 mux errors
      omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
      omap: Disable serial port autoidle by default

Uwe Kleine-K=C3=B6nig (1):
      omap: define _toggle_gpio_edge_triggering only for OMAP1

 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-omap2/gpmc.c       |    5 +++-
 arch/arm/mach-omap2/irq.c        |    4 ++-
 arch/arm/mach-omap2/mux.c        |   10 +++++++-
 arch/arm/mach-omap2/mux34xx.c    |   47 ++++++++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/serial.c     |   11 +++++++-
 arch/arm/plat-omap/clock.c       |    4 +-
 arch/arm/plat-omap/gpio.c        |    4 +-
 arch/arm/plat-omap/omap_device.c |   10 --------
 9 files changed, 77 insertions(+), 19 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
