From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v3] OMAP: clock/powerdomain/clockdomain/hwmod: fixes for
 3.1-rc
Date: Sun, 4 Sep 2011 20:26:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109042023190.9056@utopia.booyaka.com>
References: <alpine.DEB.2.00.1108222319310.28226@utopia.booyaka.com> <alpine.DEB.2.00.1108230105180.28226@utopia.booyaka.com> <alpine.DEB.2.00.1108300104010.26173@utopia.booyaka.com> <alpine.DEB.2.00.1109011751370.26025@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47059 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1IEC0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 22:26:35 -0400
In-Reply-To: <alpine.DEB.2.00.1109011751370.26025@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, santosh.shilimkar@ti.com

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 prcm-fixes-a-3.1rc

This update adds a patch for a missing array terminator in the OMAP2430 
hwmod data.

Paul Walmsley (5):
      OMAP4: clock: re-enable previous clockdomain enable/disable sequence
      OMAP4: clock: fix compile warning
      OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in the WKUP clockdomain
      OMAP2430: hwmod: musb: add missing terminator to omap2430_usbhsotg_addrs[]
      Merge branches 'non_hwmod_compliant_fix_3.1rc', 'omap3_clock_fixes_3.1rc', 'omap4_clock_fixes_3.1rc', 'missing_2430_musb_adds_terminator_fix_3.1rc' and 'pwrdm_clkdm_fixes_3.1rc' into prcm-fixes-a-3.1rc

Rajendra Nayak (1):
      OMAP: powerdomains: Make all powerdomain target states as ON at init

Santosh Shilimkar (1):
      OMAP: clockdomain: Wait for powerdomain to be ON when using clockdomain force wakeup

 arch/arm/mach-omap2/clock3xxx_data.c       |    2 ++
 arch/arm/mach-omap2/clock44xx_data.c       |   10 +++++++++-
 arch/arm/mach-omap2/clockdomain.c          |    2 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/pm.c                   |    2 --
 arch/arm/mach-omap2/powerdomain.c          |   25 ++++++++++++++++---------
 6 files changed, 30 insertions(+), 12 deletions(-)

