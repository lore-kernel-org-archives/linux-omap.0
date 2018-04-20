From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Date: Fri, 20 Apr 2018 09:05:16 +0100
Message-ID: <20180420080516.hoa2wlubrnpnkl5z@dell>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sergey Lapin <slapin@ossfans.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  MAINTAINERS                                      | 2 +-
>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-omap1/board-htcherald.c            | 2 +-
>  arch/arm/mach-pxa/palmz72.c                      | 2 +-
>  arch/arm/mach-pxa/viper.c                        | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-
>  drivers/i2c/busses/i2c-gpio.c                    | 2 +-
>  drivers/media/platform/marvell-ccic/mmp-driver.c | 2 +-
>  drivers/mfd/sm501.c                              | 2 +-
>  include/linux/{ => platform_data}/i2c-gpio.h     | 0
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-gpio.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
