From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.1-rc1
Date: Fri, 12 Aug 2011 01:10:57 -0700
Message-ID: <20110812081056.GP1939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38561 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932Ab1HLILB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 04:11:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap fixes for -rc1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git=
 fixes

Note that this also includes a trivial patch that adds the missing
UART4 defines used on some boards that would be good to get merged.
If you rather have that in a separate branch I can do that too.

Regards,

Tony


The following changes since commit 322a8b034003c0d46d39af85bf24fee27b90=
2f48:
  Linus Torvalds (1):
        Linux 3.1-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.g=
it fixes

Colin Cross (1):
      OMAP2+: PM: SmartReflex: use put_sync_suspend for IRQ-safe disabl=
ing

Hemant Pedanekar (1):
      omap: timer: Set dmtimer used as clocksource in autoreload mode

Johan Hovold (1):
      OMAP3: am3517crane: remove NULL board_mux from board file

Kevin Hilman (3):
      OMAP2+: Kconfig: don't select PM in OMAP2PLUS_TYPICAL
      OMAP1: enable GENERIC_IRQ_CHIP
      OMAP3: beagle: don't touch omap_device internals

Maxin John (1):
      arch:arm:plat-omap:iovmm: remove unused variable 'va'

Nishanth Menon (1):
      OMAP3+: SR: ensure pm-runtime callbacks can be invoked with IRQs =
disabled

Oleg Drokin (1):
      Update Nook Color machine 3284 to common Encore name

Paul Walmsley (1):
      OMAP: hwmod: fix build break on non-OMAP4 multi-OMAP2 builds

Peter Ujfalusi (1):
      OMAP: Fix linking error in twl-common.c for OMAP2/3/4 only builds

Rapha=C3=ABl Ass=C3=A9nat (1):
      am3505/3517: Various platform defines for UART4

Thomas Meyer (1):
      arm: mach-omap2: mux: use kstrdup()

Tony Lindgren (1):
      Merge branch 'for_3.1/pm-fixes' of git://git.kernel.org/.../khilm=
an/linux-omap-pm into fixes

 arch/arm/mach-omap2/Kconfig              |    1 -
 arch/arm/mach-omap2/board-am3517crane.c  |    2 -
 arch/arm/mach-omap2/board-omap3beagle.c  |   23 ++++-----
 arch/arm/mach-omap2/cminst44xx.h         |   25 +++++++++-
 arch/arm/mach-omap2/mux.c                |   14 ++----
 arch/arm/mach-omap2/smartreflex.c        |    3 +-
 arch/arm/mach-omap2/timer.c              |    3 +-
 arch/arm/mach-omap2/twl-common.c         |   78 ++++++++++++++++------=
--------
 arch/arm/plat-omap/Kconfig               |    1 +
 arch/arm/plat-omap/include/plat/dma.h    |    5 ++
 arch/arm/plat-omap/include/plat/irqs.h   |    1 +
 arch/arm/plat-omap/include/plat/serial.h |    3 +
 arch/arm/plat-omap/iovmm.c               |    3 -
 arch/arm/tools/mach-types                |    2 +-
 14 files changed, 94 insertions(+), 70 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
