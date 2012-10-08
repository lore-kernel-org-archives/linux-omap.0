From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] ARM: OMAP: PM fixes for v3.7-rc
Date: Mon, 08 Oct 2012 15:24:01 -0700
Message-ID: <87391o8uwu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64464 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2JHWYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 18:24:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4417963pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 15:24:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the following OMAP PM fixes for v3.7-rc.

Thanks,

Kevin



The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-fixes-pm

for you to fetch changes up to ce3810cdb4ca31238c87e095d2c494a5eaa4f65d:

  ARM: OMAP: SmartReflex: fix error path in init function (2012-10-02 14:55:31 -0700)

----------------------------------------------------------------
OMAP PM related fixes for v3.7-rc

----------------------------------------------------------------
Jean Pihet (2):
      ARM: OMAP: SmartReflex: select CONFIG_POWER_SUPPLY in Kconfig
      ARM: OMAP: SmartReflex: fix error path in init function

Wei Yongjun (4):
      ARM: OMAP: fix return value check in beagle_opp_init()
      ARM: OMAP: omap_device: fix return value check in omap_device_build_ss()
      ARM: OMAP2+: SmartReflex: fix return value check in sr_dev_init()
      ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()

 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/pm.c                |    2 +-
 arch/arm/mach-omap2/sr_device.c         |    2 +-
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/omap_device.c        |    2 +-
 drivers/power/avs/smartreflex.c         |    8 ++++----
 6 files changed, 9 insertions(+), 8 deletions(-)
