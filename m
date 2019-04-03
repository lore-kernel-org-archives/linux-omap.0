From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 00/12] i2c: core: introduce atomic transfers
Date: Wed,  3 Apr 2019 14:40:07 +0200
Message-ID: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

This series adds support for very late atomic transfers to the I2C subsystem.
It finally reached a state which I think is ready-to-apply. This is mainly
because of two things:

a) we decided to respect the current locking scheme and to not give atomic
transfers a priority. The code needed for that would have been either
incomplete or very invasive. And we cannot guarantee successful transfers
anyhow. See [1] for the discussion and other write-ups for design choices.

b) thanks to a discussion with Peter Zijlstra[2], the conditions when to allow
atomic transfers became much clearer. The new helper i2c_in_atomic_xfer_mode()
adds readability, too.

In detail, changes since RFC v2:

* dropped coding style patch because already applied
* added new patch 1 to drop in_atomic() and have better conditions when
  to enter the atomic path
* added support to the mux-core
* simplified omap conversion a little
* added new conversions for ocores, stu300, and algo-bit/gpio
* typo corrections found by Simon and Stefan
* added tags to drivers
* dropped tags from core patches because that part changed too much

All tested on a Renesas Lager board (R-Car H2). Sadly, the i2c-sh_mobile driver
cannot be converted now because of other work needed first. I tested with the
i2c-gpio driver, though. The other driver patches are build tested. A branch
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/atomic_xfer

I am happy for reviews and comments. Please note if you review (especially the
core parts), I'd like to have a short summary of your review even if there is
no proposed change. Like what you did, what you think about it, etc. Some stuff
in here is subtle, so if you went through the effort to double check my
assumptions you should name it :)


Finally, a big thank you and credit to Renesas for funding this work, of course!

Happy hacking,

   Wolfram

[1] https://lkml.org/lkml/2019/3/2/76
[2] http://patchwork.ozlabs.org/patch/1067437/

Wolfram Sang (12):
  i2c: remove use of in_atomic()
  i2c: core: use I2C locking behaviour also for SMBUS
  i2c: core: introduce callbacks for atomic transfers
  i2c: mux: populate the new *_atomic callbacks
  i2c: demux: handle the new atomic callbacks
  i2c: omap: Add the master_xfer_irqless hook
  i2c: tegra-bpmp: convert to use new atomic callbacks
  i2c: ocores: refactor setup for polling
  i2c: ocores: enable atomic xfers
  i2c: stu300: use xfer_atomic callback to bail out early
  i2c: algo: bit: add flag to whitelist atomic transfers
  i2c: gpio: flag atomic capability if possible

 drivers/i2c/algos/i2c-algo-bit.c      | 22 +++++++++-
 drivers/i2c/busses/i2c-gpio.c         |  2 +
 drivers/i2c/busses/i2c-ocores.c       | 16 +++-----
 drivers/i2c/busses/i2c-omap.c         | 76 +++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-stu300.c       | 25 +++++-------
 drivers/i2c/busses/i2c-tegra-bpmp.c   | 25 +++++++++---
 drivers/i2c/i2c-core-base.c           | 17 ++++----
 drivers/i2c/i2c-core-smbus.c          | 25 +++++++++---
 drivers/i2c/i2c-core.h                | 25 ++++++++++++
 drivers/i2c/i2c-mux.c                 |  6 +++
 drivers/i2c/muxes/i2c-demux-pinctrl.c |  2 +
 include/linux/i2c-algo-bit.h          |  1 +
 include/linux/i2c.h                   | 15 +++++--
 13 files changed, 194 insertions(+), 63 deletions(-)

-- 
2.11.0
