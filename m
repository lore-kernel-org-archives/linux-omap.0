From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP PRCM/clocksource/clockdomain fixes for 2.6.38-rc
Date: Tue, 18 Jan 2011 12:47:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101181244310.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45116 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab1ARTr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 14:47:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

These changes fix the clocksource oops on boot, reduce the amount of 
now-unnecessary warning backtraces on OMAP4-only configs, and remove some 
warnings from 'make includecheck'.

The following changes since commit e78bf5e6cbe837daa6ab628a5f679548742994d3:

  drivers/nfc/pn544.c: fix min_t warnings (2011-01-16 17:28:21 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 fixes_a_2.6.38rc

Felipe Balbi (1):
      OMAP: PRCM: remove duplicated headers

Paul Walmsley (2):
      OMAP: counter_32k: init clocksource as part of machine timer init
      OMAP4: clockdomain: bypass unimplemented wake-up dependency functions on OMAP4

 arch/arm/mach-omap1/time.c                  |    7 ++++++
 arch/arm/mach-omap2/clock44xx_data.c        |    1 -
 arch/arm/mach-omap2/clockdomain.c           |   30 +++++++++++++++++++++++---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 -
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    1 -
 arch/arm/mach-omap2/timer-gp.c              |   10 +++++++-
 arch/arm/plat-omap/counter_32k.c            |    3 +-
 arch/arm/plat-omap/include/plat/common.h    |    1 +
 8 files changed, 43 insertions(+), 12 deletions(-)


- Paul
