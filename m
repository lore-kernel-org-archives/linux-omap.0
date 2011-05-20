From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Fri, 20 May 2011 17:14:43 +0200
Message-ID: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33456 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933183Ab1ETPPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:03 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2802721wya.19
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Start moving SoC-specific register handling out of the driver by passing
in register offsets in via platform data.

Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.

Applies on top of Tony's for-next branch (which include's the generic
IRQ chip work from tglx) and the OMAP GPIO driver move to
drivers/gpio.

Charulatha V (1):
  GPIO: OMAP: remove get_gpio_bank()

Kevin Hilman (13):
  GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
  GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
  GPIO: OMAP: move bank width into struct gpio_bank
  GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with
    bank->width
  GPIO: OMAP: replace get_gpio_index() by using bank width
  GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
  GPIO: OMAP: consolidate IRQ status handling, remove #ifdefs
  GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
  GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
  GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
  GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
  GPIO: OMAP: debounce remove SoC specific registers, use pdata
  GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only
    once

 arch/arm/mach-omap1/gpio15xx.c         |   22 +
 arch/arm/mach-omap1/gpio16xx.c         |   28 ++
 arch/arm/mach-omap1/gpio7xx.c          |   27 ++
 arch/arm/mach-omap2/gpio.c             |   32 ++
 arch/arm/plat-omap/include/plat/gpio.h |   20 +
 drivers/gpio/gpio_omap.c               |  723 +++++++-------------------------
 6 files changed, 282 insertions(+), 570 deletions(-)

-- 
1.7.3.4

