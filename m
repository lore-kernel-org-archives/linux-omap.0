From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for omap-fixes, v2 (Re: [PATCH 0/8] Omap
	fixes for 2.6.30-rc5)
Date: Sat, 16 May 2009 08:41:21 -0700
Message-ID: <20090516154120.GM19742@atomide.com>
References: <20090514174100.12080.9736.stgit@localhost> <20090515224139.GF19742@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/Gk0KcsbyUMelFU1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZEPPld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 11:41:33 -0400
Content-Disposition: inline
In-Reply-To: <20090515224139.GF19742@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090515 15:42]:
> Russell,
> 
> * Tony Lindgren <tony@atomide.com> [090514 10:42]:
> > Hi,
> > 
> > Here are some omap fixes for 2.6.30-rc5 for review.
> 
> Here's the pull request for you assuming you don't have any comments
> for these fixes.

Updated pull request below with the dispc clkdev patch dropped.

Tony

--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 091bf7624d1c90cec9e578a18529f615213ff847:
  Linus Torvalds (1):
        Linux 2.6.30-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Jarkko Nikula (2):
      ARM: OMAP2: Fix tusb6010 init error and compilation warning
      ARM: OMAP2: Fix SPI driver failure on 2420 when running multi-omap config

Kalle Jokiniemi (1):
      ARM: OMAP3: Fix HW SAVEANDRESTORE shift define

Paul Walmsley (1):
      ARM: OMAP: GPIO de-bounce clocks don't affect module idle state

Tomi Valkeinen (1):
      ARM: OMAP: Fix printing of reserved memory for frambuffer

Tony Lindgren (1):
      ARM: OMAP2/3: Add name for musb clocks

Vikram Pandita (1):
      ARM: OMAP3: Fix number of GPIO lines for 34xx

 arch/arm/mach-omap2/clock24xx.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.h        |   12 ++++++------
 arch/arm/mach-omap2/devices.c          |    6 ++++--
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c     |    2 +-
 arch/arm/plat-omap/fb.c                |    5 +++--
 arch/arm/plat-omap/gpio.c              |    2 +-
 8 files changed, 18 insertions(+), 15 deletions(-)

--/Gk0KcsbyUMelFU1--
