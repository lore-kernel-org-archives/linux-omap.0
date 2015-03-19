From: <grygorii.strashko@linaro.org>
Subject: [PATCH 0/8] gpio: omap: cleanup: get rid of system GPIO <-> GPIO offset converseations
Date: Thu, 19 Mar 2015 19:25:36 +0200
Message-ID: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36592 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbCSRZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 13:25:55 -0400
Received: by lamx15 with SMTP id x15so68057318lam.3
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 10:25:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now in TI OMAP GPIO driver there are a lot of places where
System GPIO number calculated and then converted to GPIO offset.
What is worse is that in many place such conversation performed twice
or even three times. But actually, we don't need to do that at all, because
- gpiolib always passes GPIO offset to GPIO controller
- OMAP GPIO driver converted to use IRQ domain, so
  struct irq_data->hwirq contains GPIO offset

Hence, it is safe to convert all GPIO OMAP functions to use GPIO
offset instead of system GPIO numbers. Also, this allows to remove
unneeded conversations routines
 #define GPIO_INDEX(bank, gpio)
 #define GPIO_BIT(bank, gpio)
 int omap_irq_to_gpio()

Tested on dra7-evm.

Last two patches have to be tested on OMAP1:
-  gpio: omap: get rid of omap_irq_to_gpio()
-  gpio: omap: get rid of GPIO_INDEX() macro

Based on top of Linux 4.0-rc4 plus patch
'[PATCH 1/2] gpio: omap: irq_shutdown: remove unnecessary call of gpiochip_unlock_as_irq'
http://www.spinics.net/lists/linux-omap/msg116482.html

Grygorii Strashko (8):
  gpio: omap: convert omap_gpio_is_input() to use gpio offset
  gpio: omap: simplify omap_set_gpio_dataout_x()
  gpio: omap: convert debounce functions switch to use gpio offset
  gpio: omap: drop 'gpio' param from omap_gpio_init_irq()
  gpio: omap: convert gpio irq functions to use GPIO offset
  gpio: omap: get rid of GPIO_BIT() macro
  gpio: omap: get rid of omap_irq_to_gpio()
  gpio: omap: get rid of GPIO_INDEX() macro

 drivers/gpio/gpio-omap.c | 130 ++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 75 deletions(-)

-- 
1.9.1

