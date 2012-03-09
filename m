From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
Date: Thu, 8 Mar 2012 20:55:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203082054210.26656@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54561 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab2CIDzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 22:55:16 -0500
In-Reply-To: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit b8a633451951d149494076393698880453bf6bfe:

  ARM: OMAP: hwmod: add softreset delay field and OMAP4 data (2012-02-28 03:46:31 -0700)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.4

for you to fetch changes up to 79218825caa10594ac132c87daf3ff6f7ab87b64:

  ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits (2012-03-08 19:45:34 -0700)

This second version drops the SmartReflex fixup patch.


- Paul

----------------------------------------------------------------
Paul Walmsley (8):
      ARM: OMAP2/3: hwmod data: update old names
      ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
      ARM: OMAP3: hwmod data: add DSS->L3 interconnect for 3430ES1
      ARM: OMAP3: hwmod data: GPTIMER12 is attached to a separate interconnect
      ARM: OMAP4: hwmod data: remove bandgap hwmod
      ARM: OMAP4: hwmod data: add OCP_USER_DSP; mark omap44xx_dsp__iva appropriately
      ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
      ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits

 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    4 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   83 +++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   39 ++-----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +-
 5 files changed, 81 insertions(+), 58 deletions(-)
