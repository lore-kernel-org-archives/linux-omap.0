From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] minimal omap4460 support for v3.1 merge window
Date: Sat, 9 Jul 2011 23:56:27 -0700
Message-ID: <20110710065627.GE5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20971 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751007Ab1GJG4a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 02:56:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arnd@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

Hi Arnd,

Please pull minimal omap4460 support from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git 4460

Regards,

Tony


The following changes since commit 48cb1258e8b0f8c81cfb699b42326c5b2147b3f8:
  Tony Lindgren (1):
        Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git 4460

Aneesh V (2):
      OMAP: ID: introduce chip detection for OMAP4460
      OMAP4: ID: add omap_has_feature for max freq supported

Rajendra Nayak (2):
      OMAP4: PRCM: OMAP4460 specific PRM and CM register bitshifts
      OMAP4: clocks: Update the clock tree with 4460 clock nodes

 arch/arm/mach-omap2/clock44xx_data.c          |   39 ++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-44xx.h         |   36 +++++++++++++++++
 arch/arm/mach-omap2/id.c                      |   53 ++++++++++++++++++++----
 arch/arm/mach-omap2/prm-regbits-44xx.h        |    8 ++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    2 +
 arch/arm/plat-omap/include/plat/cpu.h         |   35 +++++++++++++++-
 7 files changed, 162 insertions(+), 12 deletions(-)
