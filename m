From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ti: cpsw: include gpio/consumer.h
Date: Thu, 31 May 2018 15:47:08 -0400 (EDT)
Message-ID: <20180531.154708.1943762077531456815.davem@davemloft.net>
References: <20180530215212.1151415-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530215212.1151415-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: grygorii.strashko@ti.com, linux-gpio@vger.kernel.org, f.fainelli@gmail.com, ivan.khoronzhuk@linaro.org, j-keerthy@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:51:54 +0200

> On platforms that don't always enable CONFIG_GPIOLIB, we run into
> a build failure:
> 
> drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_probe':
> drivers/net/ethernet/ti/cpsw.c:3006:9: error: implicit declaration of function 'devm_gpiod_get_array_optional' [-Werror=implicit-function-declaration]
>   mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/ti/cpsw.c:3006:59: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>   mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
> 
> Since we cannot rely on this to be visible from gpio.h, we have to include
> gpio/consumer.h directly.
> 
> Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
