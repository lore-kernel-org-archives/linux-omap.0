From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] omap fixes for 2.6.33-rc4
Date: Wed, 20 Jan 2010 13:23:29 -0800
Message-ID: <20100120212248.25335.55761.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54441 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab0ATVXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 16:23:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Roel Kluin (1):
      OMAP: dma_chan[lch_head].flag & OMAP_DMA_ACTIVE tested twice in omap_dma_unlink_lch()

Tony Lindgren (3):
      omap: Fix cmdline muxing
      omap: Fix functions for dynamic remuxing of pins
      omap3: Fix cpu detection


 arch/arm/mach-omap2/id.c              |   41 +++++++++++++++++++--------------
 arch/arm/mach-omap2/mux.c             |   27 ++++++++++++----------
 arch/arm/mach-omap2/mux.h             |   24 +++++++++++++++++++
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |    1 +
 5 files changed, 64 insertions(+), 31 deletions(-)

-- 
Signature
