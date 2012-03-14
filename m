From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod: remove link arrays
Date: Wed, 14 Mar 2012 02:38:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203140231150.7269@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab2CNIiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 04:38:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit 5f43ef65748c19b954756485ddaef657ac71b649:

  Merge branch 'hwmod_misc_devel_3.4' into MERGE_sr_and_hwmod_data (2012-03-08 21:03:17 -0700)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_remove_link_arrays_cleanup_3.4

for you to fetch changes up to afce19b152eedea0402561087dd939b23b53f3cb:

  ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-03-08 21:04:50 -0700)

The base commit for this pull request is a merge of your SR branch with 
the 'hwmod_misc_devel_3.4' branch, since this series has dependencies on 
both of those.


- Paul

----------------------------------------------------------------
Paul Walmsley (12):
      ARM: OMAP2+: hwmod: add _find_mpu_rt_port()
      ARM: OMAP2+: hwmod: add function to iterate over struct omap_hwmod_ocp_if
      ARM: OMAP2+: hwmod: consolidate finding the MPU port index and storing it
      ARM: OMAP2+: hwmod: add support for link registration
      ARM: OMAP2+: hwmod data: convert to link registration
      ARM: OMAP: hwmod: remove code support for direct hwmod registration
      ARM: OMAP2+: hwmod data: remove forward declarations, reorganize
      ARM: OMAP2xxx: hwmod data: share common hwmods between OMAP2420 and OMAP2430
      ARM: OMAP2xxx: hwmod data: share common interface data
      ARM: OMAP3: hwmod data: fix IVA interface clock
      ARM: OMAP3: hwmod data: add IVA hard reset lines, main clock, clockdomain
      ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP

 arch/arm/mach-omap2/omap_hwmod.c                   |  410 ++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         | 1563 +-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         | 2316 +++-------
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  266 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  562 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 5081 +++++++++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 4882 ++++++++-----------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   71 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   31 +-
 9 files changed, 6341 insertions(+), 8841 deletions(-)
