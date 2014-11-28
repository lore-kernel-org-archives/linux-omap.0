From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] move omap gpmc to drivers finally
Date: Fri, 28 Nov 2014 13:39:16 -0800
Message-ID: <20141128213915.GV2817@atomide.com>
References: <20141126194330.GN2817@atomide.com>
 <201411281228.52786.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48999 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaK1Vll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 16:41:41 -0500
Content-Disposition: inline
In-Reply-To: <201411281228.52786.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

* Arnd Bergmann <arnd@arndb.de> [141128 03:31]:
> On Wednesday 26 November 2014, Tony Lindgren wrote:
> >
> > We can finally move the GPMC code to live in drivers/memory
> > for further clean up work. This series does the move with
> > minimal changes to the code.
> 
> I just looked at this branch. It's definitely nice to move the code
> to drivers/memory, but I don't like the idea of having lots of function
> declarations and internal data structures in a linux/platform_data/*.h
> file. We can still merge this for 3.19, but I want to make sure you have
> a plan for getting rid of this (and put that into the tag description).
> 
> Does this header file get removed once all non-DT board files are gone?

Yes that will become driver internal data at that point.
 
> How about moving the declarations into include/linux/omap-gpmc.h instead?

OK. Below is an updated pull request with the platform_data/omap-gpmc.h
dropped.

Regards,

Tony

8< -------------------
The following changes since commit 6f8782a7a1c826e1c013d6b7d5504af6bcc079e6:

  ARM: OMAP2+: Remove unnecesary include in GPMC driver (2014-11-06 10:51:06 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gpmc-move-v2

for you to fetch changes up to 186401937927426f85a28bd798e82ca18e4e5549:

  memory: gpmc: Move omap gpmc code to live under drivers (2014-11-28 12:54:39 -0800)

----------------------------------------------------------------
We can finally move the GPMC code to live in drivers/memory for
further clean up work.

Note that we still have dependencies to the legacy booting for
omap3 board-*.c files for setting up the board specific memory
timings. For that we need the timing related things still exposed
in include/linux/omap-gpmc.h. This will all become private data
to the GPMC driver once the legacy booting support can be dropped.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: OMAP2+: Prepare to move GPMC to drivers by platform data header
      ARM: OMAP2+: Move GPMC initcall to devices.c
      memory: gpmc: Move omap gpmc code to live under drivers

 MAINTAINERS                                        |   8 +
 arch/arm/mach-omap2/Kconfig                        |   2 +
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-am3517crane.c            |   1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |   3 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |   3 +-
 arch/arm/mach-omap2/board-flash.c                  |   3 +-
 arch/arm/mach-omap2/board-flash.h                  |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   3 +-
 arch/arm/mach-omap2/devices.c                      |  26 +++
 arch/arm/mach-omap2/gpmc-nand.c                    |   3 +-
 arch/arm/mach-omap2/gpmc-nand.h                    |  27 ---
 arch/arm/mach-omap2/gpmc-onenand.c                 |   3 +-
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 ---
 arch/arm/mach-omap2/gpmc.h                         | 227 +--------------------
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 .../gpmc.c => drivers/memory/omap-gpmc.c           |  90 +++++---
 include/linux/omap-gpmc.h                          | 199 ++++++++++++++++++
 22 files changed, 316 insertions(+), 324 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-nand.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c (95%)
 create mode 100644 include/linux/omap-gpmc.h
