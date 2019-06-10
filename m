From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 00/20]  gpio: gpio-omap: set of fixes and big clean-up
Date: Mon, 10 Jun 2019 20:10:43 +0300
Message-ID: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus, Russell, Tony, All,

This series contains set of patches from Russell King which were circulated
internally for quite some time already and I fill it's reasonable to move
future discussion upstream (and also avoid rebasing).
Fisrt two patches are fixes and the rest are big, great clean up
from Russell King.

Personally, I like this clean up and refactoring very much and don't want
it to be lost.

Code can be found at:
 git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git
branch:
 lkml-next-gpio-clean-up

Russell King (20):
  gpio: gpio-omap: ensure irq is enabled before wakeup
  gpio: gpio-omap: fix lack of irqstatus_raw0 for OMAP4
  gpio: gpio-omap: remove remainder of list management
  gpio: gpio-omap: clean up edge interrupt handling
  gpio: gpio-omap: remove irq_ack method
  gpio: gpio-omap: move omap_gpio_request() and omap_gpio_free()
  gpio: gpio-omap: simplify omap_gpio_get_direction()
  gpio: gpio-omap: simplify get() method
  gpio: gpio-omap: simplify get_multiple()
  gpio: gpio-omap: simplify set_multiple()
  gpio: gpio-omap: simplify bank->level_mask
  gpio: gpio-omap: simplify read-modify-write
  gpio: gpio-omap: simplify omap_toggle_gpio_edge_triggering()
  gpio: gpio-omap: simplify omap_set_gpio_irqenable()
  gpio: gpio-omap: remove dataout variation in context handling
  gpio: gpio-omap: clean up omap_gpio_restore_context()
  gpio: gpio-omap: constify register tables
  gpio: gpio-omap: clean up wakeup handling
  gpio: gpio-omap: irq_startup() must not return error codes
  gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()

 drivers/gpio/gpio-omap.c                | 497 ++++++++----------------
 include/linux/platform_data/gpio-omap.h |   2 +-
 2 files changed, 161 insertions(+), 338 deletions(-)

-- 
2.17.1
