From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] omap fixes for 2.6.35-rc2
Date: Tue, 08 Jun 2010 15:03:05 +0300
Message-ID: <20100608120104.24902.36055.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56721 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0FHMDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 08:03:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few omap fixes for review. I've moved anything that's not
absolutely needed as a fix into for-next as requested by Linus.

Regards,

Tony

---

Amit Kucheria (1):
      omap: fix build failure due to missing include dma-mapping.h

Kevin Hilman (2):
      omap: GPIO: fix auto-disable of debounce clock
      OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg

Santosh Shilimkar (1):
      omap: Stalker board: switch over to gpio_set_debounce

Tero Kristo (1):
      omap: DMTIMER: Ack pending interrupt always when stopping a timer


 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 arch/arm/mach-omap2/pm34xx.c             |    4 ++--
 arch/arm/mach-omap2/usb-ehci.c           |    2 ++
 arch/arm/plat-omap/dmtimer.c             |    6 +++---
 arch/arm/plat-omap/gpio.c                |    1 +
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
Signature
