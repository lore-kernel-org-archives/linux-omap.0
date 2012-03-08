From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for link
 array removal
Date: Wed, 7 Mar 2012 21:06:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58202 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab2CHEGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 23:06:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit b8a633451951d149494076393698880453bf6bfe:

  ARM: OMAP: hwmod: add softreset delay field and OMAP4 data (2012-02-28 03:46:31 -0700)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.4

for you to fetch changes up to a2d4b88dd32b02e8b5088e0d64b3c102c0852210:

  ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits (2012-02-28 03:49:34 -0700)

(This branch is based on the 'hwmod_code_cleanup_3.4' branch, pull req 
sent previously)


- Paul

----------------------------------------------------------------
Paul Walmsley (9):
      ARM: OMAP2/3: hwmod data: update old names
      ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
      ARM: OMAP3: hwmod data: add DSS->L3 interconnect for 3430ES1
      ARM: OMAP3: hwmod data: GPTIMER12 is attached to a separate interconnect
      ARM: OMAP36xx: hwmod data: fix SmartReflex interface data
      ARM: OMAP4: hwmod data: remove bandgap hwmod
      ARM: OMAP4: hwmod data: add OCP_USER_DSP; mark omap44xx_dsp__iva appropriately
      ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
      ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits

 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    4 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  137 ++++++++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   39 +-------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +-
 5 files changed, 121 insertions(+), 72 deletions(-)
