From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
Date: Mon, 10 Oct 2011 18:43:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com> <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52588 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab1JKAnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 20:43:35 -0400
In-Reply-To: <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com, keshava_mgowda@ti.com

Hi Tony

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2

This pull request drops the EHCI/OHCI hwmod data due to some 
inconsistencies that were just found in the data.

Santosh Shilimkar (1):
      ARM: OMAP4: clock: Add CPU local timer clock node.

 arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

- Paul
