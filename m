From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod/timer: first set of cleanups for 3.4
Date: Wed, 7 Mar 2012 21:02:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203072054470.12760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37530 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab2CHECO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 23:02:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony 

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_code_cleanup_3.4

for you to fetch changes up to b8a633451951d149494076393698880453bf6bfe:

  ARM: OMAP: hwmod: add softreset delay field and OMAP4 data (2012-02-28 03:46:31 -0700)


- Paul

----------------------------------------------------------------
Fernando Guzman Lugo (1):
      ARM: OMAP: hwmod: add softreset delay field and OMAP4 data

Paul Walmsley (8):
      ARM: OMAP2+: hwmod: control all hardreset lines attached to a hwmod
      ARM: OMAP4: hwmod data: remove pseudo-hwmods associated with hardreset lines
      ARM: OMAP2+: hwmod: reorganize and document the setup process
      ARM: OMAP2+: hwmod: revise hardreset behavior
      ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are reprogrammed after a reset
      ARM: OMAP2+: hwmod: provide a function to return the address space of the MPU RT
      ARM: OMAP2+: hwmod: add omap_hwmod_get_resource_byname()
      ARM: OMAP2+: timer: use a proper interface to get hwmod data

 arch/arm/mach-omap2/omap_hwmod.c             |  674 +++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  119 +----
 arch/arm/mach-omap2/timer.c                  |   15 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +-
 4 files changed, 544 insertions(+), 270 deletions(-)
