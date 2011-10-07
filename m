From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Thu, 6 Oct 2011 18:07:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42313 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790Ab1JGAHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 20:07:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2

Archit Taneja (1):
      ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in bootloader

Tomi Valkeinen (9):
      ARM: OMAP2xxx: HWMOD: Fix DSS reset
      ARM: OMAP2xxx: HWMOD: fix DSS clock data
      ARM: OMAP3: HWMOD: Fix DSS reset
      ARM: OMAP3: HWMOD: fix DSS clock data
      ARM: OMAP4: HWMOD: remove extra clocks
      ARM: OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
      ARM: OMAP4: HWMOD: fix DSS clock data
      ARM: OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      ARM: OMAP: HWMOD: Unify DSS resets for OMAPs

 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/display.c                      |  160 ++++++++++++++++++++
 arch/arm/mach-omap2/display.h                      |   29 ++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   17 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   17 ++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   37 ++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   24 ++--
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    4 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
 arch/arm/plat-omap/include/plat/common.h           |    3 +
 include/video/omapdss.h                            |    7 -
 12 files changed, 277 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.h
