From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP3/4: hwmod data changes for 3.3
Date: Fri, 16 Dec 2011 04:25:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160423360.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35596 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1LPLZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 06:25:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

Here are some hwmod data changes for the 3.3 merge window.  Note that they 
have a dependency on the 3.2-rc hwmod data fixes.  Once those are merged, 
I'd be happy to update this pull request on a stable commit.

The following changes since commit 91a36bdb3ada99ebf3a613a0dab2d741445ffd7f:

  ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot (2011-12-15 22:38:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_data_devel_3.3

Benoit Cousson (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP4

Keshava Munegowda (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP3

Kyle Manna (1):
      ARM: OMAP: hwmod data: Add support for AM35xx UART4/ttyO3

Paul Walmsley (1):
      ARM: OMAP3: hwmod data: disable multiblock reads on MMC1/2 on OMAP34xx/35xx <= ES2.1

Shubhrajyoti D (1):
      ARM: OMAP3+: hwmod data: Add the default clockactivity for I2C

 arch/arm/mach-omap2/clock3xxx_data.c       |   11 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  374 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  217 ++++++++++++++++-
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +-
 arch/arm/plat-omap/include/plat/serial.h   |    1 +
 6 files changed, 594 insertions(+), 13 deletions(-)
