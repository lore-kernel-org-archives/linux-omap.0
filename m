From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP2+: clock/MPU prcm: patches for the 2.6.38-rc series
Date: Fri, 25 Feb 2011 13:16:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251315190.6198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102221958190.22636@utopia.booyaka.com> <20110224202157.GG20560@atomide.com> <alpine.DEB.2.00.1102241330500.6198@utopia.booyaka.com> <20110224211328.GK20560@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44901 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab1BYUQR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 15:16:17 -0500
In-Reply-To: <20110224211328.GK20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 patches_for_2.6.38rc

John Ogness (1):
      OMAP2/3: clock: fix fint calculation for DPLL_FREQSEL

Santosh Shilimkar (1):
      omap4: prcm: Fix the CPUx clockdomain offsets

 arch/arm/mach-omap2/clkt_dpll.c    |    2 +-
 arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


- Paul

