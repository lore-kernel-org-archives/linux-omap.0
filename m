From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap-fixes (Re: [PATCH 0/8] Omap fixes for
	2.6.30-rc5)
Date: Fri, 15 May 2009 15:41:40 -0700
Message-ID: <20090515224139.GF19742@atomide.com>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZEOWlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 18:41:53 -0400
Content-Disposition: inline
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Russell,

* Tony Lindgren <tony@atomide.com> [090514 10:42]:
> Hi,
> 
> Here are some omap fixes for 2.6.30-rc5 for review.

Here's the pull request for you assuming you don't have any comments
for these fixes.

Regards,

Tony

--KdquIMZPjGJQvRdI
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

Tony Lindgren (2):
      ARM: OMAP2/3: Add name for musb clocks
      ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi, v2

Vikram Pandita (1):
      ARM: OMAP3: Fix number of GPIO lines for 34xx

 arch/arm/mach-omap2/clock24xx.c        |   10 +++++-----
 arch/arm/mach-omap2/clock34xx.c        |   12 ++++++------
 arch/arm/mach-omap2/clock34xx.h        |   12 ++++++------
 arch/arm/mach-omap2/devices.c          |    6 ++++--
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 arch/arm/mach-omap2/usb-tusb6010.c     |    2 +-
 arch/arm/plat-omap/fb.c                |    5 +++--
 arch/arm/plat-omap/gpio.c              |    2 +-
 drivers/video/omap/dispc.c             |   14 ++++++++------
 drivers/video/omap/rfbi.c              |    8 +++++---
 10 files changed, 40 insertions(+), 33 deletions(-)

--KdquIMZPjGJQvRdI--
