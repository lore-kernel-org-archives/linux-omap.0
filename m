From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] non-critical omap fixes for v3.12 merge window
Date: Thu, 22 Aug 2013 22:46:10 -0700
Message-ID: <20130823054609.GW7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30728 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3HWFqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 01:46:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/fixes-non-critical-signed

for you to fetch changes up to af0721966195b3966214edd54af0d5f84d65419a:

  ARM: OMAP2: use 'int' instead of 'unsigned' for variable 'gpmc_irq_start' (2013-08-22 00:56:26 -0700)

----------------------------------------------------------------
Omap fixes for the merge window that are not urgent enough
for the -rc series.

----------------------------------------------------------------
Chen Baozi (1):
      ARM: OMAP2+: fix wrong address when loading PRM_FRAC_INCREMENTOR_DENUMERATOR_RELOAD

Chen Gang (2):
      ARM: OMAP2: remove useless variable 'ret'
      ARM: OMAP2: use 'int' instead of 'unsigned' for variable 'gpmc_irq_start'

Ezequiel Garcia (1):
      ARM: OMAP2: Use a consistent AM33XX SoC option description

Matus Ujhelyi (1):
      ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards

Peter Ujfalusi (1):
      ARM: OMAP2+: Remove legacy device creation for McPDM and DMIC

Wei Yongjun (1):
      ARM: OMAP: dma: fix error return code in omap_system_dma_probe()

 arch/arm/mach-omap2/Kconfig             |  2 +-
 arch/arm/mach-omap2/am33xx-restart.c    |  4 ++--
 arch/arm/mach-omap2/board-am3517crane.c |  2 --
 arch/arm/mach-omap2/devices.c           | 40 ---------------------------------
 arch/arm/mach-omap2/gpmc.c              |  2 +-
 arch/arm/mach-omap2/timer.c             |  2 +-
 arch/arm/plat-omap/dma.c                |  1 +
 7 files changed, 6 insertions(+), 47 deletions(-)
