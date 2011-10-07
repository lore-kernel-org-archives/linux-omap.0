From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: PRCM/SCM/hwmod miscellaneous fixes for 3.2
Date: Fri, 7 Oct 2011 03:19:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110070318120.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43579 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759703Ab1JGJTl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 05:19:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 prcm_scm_misc_fixes_3.2

Abhilash K V (1):
      ARM: OMAP: AM35x: remove hwmods that aren't generic

Archit Taneja (1):
      ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields

 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   13 ++++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)


- Paul
