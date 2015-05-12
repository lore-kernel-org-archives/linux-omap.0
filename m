From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.1-rc3
Date: Mon, 11 May 2015 19:39:07 -0700
Message-ID: <20150512023907.GE3409@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50460 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbbELCjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 22:39:10 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit e7309c2673a389a495fcfad70376d3bae8b9bc89:

  bus: omap_l3_noc: Fix master id address decoding for OMAP5 (2015-05-04 10:21:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc2

for you to fetch changes up to e60a8fe1792dcd3aacda0959e0f4865bfefb7bb5:

  Merge tag 'for-v4.1-rc/omap-fixes-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.1/fixes (2015-05-11 13:23:19 -0700)

----------------------------------------------------------------
Few fixes for omap clocks, PRM and hwmod code:

- Fix bogus comparison of struct clk pointers, turns out
  we can fix it by just removing the comparison

- Fix am437 hardreset implementation and remove boottime
  warnings by adding the VPFE hwmod data

- Regression fix for am43xx PRM code, simplify things
  by reusing the omap4 PRM implementation

----------------------------------------------------------------
Benoit Parrot (1):
      ARM: AM43xx: hwmod: add VPFE hwmod entries

Tero Kristo (2):
      ARM: OMAP4+: PRM: add support for passing status register/bit info to reset
      ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality

Tony Lindgren (2):
      ARM: OMAP2+: Remove bogus struct clk comparison for timer clock
      Merge tag 'for-v4.1-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.1/fixes

 arch/arm/mach-omap2/omap_hwmod.c           | 68 ++++++-----------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 70 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  3 +-
 arch/arm/mach-omap2/prminst44xx.c          | 20 +++------
 arch/arm/mach-omap2/timer.c                | 13 +++---
 5 files changed, 98 insertions(+), 76 deletions(-)
