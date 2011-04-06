From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM fixes for 2.6.39-rc
Date: Wed, 06 Apr 2011 08:26:36 -0700
Message-ID: <87sjtvieoj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51611 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756487Ab1DFP0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 11:26:43 -0400
Received: by mail-iy0-f171.google.com with SMTP id 20so1938179iyi.2
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 08:26:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Please pull the following OMAP PM fixes for the 2.6.39-rc fixes cycle.

Thanks,

Kevin

The following changes since commit 6221f222c0ebf1acdf7abcf927178f40e1a65e2a:

  Linux 2.6.39-rc2 (2011-04-05 18:30:43 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-fixes

Aaro Koskinen (5):
      OMAP3+: smartreflex: fix sr_late_init() error path in probe
      OMAP3+: smartreflex: request the memory region
      OMAP3+: smartreflex: fix ioremap leak on probe error
      OMAP3+: smartreflex: delete instance from sr_list on probe error
      OMAP3+: smartreflex: delete debugfs entries on probe error

Nishanth Menon (3):
      OMAP3+: voltage: remove initial voltage
      OMAP3+: voltage: remove spurious pr_notice for debugfs
      OMAP4: PM: remove redundant #ifdef CONFIG_PM

Shweta Gulati (1):
      OMAP4: Intialize IVA Device in addition to DSP device.

 arch/arm/mach-omap2/pm.c          |    1 +
 arch/arm/mach-omap2/pm44xx.c      |    2 --
 arch/arm/mach-omap2/smartreflex.c |   23 ++++++++++++++++++-----
 arch/arm/mach-omap2/voltage.c     |    2 --
 4 files changed, 19 insertions(+), 9 deletions(-)
