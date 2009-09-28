From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for 2.6.32-rc1
Date: Mon, 28 Sep 2009 16:58:31 -0700
Message-ID: <20090928235831.GJ18957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63720 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbZI1X6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 19:58:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Linus,

Please pull the omap-fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony



The following changes since commit 94e0fb086fc5663c38bbc0fe86d698be8314f82f:
  Linus Torvalds (1):
        Merge branch 'drm-intel-next' of git://git.kernel.org/.../anholt/drm-intel

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Ajay Kumar Gupta (1):
      omap: Add missing mux pin for EHCI phy reset line

Angelo Arrifano (2):
      omap: Fix wrong jtag_id for 850
      omap: Fix a OMAP_MPUIO_VBASE typo for 850

Hiroshi DOYU (3):
      omap: mailbox: Execute softreset at startup
      omap: mailbox: Flush posted write when acking mailbox irq
      omap: Fix wrong condition check in while loop for mailbox and iommu2

Jarkko Nikula (1):
      omap: Fix MMC gpio_wp for BeagleBoard C2 and above

Sanjeev Premi (1):
      omap: iovmm: Fix compiler warning

Tobias Klauser (1):
      omap: rng: Use resource_size instead of manual calculation

Tony Lindgren (4):
      omap: Fix compile for arch/arm/mach-omap2
      omap: Fix mcspi compile for 2420
      omap: Fix 44xx compile
      omap: Fix matrix_keymap_data usage

 arch/arm/mach-omap1/id.c                     |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   10 +++-
 arch/arm/mach-omap2/board-ldp.c              |   10 +++-
 arch/arm/mach-omap2/board-omap3beagle.c      |    7 ++-
 arch/arm/mach-omap2/board-omap3evm.c         |   10 +++-
 arch/arm/mach-omap2/board-omap3pandora.c     |   10 +++-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   10 +++-
 arch/arm/mach-omap2/board-zoom2.c            |   10 +++-
 arch/arm/mach-omap2/cm4xxx.c                 |   17 +------
 arch/arm/mach-omap2/devices.c                |   65 +++++++++++++++++++-------
 arch/arm/mach-omap2/io.c                     |    4 +-
 arch/arm/mach-omap2/iommu2.c                 |    2 +-
 arch/arm/mach-omap2/mailbox.c                |   33 +++++++++++--
 arch/arm/mach-omap2/mux.c                    |    4 ++
 arch/arm/mach-omap2/serial.c                 |    6 +-
 arch/arm/plat-omap/gpio.c                    |    2 +-
 arch/arm/plat-omap/include/mach/keypad.h     |    5 +-
 arch/arm/plat-omap/include/mach/mux.h        |    2 +
 arch/arm/plat-omap/iovmm.c                   |    5 +-
 drivers/char/hw_random/omap-rng.c            |    4 +-
 20 files changed, 147 insertions(+), 71 deletions(-)
