From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] omap fixes for v2.6.32-rc4
Date: Tue, 13 Oct 2009 17:13:28 -0700
Message-ID: <20091014001233.6116.84749.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58449 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761551AbZJNAOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 20:14:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few omap fixes for review.

Regards,

Tony

---

Aaro Koskinen (1):
      omap: RX-51: Drop I2C-1 speed to 2200

Anuj Aggarwal (1):
      omap: SDMA: Fixing bug in omap_dma_set_global_params()

Jarkko Nikula (1):
      omap: McBSP: Fix incorrect receiver stop in omap_mcbsp_stop

Roel Kluin (1):
      omap: Fix Unlikely(x) < y

Sanjeev Premi (1):
      omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig

Teerth Reddy (1):
      omap: Initialization of SDRC params on Zoom2


 arch/arm/configs/omap3_beagle_defconfig      |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom2.c            |    4 +++-
 arch/arm/plat-omap/dma.c                     |   15 +++++++++------
 arch/arm/plat-omap/gpio.c                    |    2 +-
 arch/arm/plat-omap/mcbsp.c                   |    2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

-- 
Signature
