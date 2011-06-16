From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Thu, 16 Jun 2011 09:07:39 -0700
Message-ID: <87r56trc8k.fsf@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
	<20110527032439.GK5032@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40986 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335Ab1FPQHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:07:45 -0400
Received: by mail-pv0-f182.google.com with SMTP id 11so2068093pvg.27
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:07:43 -0700 (PDT)
In-Reply-To: <20110527032439.GK5032@ponder.secretlab.ca> (Grant Likely's
	message of "Thu, 26 May 2011 21:24:39 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
>> Start moving SoC-specific register handling out of the driver by passing
>> in register offsets in via platform data.
>> 
>> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
>> 
>> Applies on top of Tony's for-next branch (which include's the generic
>> IRQ chip work from tglx) and the OMAP GPIO driver move to
>> drivers/gpio.
>
> Hey Kevin,
>
> If you've got a branch with this series in it and tested, then I'd be
> happy to pull that instead of applying the patches myself.
>

OK, I rebased this on v3.0-rc2 and now it's been through quite a bit
more testing.

Here's a branch for you.

Also FYI, we'll probably have 2nd round of GPIO cleanups/updates and
runtime PM conversion for the upcoming merge window too.

Kevin

The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:

  Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/gpio-cleanup

Charulatha V (1):
      GPIO: OMAP: remove get_gpio_bank()

Kevin Hilman (13):
      GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
      GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
      GPIO: OMAP: move bank width into struct gpio_bank
      GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with bank->width
      GPIO: OMAP: replace get_gpio_index() by using bank width
      GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
      GPIO: OMAP: consolidate IRQ status handling, remove #ifdefs
      GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
      GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
      GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
      GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
      GPIO: OMAP: debounce remove SoC specific registers, use pdata
      GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once

 arch/arm/mach-omap1/gpio15xx.c         |   22 +
 arch/arm/mach-omap1/gpio16xx.c         |   28 ++
 arch/arm/mach-omap1/gpio7xx.c          |   27 ++
 arch/arm/mach-omap2/gpio.c             |   32 ++
 arch/arm/plat-omap/include/plat/gpio.h |   20 +
 drivers/gpio/gpio-omap.c               |  723 +++++++-------------------------
 6 files changed, 282 insertions(+), 570 deletions(-)


