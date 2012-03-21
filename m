From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for merge window
Date: Wed, 21 Mar 2012 11:05:37 -0700
Message-ID: <20120321180536.GK9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53677 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab2CUSFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:05:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Hi Arnd & Olof,

Here's a set of fixes that would be nice to get merged during
the merge window before the GPIO changes get merged to avoid
boot issues on many omap boards.

The changes queued in the GPIO tree require getting rid of
OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
dynamically allocated GPIO interrupt ranges.

Ideally these changes would have been done way earlier of course.
Unfortunately this issue was not discovered until last week while
testing linux-next.

Also included is one fix for the wrong __init changes for display.c.

This branch is based on the previously merged fixes-non-critical-part3
as that's pretty much the earliest point where these apply.

Note that these might add on a bit to the existing trivial
merge conflicts with drivers/video related board file clean-up
queued by Tomi.

Regards,

Tony


The following changes since commit 4647ca5761f5534470e98d06494403a2fd0d7b32:
  Tony Lindgren (1):
        ARM: OMAP2+: Fix build for omap4 only builds with missing include of linux/bug.h

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup-fixes

Tarun Kanti DebBarma (3):
      ARM: OMAP: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
      drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq() in ams_delta_serio_exit()
      ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition

Tomi Valkeinen (1):
      ARM: OMAP2+: Remove __init from DSI mux functions

 arch/arm/mach-omap1/board-h2.c               |    8 ++++----
 arch/arm/mach-omap1/board-h3.c               |    9 ++++-----
 arch/arm/mach-omap1/board-htcherald.c        |    6 +++---
 arch/arm/mach-omap1/board-innovator.c        |    4 ++--
 arch/arm/mach-omap1/board-nokia770.c         |    2 +-
 arch/arm/mach-omap1/board-osk.c              |   12 ++++++------
 arch/arm/mach-omap1/board-palmte.c           |    2 +-
 arch/arm/mach-omap1/board-palmtt.c           |    2 +-
 arch/arm/mach-omap1/board-palmz71.c          |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c        |   16 +++++++---------
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    6 ++++--
 arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 arch/arm/mach-omap2/display.c                |    8 ++++----
 arch/arm/plat-omap/include/plat/gpio.h       |    4 ----
 drivers/input/serio/ams_delta_serio.c        |    2 +-
 24 files changed, 55 insertions(+), 55 deletions(-)
