From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue, 09 Aug 2016 14:13:11 +0200
Message-ID: <5423570.keugkegXM3@diego>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com> <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Am Dienstag, 9. August 2016, 13:36:17 schrieb Wolfram Sang:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---

[...]

> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 2bc8b01153d619..3b87afe82f6394 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1303,10 +1303,8 @@ static int rk3x_i2c_probe(struct platform_device
> *pdev) rk3x_i2c_adapt_div(i2c, clk_rate);
> 
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Could not register adapter\n");
> +	if (ret < 0)
>  		goto err_clk_notifier;
> -	}
> 
>  	dev_info(&pdev->dev, "Initialized RK3xxx I2C bus at %p\n", i2c->regs);

for Rockchip
Acked-by: Heiko Stuebner <heiko@sntech.de>
