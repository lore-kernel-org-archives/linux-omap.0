From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: fix build for !CONFIG_SUSPEND
Date: Mon, 28 Feb 2011 16:48:35 -0800
Message-ID: <87bp1vll7g.fsf@ti.com>
References: <1298357739-5132-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298357739-5132-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org> (Balaji
	T. K.'s message of "Tue, 22 Feb 2011 12:25:39 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> writes:

> fix the build break when !CONFIG_SUSPEND
>
> drivers/i2c/busses/i2c-omap.c:1173: error: lvalue required as unary '&' operand
> make[3]: *** [drivers/i2c/busses/i2c-omap.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
>
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Ben, feel free to fold into original patch if preferred.

Kevin

> ---
> introduced by commit f6f98d72575031b0c03416a28a0d580128114b74
> applies on i2c-fixes branch
>
>  drivers/i2c/busses/i2c-omap.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0541df9..adc1ee5 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1160,8 +1160,9 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
>  	.suspend = omap_i2c_suspend,
>  	.resume = omap_i2c_resume,
>  };
> +#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
>  #else
> -#define omap_i2c_pm_ops NULL
> +#define OMAP_I2C_PM_OPS NULL
>  #endif
>  
>  static struct platform_driver omap_i2c_driver = {
> @@ -1170,7 +1171,7 @@ static struct platform_driver omap_i2c_driver = {
>  	.driver		= {
>  		.name	= "omap_i2c",
>  		.owner	= THIS_MODULE,
> -		.pm     = &omap_i2c_pm_ops,
> +		.pm	= OMAP_I2C_PM_OPS,
>  	},
>  };
