From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap fixes for 2.6.31, v2
Date: Mon, 10 Aug 2009 16:18:08 +0300
Message-ID: <20090810131808.GF1938@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost> <20090807090145.GA2358@atomide.com> <20090807090632.GA20011@n2100.arm.linux.org.uk> <20090807091348.GB2358@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbZHJNS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 09:18:27 -0400
Content-Disposition: inline
In-Reply-To: <20090807091348.GB2358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090807 12:14]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090807 12:06]:
> > On Fri, Aug 07, 2009 at 12:01:48PM +0300, Tony Lindgren wrote:
> > > Here's the pull request for you.
> > 
> > I'll hold off merging this for a bit - I've sent Linus two pull requests
> > over the last couple of weeks, both of which so far haven't produced a
> > reaction. It would be unfair for me to merge more stuff onto that branch
> > until Linus has pulled.
> 
> OK thanks.

Looks like I did not test this series enough.. I've updated it now for the
two patches as posted here earlier today. Updated pull request below.

Regards,

Tony


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit ed680c4ad478d0fee9740f7d029087f181346564:
  Linus Torvalds (1):
        Linux 2.6.31-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Janboe Ye (1):
      OMAP3: Fix omap3 sram virtual addres overlap vmalloc space after increasing vmalloc size

Roger Quadros (4):
      OMAP: GPIO: Fix incorrect gpio_get logic for output GPIOs
      OMAP3: RX51: Define TWL4030 USB transceiver in board file
      OMAP2/3: mmc-twl4030: Free up MMC regulators while cleaning up
      OMAP3: RX51: Updated rx51_defconfig

Sergio Aguirre (1):
      OMAP3: Overo: Fix smsc911x platform device resource value

Tony Lindgren (1):
      OMAP: Fix testing of cpu defines for mach-omap1

Vikram Pandita (1):
      OMAP2/3: DMA errata correction

 arch/arm/configs/rx51_defconfig              |    7 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +
 arch/arm/mach-omap2/mmc-twl4030.c            |    6 ++
 arch/arm/plat-omap/dma.c                     |    4 +-
 arch/arm/plat-omap/gpio.c                    |  121 +++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/cpu.h        |    5 -
 arch/arm/plat-omap/sram.c                    |    4 +-
 8 files changed, 110 insertions(+), 44 deletions(-)

--nHwqXXcoX0o6fKCv--
