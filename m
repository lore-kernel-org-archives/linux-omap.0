From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] Drop owner assignment from i2c_driver (and platform left-overs)
Date: Fri, 10 Jul 2015 14:05:39 +0900
Message-ID: <1436504740-9439-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (1):
  mfd: Drop owner assignment from i2c_drivers

 drivers/mfd/88pm800.c             | 1 -
 drivers/mfd/88pm805.c             | 1 -
 drivers/mfd/88pm860x-core.c       | 1 -
 drivers/mfd/aat2870-core.c        | 1 -
 drivers/mfd/ab3100-core.c         | 1 -
 drivers/mfd/adp5520.c             | 1 -
 drivers/mfd/arizona-i2c.c         | 1 -
 drivers/mfd/as3711.c              | 1 -
 drivers/mfd/as3722.c              | 1 -
 drivers/mfd/axp20x.c              | 1 -
 drivers/mfd/bcm590xx.c            | 1 -
 drivers/mfd/cros_ec_i2c.c         | 1 -
 drivers/mfd/da903x.c              | 1 -
 drivers/mfd/da9052-i2c.c          | 1 -
 drivers/mfd/da9055-i2c.c          | 1 -
 drivers/mfd/da9063-i2c.c          | 1 -
 drivers/mfd/intel_soc_pmic_core.c | 1 -
 drivers/mfd/lm3533-core.c         | 1 -
 drivers/mfd/lp3943.c              | 1 -
 drivers/mfd/lp8788.c              | 1 -
 drivers/mfd/max14577.c            | 1 -
 drivers/mfd/max77686.c            | 1 -
 drivers/mfd/max77693.c            | 1 -
 drivers/mfd/max8907.c             | 1 -
 drivers/mfd/max8925-i2c.c         | 1 -
 drivers/mfd/max8997.c             | 1 -
 drivers/mfd/max8998.c             | 1 -
 drivers/mfd/mc13xxx-i2c.c         | 1 -
 drivers/mfd/palmas.c              | 1 -
 drivers/mfd/rc5t583.c             | 1 -
 drivers/mfd/retu-mfd.c            | 1 -
 drivers/mfd/sec-core.c            | 1 -
 drivers/mfd/si476x-i2c.c          | 1 -
 drivers/mfd/smsc-ece1099.c        | 1 -
 drivers/mfd/stmpe-i2c.c           | 1 -
 drivers/mfd/tc3589x.c             | 1 -
 drivers/mfd/tps6507x.c            | 1 -
 drivers/mfd/tps65090.c            | 1 -
 drivers/mfd/tps65217.c            | 1 -
 drivers/mfd/tps65218.c            | 1 -
 drivers/mfd/tps6586x.c            | 1 -
 drivers/mfd/tps65910.c            | 1 -
 drivers/mfd/tps65912-i2c.c        | 1 -
 drivers/mfd/tps80031.c            | 1 -
 drivers/mfd/twl6040.c             | 1 -
 drivers/mfd/wm831x-i2c.c          | 1 -
 drivers/mfd/wm8350-i2c.c          | 1 -
 drivers/mfd/wm8400-core.c         | 1 -
 drivers/mfd/wm8994-core.c         | 1 -
 49 files changed, 49 deletions(-)

-- 
1.9.1
