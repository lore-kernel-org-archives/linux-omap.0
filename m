From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V2 5/5] Input: ads7846: set proper debounce time in
 driver level
Date: Wed, 13 Jun 2012 12:18:32 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
> From: Zumeng Chen <zumeng.chen@windriver.com>
> 
> If we don't set proper debouce time for ads7846, then there are
> flooded interrupt counters of ads7846 responding to one time
> touch on screen, so the driver couldn't work well.
> 
> And since most OMAP3 series boards pass NULL pointer of board_pdata
> to omap_ads7846_init, so it's more proper to set it in driver level
> after having gpio_request done.
> 
> This patch has been validated on 3530evm.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  drivers/input/touchscreen/ads7846.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index f02028e..459ff29 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  		}
>  
>  		ts->gpio_pendown = pdata->gpio_pendown;
> +#ifdef CONFIG_ARCH_OMAP3
> +		/* 310 means about 10 microsecond for omap3 */
> +		gpio_set_debounce(pdata->gpio_pendown, 310);
> +#endif
>  

Zumeng,

With my sign-off you are changing the original code, that too
without my sign-off and ack. 
I wouldn't mind you to submit patches from my tree, but the expectation is 
if you are changing the original code, it should be under your sign-off.

Coming to the patch, #ifdef in driver is not recommended, and this 10msec 
delay is specific to OMAP GPIO and driver should not be aware of this, 
that's where you will find the original patch handling it in board file.

Thanks,
Vaibhav
>  	} else {
>  		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
> -- 
> 1.7.5.4
> 
> 

