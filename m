From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio
Date: Wed, 20 Jul 2016 00:13:29 -0400
Message-ID: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Alexandre Courbot <gnurou@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

While working on some for-4.9 cleanups of linux/gpio/driver.h it was
found that changes there caused build failures when walking all the
ARM defconfigs, in ARM specific mach-* files.

The proposed GPIO header change is just this:

 ---------------------------------------      
     --- a/include/linux/gpio/driver.h
     +++ b/include/linux/gpio/driver.h
     @@ -3,7 +3,6 @@
      
      #include <linux/device.h>
      #include <linux/types.h>
     -#include <linux/module.h>
      #include <linux/irq.h>
      #include <linux/irqchip/chained_irq.h>
      #include <linux/irqdomain.h>
     @@ -16,6 +15,7 @@ struct of_phandle_args;
      struct device_node;
      struct seq_file;
      struct gpio_device;
     +struct module;
      
      #ifdef CONFIG_GPIOLIB
 ---------------------------------------      

...which is what we've already got in ~50 other include/linux/* files to
try and keep cross contamination entanglement at a minimum.

So we uncovered three users in ARM specific files relying on the above
presence in this header, vs. dealing with it within the driver itself.

But with ARM and GPIO being different subsystems, we'll need to get
this in ARM 1st, and then wait a release before changing the GPIO
header, otherwise we'll risk triggering these three build failures.

So, if folks consider these three trivial changes OK for late in the
for-4.8 cycle, then great.  Otherwise I'll resubmit the ARM parts for
for-4.9 and the GPIO bits for the one after that.

[Yes, there were gpio implicit users too, but they are easily sync'd
with the gpio header change being at the end of that series.]

Paul.
--

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>

Paul Gortmaker (3):
  ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals
  ARM: pxa: add module.h for corgi symbol_get/symbol_put usage
  ARM: pxa: add module.h for spitz symbol_get/symbol_put usage

 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 +-
 arch/arm/mach-pxa/corgi.c                    | 1 +
 arch/arm/mach-pxa/spitz.c                    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.8.4
