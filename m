From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP3: hwmod data fixes for 3.2-rc
Date: Fri, 16 Dec 2011 01:21:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160120040.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50365 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1LPIVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 03:21:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_data_fixes_3.2rc

Aaro Koskinen (1):
      ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot

Felipe Contreras (1):
      ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)
