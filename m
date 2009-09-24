From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Omap fixes for 2.6.32-rc1
Date: Thu, 24 Sep 2009 16:31:37 -0700
Message-ID: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61800 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZIXXbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:31:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Ajay Kumar Gupta (1):
      omap: Add missing mux pin for EHCI phy reset line

Angelo Arrifano (2):
      omap: Fix a OMAP_MPUIO_VBASE typo for 850
      omap: Fix wrong jtag_id for 850

Hiroshi DOYU (2):
      omap: mailbox: Flush posted write when acking mailbox irq
      omap: mailbox: Execute softreset at startup

Jarkko Nikula (1):
      omap: Fix MMC gpio_wp for BeagleBoard C2 and above

Sanjeev Premi (1):
      omap: iovmm: Fix compiler warning

Tobias Klauser (1):
      omap: rng: Use resource_size instead of manual calculation

Tony Lindgren (4):
      omap: Fix matrix_keymap_data usage
      omap: Fix 44xx compile
      omap: Fix mcspi compile for 2420
      omap: Fix compile for arch/arm/mach-omap2


 arch/arm/mach-omap1/id.c                     |    2 -
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
 arch/arm/mach-omap2/mailbox.c                |   33 +++++++++++--
 arch/arm/mach-omap2/mux.c                    |    4 ++
 arch/arm/mach-omap2/serial.c                 |    6 +-
 arch/arm/plat-omap/gpio.c                    |    2 -
 arch/arm/plat-omap/include/mach/keypad.h     |    5 +-
 arch/arm/plat-omap/include/mach/mux.h        |    2 +
 arch/arm/plat-omap/iovmm.c                   |    5 +-
 drivers/char/hw_random/omap-rng.c            |    4 +-
 19 files changed, 146 insertions(+), 70 deletions(-)

-- 
Signature
