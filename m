From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] ARM: OMAP: SR cleanups for v3.4
Date: Mon, 05 Mar 2012 14:02:08 -0800
Message-ID: <87wr6yiu5b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40901 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754473Ab2CEWCL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:02:11 -0500
Received: by mail-pw0-f50.google.com with SMTP id xa12so400218pbc.23
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 14:02:09 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Please pull the SmartReflex cleanups for v3.4.

Due to a minor conflict with the devexit patches in your randconfig
branch, this is based there (actually randconfig~2 which is the actual
dependency.)

Special thanks to Jean Pihet for collecting and coordinating all these
fixups.

Kevin


The following changes since commit 149f1d5c8d2fd6879cdf93ca70f1cb745e698a1e:

  ARM: OMAP2+: Fix devexit for smartreflex when CONFIG_HOTPLUG is not set (2012-02-24 08:24:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/sr

for you to fetch changes up to 63371faf9198302c7ebd41e7fbe78eb6b57bba86:

  ARM: OMAP3+: SmartReflex: fix error handling (2012-03-05 11:29:27 -0800)

----------------------------------------------------------------
Felipe Balbi (4):
      ARM: OMAP3+: SmartReflex: add missing platform_set_drvdata()
      ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
      ARM: OMAP3+: SmartReflex: misc cleanups
      ARM: OMAP3+: SmartReflex: micro-optimization for sanity check

Jean Pihet (2):
      ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
      ARM: OMAP3+: SmartReflex: fix error handling

Nishanth Menon (6):
      ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
      ARM: OMAP3+: SmartReflex Class3: disable errorgen before disable VP
      ARM: OMAP3+: SmartReflex: Add a shutdown hook
      ARM: OMAP3+: SmartReflex: Fix status masking in ERRCONFIG register
      ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
      ARM: OMAP3+: hwmod: add SmartReflex IRQs

Shweta Gulati (1):
      ARM: OMAP3+: SmartReflex: use voltage domain name in device attributes

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   31 +++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++-
 arch/arm/mach-omap2/smartreflex-class3.c     |    1 +
 arch/arm/mach-omap2/smartreflex.c            |  227 +++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h            |   10 ++
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 229 insertions(+), 72 deletions(-)

