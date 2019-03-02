From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Sat,  2 Mar 2019 14:47:28 +0100
Message-ID: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

So, finally, here is the second RFC for supporting I2C transfers in atomic
contexts (i.e. very late). This will need some text because I tried some things
on the way but had to discard them. However, I think it is important to have
that documented.

One thing I really wanted to have is a kind of whitelist for devices which are
allowed to use atomic transfers. So we could identify the "unauthorized" ones
as buggy. To be useful, this should not add new API calls for transfers,
otherwise things would have become way more complicated for I2C users like
regmap. So, I tried e.g. to flag clients and provide that information
throughout the i2c tree (think muxes here). In the end, I concluded that this
is not an I2C specific problem, so it can't have an I2C specifc solution.
Imagine a GPIO which is needed to reboot (drivers/power/reset/gpio-restart.c).
This is the device which needs to whitelisted but the driver doesn't even know
if the GPIO is behind I2C or not. So, if we want this, it should probably be
handled on 'struct device' level. Including all the hierarchy. Postponed.

So, this RFC v2 is much more similar to v1 than I expected. Main changes:

* cleaned up 'struct i2c_adapter' a bit before adding the new stuff
* added an atomic callback for SMBus, too. Only build-tested so far. But spent
  a few braincells of getting the SMBus logic readable because we could have
  an I2C fallback just for the atomic case
* add a WARN for atomic transfers with no atomic transfer handler
* added support for the i2c-demuxer, so I could test the series. Support
  for I2C muxes is missing because of the locking issue (see later) which
  may mean a redesign anyhow
* imported the omap support into this series to have another user. I didn't
  pick up the patch for imx from Stefan because it is bigger and probably
  needs seperate review first
* I converted the tegra-bpmp driver which already had handling for the atomic
  case*. I did not convert the pxa driver which has a polling-only mode, too.
  This also seems like a bigger task and its current behaviour shouldn't be
  affected by this series. *only build tested
* added a HACK to allow the i2c-gpio driver atomic transfers. This will only
  work if accessing the GPIO can be done in atomic contexts, too, so this is
  for testing only

For the regular cases this series works well on my Renesas Lager board*
which needs an I2C access to the PMIC to reboot the board. *if I use the
i2c-gpio driver, the i2c-sh_mobile is not converted yet.

However, during the last review, Russell King brought up an interesting corner
case. What if we want to reboot because of a panic and the bus is not in a
consistent state? To create this situation, I recently created the 'inject-panic'
fault injector [1] which is merged into i2c/for-next meanwhile.

With this fault injector and 'reboot after panic' settings, I can create
the problem Russell described: a) the bus is in an inconsistent state because
the driver was interrupted (SCL/SDA both low) and b) the lock for this driver
is taken, so trylock fails.

I think b) is an interesting question: shall we give atomic transfers priority
and ignore the lock? Do we need a seperate one then (SMP is turned off already,
or?)? If so, that would probably mean way more complicated mux-locking code
(Peter?)? And what if some mux in the path needs interrupts? And how academic
is all that? Because someone putting the reboot functionality behind muxed I2C
is kind of asking for problems :)

That being said: this is an issue I think it is worth tackling. However, this
issue is not introduced by this series. It is already there. It might just
become more visible.

Sidenote: I think problem a) is easier once we solved b). E.g. if we decide on
a higher priority, we can postulate that IP cores should be reset first and
bus recovery can also be applied. This will not help all cases but IMO is all
we can do.

Another topic where I'd like input from other people is the use of 'in_atomic'
in this series. It was already there, so I kept it to avoid regressions. I am
aware that 'in_atomic' should not be used in drivers. So, if someone has
expertise to say if it can be removed or replaced with something else, I am
all ears.

A branch (based on i2c/for-next) can be found here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/atomic_xfer

Sorry, no TLDR; text here - I think this topic deserves a few words ;)

Looking forward to comments, thanks!

   Wolfram


[1] http://patchwork.ozlabs.org/patch/1044789/


Tero Kristo (1):
  i2c: busses: omap: Add the master_xfer_irqless hook

Wolfram Sang (6):
  i2c: apply coding style for struct i2c_adapter
  i2c: core: use I2C locking behaviour also for SMBUS
  i2c: core: introduce callbacks for atomic transfers
  i2c: demux: WIP: handle the new atomic callbacks
  i2c: tegra-bpmp: convert to use new atomic callbacks
  i2c: algo: bit: HACK! add atomic callback

 drivers/i2c/algos/i2c-algo-bit.c      |  5 ++-
 drivers/i2c/busses/i2c-omap.c         | 79 +++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-tegra-bpmp.c   | 27 +++++++++---
 drivers/i2c/i2c-core-base.c           | 17 ++++----
 drivers/i2c/i2c-core-smbus.c          | 25 ++++++++---
 drivers/i2c/i2c-core.h                | 15 +++++++
 drivers/i2c/muxes/i2c-demux-pinctrl.c |  3 ++
 include/linux/i2c.h                   | 38 +++++++++++------
 8 files changed, 162 insertions(+), 47 deletions(-)

-- 
2.11.0
