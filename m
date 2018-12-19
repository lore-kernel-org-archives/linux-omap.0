From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 00/18] mfd: demodularization of non-modular drivers
Date: Wed, 19 Dec 2018 08:03:40 +0000
Message-ID: <20181219080340.GL4497@dell>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Tony Lindgren <tony@atomide.com>, Venu
List-Id: linux-omap@vger.kernel.org

To all recipients (therefore, not a top post ;D ),

So far, so good.  Please keep the reviews coming.

On Mon, 17 Dec 2018, Paul Gortmaker wrote:

> [v3 --> v4: delete now unused exit fcn from wm835x core; add more acks
>  now all in chrono order, re-test.]
> 
> [v2 --> v3: drop diasemi commits as they will be modularized; delete
>  now unused exit fcn from wm831x core; add more acks; re-test.]
> 
> [v1 --> v2: add some more commits as requested by Lee (MFD maintainer),
>  update the 00/NN text; re-do build and link testing on new linux-next. ]
> 
> This group of MFD drivers are all controlled by "bool" Kconfig settings,
> but contain various amounts of largely pointless uses of infrastructure
> related to modular operations, even though they can't be built modular.
> 
> We can easily remove/replace all of it.  We are trying to make driver
> code consistent with the Makefiles/Kconfigs that control them.  This
> means not using modular functions/macros for drivers that can never be
> built as a module.  Some of the downfalls this oversight leads to are:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding a lot of CPP overhead.
>  (4) it gets copied/replicated into other drivers and spreads quickly.
> 
> What we see in current drivers falls into one or more of the following
> categories:
> 
> 1) include of <linux/module.h> when it simply isn't needed
> 
> 2) Use of MODULE_LICENSE, MODULE_DEVICE_TABLE,  MODULE_AUTHOR etc. 
>    macros that are no-ops for non-modular drivers.
> 
> 3) Creation of a module_exit() function that will be compiled and
>    linked in but never actually called for non-modular drivers.
> 
> 4) Addition of a platform_driver ".remove" function that is bound
>    into the struct but will never be called for non-module use cases.
> 
> Solution to #1 --> #3 is simple ; we just delete the related code.
> 
> The solution to #4 is similar - we delete the ".remove" function and
> the binding into the platform_driver struct.  However, since the same
> ".remove" function could also be triggered by an "unbind" (such as for
> pass-through of a device to a guest instance)  - so we also explicitly
> disable any unbind for the driver.
> 
> The unbind mask allows us to ensure we will see if there was some odd
> corner case out there that was relying on it.  Typically it would be a
> multi-port ethernet card passing a port through to a guest, so a
> sensible use case in MFD drivers seems highly unlikely.  This same
> solution has already been used in multiple other mainline subsystems.
> 
> Build testing was done on drivers/mfd for allyesconfig on x86_64, ARM
> and ARM-64 on a recent linux-next checkout.
> 
> Paul.
> 
> ---
> 
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: Davide Ciminaghi <ciminaghi@gnudd.com>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Jin Park <jinyoungp@nvidia.com>
> Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Venu Byravarasu <vbyravarasu@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: patches@opensource.cirrus.com
> 
> 
> Paul Gortmaker (18):
>   mfd: aat2870-core: Make it explicitly non-modular
>   mfd: adp5520: Make it explicitly non-modular
>   mfd: as3711: Make it explicitly non-modular
>   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
>   mfd: htc-i2cpld: Make it explicitly non-modular
>   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
>   mfd: rc5t583: Make it explicitly non-modular
>   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
>   mfd: syscon: Make it explicitly non-modular
>   mfd: tps65090: Make it explicitly non-modular
>   mfd: tps65910: Make it explicitly non-modular
>   mfd: tps80031: Make it explicitly non-modular
>   mfd: wm831x-spi: Make it explicitly non-modular
>   mfd: wm831x-i2c: Make it explicitly non-modular
>   mfd: wm831x-core: drop unused module infrastructure from non-modular code
>   mfd: wm8350-i2c: Make it explicitly non-modular
>   mfd: wm8350-core: drop unused module infrastructure from non-modular code
>   mfd: wm8400-core: Make it explicitly non-modular
> 
>  drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
>  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
>  drivers/mfd/as3711.c            | 14 --------------
>  drivers/mfd/db8500-prcmu.c      | 10 ++++------
>  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
>  drivers/mfd/max8925-core.c      |  7 +------
>  drivers/mfd/rc5t583.c           | 14 --------------
>  drivers/mfd/sta2x11-mfd.c       | 10 ++++------
>  drivers/mfd/syscon.c            | 12 +-----------
>  drivers/mfd/tps65090.c          | 30 +++++-------------------------
>  drivers/mfd/tps65910.c          | 18 +-----------------
>  drivers/mfd/tps80031.c          | 37 ++-----------------------------------
>  drivers/mfd/wm831x-core.c       | 15 ++-------------
>  drivers/mfd/wm831x-i2c.c        | 20 ++------------------
>  drivers/mfd/wm831x-spi.c        | 24 ++----------------------
>  drivers/mfd/wm8350-core.c       | 30 ++----------------------------
>  drivers/mfd/wm8350-i2c.c        | 24 +-----------------------
>  drivers/mfd/wm8400-core.c       | 18 +++---------------
>  include/linux/mfd/wm831x/core.h |  1 -
>  include/linux/mfd/wm8350/core.h |  1 -
>  20 files changed, 41 insertions(+), 332 deletions(-)
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
