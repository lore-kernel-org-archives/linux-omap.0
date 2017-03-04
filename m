From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/12] gpio: use resource management for irq descriptors
Date: Sat,  4 Mar 2017 17:23:28 +0100
Message-ID: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The following series uses the recently introduced set of
devm_irq_alloc_desc*() helpers in the GPIO drivers.

While we're at it: if the modified drivers called request_irq(), it
was changed to devm_request_irq() too.

Some drivers correctly clean up resources (e.g. gpio-mockup,
gpio-pch) - for them this change leads to an actual code shrink.

Other drivers are meant to be built-in and the devices they control
are never removed (e.g. gpio-pxa, gpio-davinci), so they deliberately
omit the cleanup. Still: in case something changes it's better to free
the resources - especially since these drivers already use other
devm_* routines like devm_kzalloc() etc.

The last group of drivers are the ones which can be compiled as
modules, but leak resources unintentionally (e.g. gpio-twl4030,
gpio-omap). This change fixes the interrupt descriptor leaks, but some
drivers will require additional work since they still don't release
other resources.

The following drivers were tested: gpio-mockup, gpio-omap
and gpio-davinci. The rest was compile-tested only.

Bartosz Golaszewski (12):
  gpio: mockup: use devm_irq_alloc_descs()
  gpio: twl4030: use devm_irq_alloc_descs()
  gpio: omap: use devm_irq_alloc_descs()
  gpio: pch: use resource management for irqs
  gpio: ml-ioh: use resource management for irqs
  gpio: xlp: use resource management for irqs
  gpio: pxa: use devm_irq_alloc_descs()
  gpio: davinci: use devm_irq_alloc_descs()
  gpio: sodaville: use resource management for irqs
  gpio: mxc: use devm_irq_alloc_descs()
  gpio: mxs: use devm_irq_alloc_descs()
  gpio: sta2x11: use resource management for irqs

 drivers/gpio/gpio-davinci.c   |  2 +-
 drivers/gpio/gpio-ml-ioh.c    | 28 +++++++---------------------
 drivers/gpio/gpio-mockup.c    | 16 +---------------
 drivers/gpio/gpio-mxc.c       |  6 ++----
 drivers/gpio/gpio-mxs.c       |  6 ++----
 drivers/gpio/gpio-omap.c      |  3 ++-
 drivers/gpio/gpio-pch.c       | 14 ++++----------
 drivers/gpio/gpio-pxa.c       |  2 +-
 drivers/gpio/gpio-sodaville.c | 28 +++++++++++-----------------
 drivers/gpio/gpio-sta2x11.c   | 17 ++++++-----------
 drivers/gpio/gpio-twl4030.c   |  3 ++-
 drivers/gpio/gpio-xlp.c       |  8 ++++----
 12 files changed, 43 insertions(+), 90 deletions(-)

-- 
2.9.3

