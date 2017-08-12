From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] drivers: make regmap_irq_chip const
Date: Sat, 12 Aug 2017 11:39:07 +0530
Message-ID: <1502518149-11663-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linus.walleij@linaro.org, marek.vasut+renesas@gmail.com, lee.jones@linaro.org, tony@atomide.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these structures const. Done using Coccinelle.

Bhumika Goyal (2):
  mfd: make regmap_irq_chip const
  gpio: make regmap_irq_chip const

 drivers/gpio/gpio-max77620.c       | 2 +-
 drivers/mfd/bd9571mwv.c            | 2 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 drivers/mfd/tps65086.c             | 2 +-
 drivers/mfd/tps65090.c             | 2 +-
 drivers/mfd/tps65218.c             | 2 +-
 drivers/mfd/tps65912-core.c        | 2 +-
 drivers/mfd/tps80031.c             | 2 +-
 drivers/mfd/twl6040.c              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1

