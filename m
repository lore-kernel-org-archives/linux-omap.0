From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP3+: PRM/hwmod: fix and improve I/O chain wakeup
 support
Date: Mon, 12 Mar 2012 04:15:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203120413530.11332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53590 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab2CLKPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 06:15:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 io_chain_devel_3.4

for you to fetch changes up to efd360a8902101148f4fc6325097b94ae1fbb451:

  ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle (2012-03-12 04:11:48 -0600)


- Paul

----------------------------------------------------------------
Mohan V (1):
      ARM: OMAP3: PM: correct enable/disable of daisy io chain

Rajendra Nayak (1):
      ARM: OMAP4: PRM: Add IO Daisychain support

Tero Kristo (1):
      ARM: OMAP3+: PRM: Enable IO wake up

Vishwanath BS (3):
      ARM: OMAP3: PM: Move IO Daisychain function to omap3 prm file
      ARM: OMAP3PLUS: hwmod: reconfigure IO Daisychain during hwmod mux
      ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle

 arch/arm/mach-omap2/omap_hwmod.c   |   37 +++++++++++++++++++++-
 arch/arm/mach-omap2/pm34xx.c       |   44 --------------------------
 arch/arm/mach-omap2/prcm-common.h  |    8 +++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   51 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    2 +
 arch/arm/mach-omap2/prm44xx.c      |   60 +++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h      |    2 +
 7 files changed, 156 insertions(+), 48 deletions(-)
