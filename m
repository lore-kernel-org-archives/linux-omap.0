From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM fixes for v3.5-rc
Date: Wed, 30 May 2012 16:24:42 -0700
Message-ID: <87ipfd45hh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54500 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab2E3XYr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 19:24:47 -0400
Received: by pbcwy7 with SMTP id wy7so761172pbc.17
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 16:24:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Here's a couple PM related fixes for v3.5-rc, based on your cleanup
branch.

Kevin


The following changes since commit 2c65e7440d56b3b285d1c95563b4dcce8e40dea3:

  GPMC: add ECC control definitions (2012-05-10 09:39:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/pm

for you to fetch changes up to 1ce029968718477149e7f1fb245a8e82c690cc4a:

  arm: omap3: am35x: Don't mark missing features as present (2012-05-11 16:47:19 -0700)

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP3: PM: fix shared PRCM interrupts: leave disabled at boot

Mark A. Greer (1):
      arm: omap3: am35x: Don't mark missing features as present

NeilBrown (1):
      ARM: OMAP2+: INTC: fix suspend abort, set IRQCHIP_SKIP_SET_WAKE

 arch/arm/mach-omap2/id.c           |   11 +++++++++++
 arch/arm/mach-omap2/irq.c          |    1 +
 arch/arm/mach-omap2/pm34xx.c       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   14 +++++++++++---
 4 files changed, 24 insertions(+), 3 deletions(-)


