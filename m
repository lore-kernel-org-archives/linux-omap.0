From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod/PRM: miscellaneous patches for 3.4
Date: Mon, 12 Mar 2012 05:01:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203120500260.11332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49195 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2CLLBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 07:01:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 misc_devel_3.4

for you to fetch changes up to 553e322282655f213d131903ce7019aa25880273:

  ARM: OMAP4: prm: fix interrupt register offsets (2012-03-12 04:30:02 -0600)


- Paul
----------------------------------------------------------------
Rajendra Nayak (1):
      ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK

Tero Kristo (1):
      ARM: OMAP4: prm: fix interrupt register offsets

 arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
 arch/arm/mach-omap2/prm44xx.c    |   21 +++++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)
