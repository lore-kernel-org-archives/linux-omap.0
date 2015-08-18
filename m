From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Tue, 18 Aug 2015 14:10:51 +0300
Message-ID: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This patch series contains set of trivial fixes and improvements, and also
patches which fixes wrong APIs usage in atomic context as for -RT as for
non-RT kernel. The final goal of this series is to make TI OMAP GPIO
driver compatible with -RT kernel as much as possible.

Patch 1-4: trivial fixes and improvements
Patch 5: fixes wrong CLK clk_prepare/unprepare APIs usage in atomic contexet
Patch 6(rfc): required to be compatible with -RT kernel, because PM runtime
 can't be used in atimic context on -RT.
Patch 7(rfc): This patch converts TI OMAP GPIO driver to use generic irq
 handler instead of chained IRQ handler. This way OMAP GPIO driver will be
 compatible with RT kernel where it will be forced thread IRQ handler
 while in non-RT kernel it still will be executed in HW IRQ context.

Based on 
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
branch: devel
commit: 929550b gpio: mxc: fix section mismatch warning

Boot, basic gpio functionality tested on:
 dra7-evm, BeagleBone(white), am43xx-gpevm, am437x-sk
Manually tested on dra7-evm including suspend/resume and wakeup.

Grygorii Strashko (7):
  gpio: omap: remove wrong irq_domain_remove usage in probe
  gpio: omap: switch to use platform_get_irq
  gpio: omap: fix omap2_set_gpio_debounce
  gpio: omap: protect regs access in omap_gpio_irq_handler
  gpio: omap: fix clk_prepare/unprepare usage
  gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
  gpio: omap: convert to use generic irq handler

 drivers/gpio/gpio-omap.c | 146 +++++++++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 61 deletions(-)

-- 
2.5.0
