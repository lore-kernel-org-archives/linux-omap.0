From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date: Wed, 16 Jan 2019 13:24:31 +0000
Message-ID: <20190116132431.GE23399@dell>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Tony Lindgren <tony@atomide.com>, Venu
List-Id: linux-omap@vger.kernel.org

[...]

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

All applied!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
