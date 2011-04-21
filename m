From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/9] OMAP: GPIO: cleanup, consolidation, etc. (v2)
Date: Thu, 21 Apr 2011 13:35:18 -0700
Message-ID: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54828 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754192Ab1DUUdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:36 -0400
Received: by mail-pz0-f53.google.com with SMTP id 3so61249pzk.12
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com

Here's an updated version of my work-in-progress GPIO cleanups.

I now understand that others have some similar work in progress, so
these are posted (to linux-omap only, for now) so that we can begin
collaboration on the GPIO cleanups.

This series applies on top of v2.6.39-rc4 plus the generic irq_chip
series from Thomas Gleixner since in addition to the cleanups, I
started moving the GPIO IRQ handling over to use generic irq_chip
(last patch in series.)

This work in progress is available in my wip/gpio-cleanup branch.

Kevin Hilman (9):
  OMAP: GPIO: _clear_gpio_irqbank: fix flushing of posted write
  OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
  OMAP: GPIO: move bank width into struct gpio_bank
  OMAP: GPIO: _get_gpio_irqbank_mask: replace hard-coded mask with
    bank->width
  OMAP: GPIO: move register offset defines into gpio.h
  OMAP: GPIO: consolidate direction, input, output, remove #ifdefs
  OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
  OMAP: GPIO: conslidate enable/disable of GPIO IRQs, remove ifdefs
  OMAP: GPIO: convert MPUIO IRQ over to generic irq_chip

 arch/arm/mach-omap1/gpio15xx.c         |   13 +
 arch/arm/mach-omap1/gpio16xx.c         |   22 ++
 arch/arm/mach-omap1/gpio7xx.c          |   21 +
 arch/arm/mach-omap2/gpio.c             |   20 +
 arch/arm/plat-omap/gpio.c              |  641 ++++++--------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  120 ++++++
 6 files changed, 318 insertions(+), 519 deletions(-)

-- 
1.7.4

