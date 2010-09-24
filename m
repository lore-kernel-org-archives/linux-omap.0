From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] omap patches for review for v2.6.37 merge window
Date: Thu, 23 Sep 2010 18:50:38 -0700
Message-ID: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57493 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab0IXBul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap patches that have not yet been posted to
linux-arm-kernel for review.

Regards,

Tony

---

Anand Gadiyar (1):
      omap: usb: fix build warning

Dmitry Kasatkin (1):
      omap: crypto: updates to enable omap aes

Jarkko Nikula (4):
      omap: n8x0: Cleanup i2c1 and menelaus registration
      omap: n8x0: Register i2c2 and add board info with tlv320aic3xfor N810
      omap: n8x0: Mux i2s codec port pins for McBSP block
      omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and docleanups

Peter Ujfalusi (1):
      omap: McBSP: Do not enable SRG in slave mode

Sanjeev Premi (1):
      omap2: fix assorted compiler warnings

Subramaniam C.A (1):
      omap: i2c: Avoid compilation error in case the header is included multiple times

Sukumar Ghorai (1):
      omap: mmc: extended to pass host capabilities from board file

Yogesh Marathe (1):
      omap3: Remove non-existent config option


 arch/arm/mach-omap2/board-2430sdp.c          |    3 +
 arch/arm/mach-omap2/board-3430sdp.c          |    5 +
 arch/arm/mach-omap2/board-4430sdp.c          |    4 +
 arch/arm/mach-omap2/board-cm-t35.c           |    5 +
 arch/arm/mach-omap2/board-devkit8000.c       |    3 +
 arch/arm/mach-omap2/board-igep0020.c         |    5 +
 arch/arm/mach-omap2/board-ldp.c              |    3 +
 arch/arm/mach-omap2/board-n8x0.c             |   51 ++++++++++-----
 arch/arm/mach-omap2/board-omap3beagle.c      |    3 +
 arch/arm/mach-omap2/board-omap3evm.c         |    3 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    7 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    3 +
 arch/arm/mach-omap2/board-omap3touchbook.c   |    3 +
 arch/arm/mach-omap2/board-omap4panda.c       |    4 -
 arch/arm/mach-omap2/board-overo.c            |    5 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    5 +
 arch/arm/mach-omap2/clock2420_data.c         |    2 -
 arch/arm/mach-omap2/clock2430_data.c         |    2 -
 arch/arm/mach-omap2/clock3xxx_data.c         |    2 -
 arch/arm/mach-omap2/devices.c                |   87 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/hsmmc.c                  |   16 +++--
 arch/arm/mach-omap2/hsmmc.h                  |    3 +
 arch/arm/mach-omap2/mcbsp.c                  |   39 ------------
 arch/arm/mach-omap2/mux.c                    |    2 -
 arch/arm/mach-omap2/omap-iommu.c             |    2 -
 arch/arm/plat-omap/gpio.c                    |    4 +
 arch/arm/plat-omap/include/plat/i2c.h        |    4 +
 arch/arm/plat-omap/include/plat/mmc.h        |    7 +-
 arch/arm/plat-omap/include/plat/usb.h        |    2 -
 arch/arm/plat-omap/mcbsp.c                   |   13 ++--
 drivers/mmc/host/omap.c                      |    2 -
 drivers/mmc/host/omap_hsmmc.c                |   18 +----
 33 files changed, 190 insertions(+), 132 deletions(-)

-- 
Signature
