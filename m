From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP hwmod/PRCM/clock: patches for 2.6.39-rc
Date: Fri, 29 Apr 2011 12:33:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104291232450.18555@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56688 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab1D2Sdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 14:33:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit 8e10cd74342c7f5ce259cceca36f6eba084f5d58:

  Linux 2.6.39-rc5 (2011-04-26 20:48:50 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 for_tony_a_2.6.39rc

Avinash.H.M (1):
      OMAP2/3: hwmod: fix gpio-reset timeouts seen during bootup.

Benoit Cousson (1):
      OMAP2+: hwmod data: Fix wrong dma_system end address

Eduardo Valentin (2):
      OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on scratchpad area
      OMAP3: PM: Do not rely on ROM code to restore CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL

Tomi Valkeinen (1):
      OMAP4: clock data: Change DSS clock aliases

 arch/arm/mach-omap2/clock44xx_data.c       |    9 ++-------
 arch/arm/mach-omap2/cm2xxx_3xxx.c          |   17 +++++++++++++++++
 arch/arm/mach-omap2/control.c              |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 7 files changed, 45 insertions(+), 12 deletions(-)

