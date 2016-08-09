From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue, 9 Aug 2016 06:31:40 -0700
Message-ID: <32d25618-83f6-b876-07b0-adb988516173@roeck-us.net>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@stlinux.com, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/09/2016 04:36 AM, Wolfram Sang wrote:
> The core will do this for us now.
>
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
[ ... ]

> diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
> index aeead0d27d1007..64318e69089439 100644
> --- a/drivers/i2c/busses/i2c-uniphier-f.c
> +++ b/drivers/i2c/busses/i2c-uniphier-f.c
> @@ -550,15 +550,10 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
>  	}
>
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
> -err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
>
> + err:

You sure about that one ? It leaves the clock enabled in some of the error paths.

>  	return ret;
>  }
>
> diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
> index 475a5eb514e215..94f64cccfdef08 100644
> --- a/drivers/i2c/busses/i2c-uniphier.c
> +++ b/drivers/i2c/busses/i2c-uniphier.c
> @@ -407,15 +407,10 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
>  	}
>
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
> -err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
>
> + err:

Same as above.

Note: I dropped all individuals from Cc:; my mailer refused to accept the reply because there
were too many.

Guenter

>  	return ret;
>  }
>
