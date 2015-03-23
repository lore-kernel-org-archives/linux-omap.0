From: <grygorii.strashko@linaro.org>
Subject: [PATCH v2 0/8] gpio: omap: cleanup: get rid of system GPIO <-> GPIO offset converseations
Date: Mon, 23 Mar 2015 14:18:22 +0200
Message-ID: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

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

Tested on:
- dra7-evm.
- omap1 (osk5912), 770 and E3.

Last two patches have to be tested on OMAP1:
-  gpio: omap: get rid of omap_irq_to_gpio()
-  gpio: omap: get rid of GPIO_INDEX() macro

Based on top of Linux 4.0-rc4 plus patch
'[PATCH 1/2] gpio: omap: irq_shutdown: remove unnecessary call of gpiochip_unlock_as_irq'
http://www.spinics.net/lists/linux-omap/msg116482.html

Changes in v2:
- fixed build failure with Patch 5, no functional code
  changes.

Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org> 
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

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

