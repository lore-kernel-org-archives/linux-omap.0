From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 0/2] arm: omap3: am35x: Convert emac to hwmod & disable hlt when open
Date: Fri, 11 May 2012 14:12:56 -0700
Message-ID: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:55310 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761005Ab2EKVNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 17:13:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Paul, Kevin,

These patches convert the davinci emac support for the am35x SoC
to use hwmod and add enable_hlt()/disable_hlt() calls to the
pm_runtime hooks for that driver.

I have converted the davinci_emac driver to use pm_runtime but I
can't formally submit it yet since it requires some changes on the
mach-davinci side that haven't happened yet.  I will send it as an
RFC in a reply to this thread.

The patches are based on:
	git://git.pwsan.com/linux-2.6 am35xx_hwmod_data_fixes_a_3.5

Mark
--

Mark A. Greer (2):
  arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support
  arm: omap3: am35x: Disable hlt when using Davinci EMAC

 arch/arm/mach-omap2/am35xx-emac.c          |  120 ++++++++++++++++++----------
 arch/arm/mach-omap2/am35xx-emac.h          |   16 +++-
 arch/arm/mach-omap2/board-am3517evm.c      |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c       |    3 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/include/mach/am35xx.h  |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++++++++++++++++++++
 7 files changed, 183 insertions(+), 48 deletions(-)

-- 
1.7.9.4

