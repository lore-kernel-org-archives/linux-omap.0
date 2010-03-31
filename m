From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP clock/hwmod fixes for 2.6.34-rc
Date: Wed, 31 Mar 2010 07:32:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003310731500.14436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32997 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933335Ab0CaNcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 09:32:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

The following changes since commit 2eaa9cfdf33b8d7fb7aff27792192e0019ae8fc6:
  Linus Torvalds (1):
        Linux 2.6.34-rc3

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.34rc_a

Rajendra Nayak (1):
      OMAP4: prcm: Use logical OR instead of bitwise OR

Ranjith Lohithakshan (1):
      OMAP3: clock: fix enable bit used for dpll4_m4x2 clock

Thara Gopinath (2):
      OMAP: HWMOD: Adding clockdomain check
      OMAP: HWMOD: Bug fixes in hwmod structure definitions

 arch/arm/mach-omap2/clock3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/clockdomain.c            |    6 +++---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/mach-omap2/powerdomain.c            |    2 +-
 arch/arm/mach-omap2/prcm.c                   |    4 ++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)


- Paul
