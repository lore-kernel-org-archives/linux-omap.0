From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for merge window
Date: Thu, 29 Mar 2012 11:56:27 -0700
Message-ID: <20120329185626.GY9859@atomide.com>
References: <20120321180536.GK9859@atomide.com>
 <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
 <20120329144151.GS9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22874 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710Ab2C2S4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 14:56:31 -0400
Content-Disposition: inline
In-Reply-To: <20120329144151.GS9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

* Tony Lindgren <tony@atomide.com> [120329 07:44]:
> * Olof Johansson <olof@lixom.net> [120328 22:04]:
> > Hi Tony,
> > 
> > On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > Hi Arnd & Olof,
> > >
> > > Here's a set of fixes that would be nice to get merged during
> > > the merge window before the GPIO changes get merged to avoid
> > > boot issues on many omap boards.
> > >
> > > The changes queued in the GPIO tree require getting rid of
> > > OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
> > > dynamically allocated GPIO interrupt ranges.
> > 
> > Sorry for the slow response on this, we've been focused on getting the
> > main pulls going in. I'm about to start a fixes branch now and looked
> > at this pull request.
> > 
> > I replied to one of the original patches in this branch, they need to
> > be fixed before they can go in:
> > 
> > http://marc.info/?l=linux-omap&m=133299716528617&w=2
> 
> Thanks, that's a good catch.
>  
> > Also, that way we can get a clean branch based on current mainline
> > without merge conflicts.
> 
> Yes will do.

Olof, here's an updated pull request for your fixes staging branch.

This contains the updated gpio_to_irq patches from Tarun, and a trivial
build fix from Govindraj to #include <asm/system_misc.h> in pm.c.
The DSI mux patch is the same.

Note that the branch name is now just fixes as the necessary commits
are now all in the mainline tree.

Regards,

Tony


The following changes since commit 0195c00244dc2e9f522475868fa278c473ba7339:
  Linus Torvalds (1):
        Merge tag 'split-asm_system_h-for-linus-20120328' of git://git.kernel.org/.../dhowells/linux-asm_system

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Govindraj.R (1):
      ARM: OMAP: pm: fix compilation break

Tarun Kanti DebBarma (3):
      ARM: OMAP: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
      drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq() in ams_delta_serio_exit()
      ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition

Tomi Valkeinen (1):
      ARM: OMAP2+: Remove __init from DSI mux functions

Tony Lindgren (2):
      Merge branch 'fix-dss-mux' into fixes
      Merge branch 'fixes-gpio-to-irq' into fixes

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
 arch/arm/mach-omap1/pm.c                     |    1 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    4 ++--
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 arch/arm/mach-omap2/display.c                |    8 ++++----
 arch/arm/mach-omap2/pm.c                     |    2 ++
 arch/arm/plat-omap/include/plat/gpio.h       |    4 ----
 drivers/input/serio/ams_delta_serio.c        |    2 +-
 26 files changed, 55 insertions(+), 55 deletions(-)
