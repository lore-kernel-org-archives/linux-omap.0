From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap-fixes for v2.6.32-rc6
Date: Thu, 12 Nov 2009 10:36:26 -0800
Message-ID: <20091112183626.GY24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64277 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbZKLSga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 13:36:30 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e13a:
  Linus Torvalds (1):
        Linux 2.6.32-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Grazvydas Ignotas (2):
      omap3: pandora: Fix keypad keymap
      omap3: update Pandora defconfig

Janusz Krzysztofik (2):
      omap: Fix omapfb/lcdc on OMAP1510 broken when PM set
      omap1: Amstrad Delta defconfig fixes

Jarkko Nikula (1):
      omap3: beagle: Fix USB host port power control

Mike Turquette (1):
      omap3: Decrease cpufreq transition latency

Sergio Aguirre (1):
      omap3: 3430sdp: Enable Linux Regulator framework

Tao Hu (1):
      omap: Fix race condition in omap dma driver

Tobias Klauser (1):
      omap: Use resource_size

 arch/arm/configs/ams_delta_defconfig     |   24 +++++++---
 arch/arm/configs/omap3_pandora_defconfig |   49 +++++++++++++++++--
 arch/arm/configs/omap_3430sdp_defconfig  |    9 +++-
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |   78 +++++++++++++++---------------
 arch/arm/mach-omap2/gpmc.c               |    2 +-
 arch/arm/mach-omap2/mailbox.c            |    2 +-
 arch/arm/plat-omap/cpu-omap.c            |    2 +-
 arch/arm/plat-omap/dma.c                 |   14 +++++
 9 files changed, 126 insertions(+), 56 deletions(-)
