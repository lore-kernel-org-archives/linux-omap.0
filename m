From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap hsmmc platform code changes for v3.3 merge window
Date: Mon, 12 Dec 2011 14:32:34 -0800
Message-ID: <20111212223234.GH32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33381 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab1LLWcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 17:32:39 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap hsmmc platform code changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hsmmc

Ideally arch/arm/mach-omap2/hsmmc.c file will completely
disappear with device tree, but looks like we're still
some more patches away from that. Meanwhile, these are
needed for various board files.

Regards,

Tony


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
  Linus Torvalds (1):
        Linux 3.2-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hsmmc

Abhilash K V (1):
      ARM: OMAP: hsmmc: Support for AM3517 MMC1 voltages

Eliad Peller (3):
      omap_hsmmc: consider MMC_PM_KEEP_POWER on suspend/resume
      ARM: OMAP: hsmmc: add pm_caps field
      ARM: OMAP: hsmmc: board-sdp4430: declare support for MMC_PM_KEEP_POWER

Igor Grinberg (1):
      ARM: OMAP: hsmmc: Add support for MMC 2 setup for AM35x

Thomas Weber (1):
      ARM: OMAP: hsmmc: Add support for non-OMAP pins

Vaibhav Hiremath (1):
      ARM: OMAP: hsmmc: Add support for AM3517EVM base-board MMC slot

 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/board-am3517evm.c |   22 ++++++++++++
 arch/arm/mach-omap2/hsmmc.c           |   59 ++++++++++++++++++++++++--------
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |   26 +++++++++-----
 6 files changed, 86 insertions(+), 24 deletions(-)
