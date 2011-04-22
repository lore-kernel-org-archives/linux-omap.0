From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 00/15] OMAP: GPIO: clean up: pass register offsets via pdata
Date: Fri, 22 Apr 2011 16:01:52 -0700
Message-ID: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41536 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754267Ab1DVXAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:03 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so2080953pvc.25
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Begin cleanup and consolidation of OMAP GPIO driver by starting the
removal of SoC specifics (ifdefs, cpu_is-* checks, etc.)  The primary
method for this is by passing register offsets for common
functionality via platform_data, so the driver can be generic.

This series currently handles the GPIO direction, data in/out, IRQ
status and IRQ enable/disable functions, but does not yet handle the
IRQ triggering and suspend/resume handling.  That will be coming next.

I'll not be working on this for the next week, so anyone who wants to
build on this is more than welcome.

This work in progress is available in my wip/gpio-cleanup branch.

This series applies on top of v2.6.39-rc4 plus the generic irq_chip
series from Thomas Gleixner since in addition to the cleanups, I
started moving the GPIO IRQ handling over to use generic irq_chip
(last patch in series.)

Yes, there is much about OMAP GPIOs that is common to GPIO handling on
other SoCs.  However, before we can consolidate with other SoCs, the
first step is to consolidate to a single, clean driver for all OMAPs.
After that, we can start looking at consolidation with other SoCs.

Charulatha V (1):
  OMAP: GPIO: remove get_gpio_bank()

Kevin Hilman (14):
  OMAP: GPIO: _clear_gpio_irqbank: fix flushing of posted write
  OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
  OMAP: GPIO: move bank width into struct gpio_bank
  OMAP: GPIO: _get_gpio_irqbank_mask: replace hard-coded mask with
    bank->width
  OMAP: GPIO: replace get_gpio_index() by using bank width
  OMAP: GPIO: move register offset defines into gpio.h
  OMAP: GPIO: consolidate direction, input, output, remove #ifdefs
  OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
  OMAP: GPIO: conslidate enable/disable of GPIO IRQs, remove ifdefs
  OMAP: GPIO: convert MPUIO IRQ over to generic irq_chip
  OMAP: GPIO: remove useless gpio_valid() & check_gpio() checks
  OMAP: GPIO: cleanup _set_gpio_wakeup(), remove ifdefs
  OMAP: GPIO: debounce remove SoC specific registers, use pdata
  OMAP: GPIO: cleanup show revision, remove cpu_is checks, display only
    once

 arch/arm/mach-omap1/gpio15xx.c         |   22 +
 arch/arm/mach-omap1/gpio16xx.c         |   28 ++
 arch/arm/mach-omap1/gpio7xx.c          |   27 +
 arch/arm/mach-omap2/gpio.c             |   32 ++
 arch/arm/plat-omap/gpio.c              |  825 ++++++--------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  123 +++++
 6 files changed, 384 insertions(+), 673 deletions(-)

-- 
1.7.4

