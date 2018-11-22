From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 00/11] mfd: simple demodularization of non-modular drivers
Date: Wed, 21 Nov 2018 23:32:48 -0500
Message-ID: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Arnd Bergmann <arnd@arndb.de>, Cory Maccarrone <darkstar6262@gmail.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-omap@vger.kernel.org

This group of MFD drivers are all controlled by "bool" Kconfig settings,
but contain traces of module infrastructure like unused/orphaned __exit
functions, use of <linux/module.h> and/or MODULE_ macros that are no-ops
in the non-modular case.

We can remove/replace all of the above.  We are trying to make driver
code consistent with the Makefiles/Kconfigs that control them.  This
means not using modular functions/macros for drivers that can never be
built as a module.  Some of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

The changes here should represent zero runtime changes.  Only the ones
with removed __exit functions will have a slightly smaller object size.
The source gets a net reduction of 100+ lines of unused code.

Build testing was done on drivers/mfd for allyesconfig on x86_64, ARM
and ARM-64.

Paul.

---

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: patches@opensource.cirrus.com
Cc: Support Opensource <support.opensource@diasemi.com>

Paul Gortmaker (11):
  mfd: as3711: Make it explicitly non-modular
  mfd: da9055-core: make it explicitly non-modular
  mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
  mfd: htc-i2cpld: Make it explicitly non-modular
  mfd: max8925-core: drop unused MODULE_ tags from non-modular code
  mfd: rc5t583: Make it explicitly non-modular
  mfd: sta2x11: drop unused MODULE_ tags from non-modular code
  mfd: syscon: Make it explicitly non-modular
  mfd: tps65910: Make it explicitly non-modular
  mfd: wm831x-core: drop unused MODULE_ tags from non-modular code
  mfd: wm8400-core: Make it explicitly non-modular

 drivers/mfd/as3711.c       | 14 --------------
 drivers/mfd/da9055-core.c  | 13 ++-----------
 drivers/mfd/db8500-prcmu.c | 10 ++++------
 drivers/mfd/htc-i2cpld.c   | 18 +-----------------
 drivers/mfd/max8925-core.c |  7 +------
 drivers/mfd/rc5t583.c      | 14 --------------
 drivers/mfd/sta2x11-mfd.c  | 10 ++++------
 drivers/mfd/syscon.c       | 12 +-----------
 drivers/mfd/tps65910.c     | 18 +-----------------
 drivers/mfd/wm831x-core.c  |  7 ++-----
 drivers/mfd/wm8400-core.c  | 18 +++---------------
 11 files changed, 19 insertions(+), 122 deletions(-)

-- 
2.7.4
