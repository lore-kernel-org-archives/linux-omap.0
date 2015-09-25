From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] convert to use generic irq handler
Date: Fri, 25 Sep 2015 12:28:01 -0700
Message-ID: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Austin Schuh <austin@peloton-tech.com>, philipp@peloton-tech.com, linux-rt-users@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series contains patches which fixes wrong APIs usage in atomic
context on RT-kernel. The final goal is to make TI OMAP GPIO driver
compatible with -RT kernel as much as possible.

Patch 1: required to be compatible with -RT kernel, because PM runtime's
irq_safe mode is incompatible with -RT.
Patch 2: This patch converts TI OMAP GPIO driver to use generic irq
 handler instead of chained IRQ handler. This way OMAP GPIO driver will be
 compatible with RT-kernel where it will be forced thread IRQ handler
 while in non-RT kernel it still will be executed in HW IRQ context.

Boot, basic gpio functionality tested on:
 dra7-evm, BeagleBone(white), am43xx-gpevm, am437x-sk
Manually tested on dra7-evm including suspend/resume and wakeup.

Links on RFC:
 https://lkml.org/lkml/2015/8/18/161
 https://lkml.org/lkml/2015/8/18/162

Grygorii Strashko (2):
  gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
  gpio: omap: convert to use generic irq handler

 drivers/gpio/gpio-omap.c | 80 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

-- 
2.5.1

