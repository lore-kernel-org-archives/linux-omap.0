From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2 0/2] arm: omap3: am35x: Convert emac to hwmod & disable hlt when open
Date: Tue, 15 May 2012 11:14:00 -0700
Message-ID: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:36963 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab2EOSOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 14:14:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

These patches convert the davinci emac support for the am35x SoC
to use hwmod and add enable_hlt()/disable_hlt() calls to the
pm_runtime hooks for that driver.

I have converted the davinci_emac driver to use pm_runtime but I
can't formally submit it yet since it requires some changes on the
mach-davinci side that haven't happened yet.  I will send it as an
RFC in a reply to this thread.

The patches are based on:
        git://git.pwsan.com/linux-2.6 am35xx_hwmod_data_fixes_a_3.5

Changes from v1:
- patch 1/2, "arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support"
  is unchanged
- patch 2/2, "arm: "omap3: am35x: Disable hlt when using Davinci EMAC"
  has been reworked to keep the code as simple as possible per
  http://www.spinics.net/lists/linux-omap/msg70354.html

Mark
--

Mark A. Greer (2):
  arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support
  arm: omap3: am35x: Disable hlt when using Davinci EMAC

 arch/arm/mach-omap2/am35xx-emac.c          |  116 ++++++++++++++++++----------
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/include/mach/am35xx.h  |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++++++++++++++++++++
 4 files changed, 163 insertions(+), 42 deletions(-)

-- 
1.7.9.4

