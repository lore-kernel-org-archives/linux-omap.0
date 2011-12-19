From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP3/4: miscellaneous hwmod data updates
Date: Mon, 19 Dec 2011 14:57:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112191456030.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53301 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab1LSV5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 16:57:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_data_b_devel_3.3

Ming Lei (1):
      ARM: OMAP4: hwmod data: introduce fdif(face detect module) hwmod

Peter Ujfalusi (1):
      ARM: OMAP4: hwmod data: Add names for DMIC memory address space

Shubhrajyoti D (1):
      ARM: OMAP3+: hwmod data: Add the default clockactivity for I2C

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   96 ++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 7 deletions(-)
