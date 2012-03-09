From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod: miscellaneous changes for 3.4
Date: Thu, 8 Mar 2012 20:57:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203082056230.26656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54575 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab2CID5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 22:57:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit bb887688bccb48d94fa873f0f6cc7e7e3e4dc05e:

  Merge branch 'for_3.4/cleanup/sr' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into sr (2012-03-05 14:25:35 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_misc_devel_3.4

for you to fetch changes up to 7ef827505cbc58660ee18e5c4080ed8072022162:

  ARM: OMAP2+: hwmod: manage the wake-up latency constraints (2012-03-08 20:04:45 -0700)


- Paul


----------------------------------------------------------------
Jean Pihet (1):
      ARM: OMAP2+: hwmod: manage the wake-up latency constraints

Paul Walmsley (1):
      ARM: OMAP36xx: hwmod data: fix SmartReflex interface data

 arch/arm/mach-omap2/omap_hwmod.c             |   54 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   54 +++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++
 3 files changed, 98 insertions(+), 15 deletions(-)
