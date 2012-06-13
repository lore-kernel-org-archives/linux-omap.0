From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Wed, 13 Jun 2012 10:51:26 +0300
Message-ID: <4FD8467E.4010302@compulab.co.il>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: khilman@ti.com, tony@atomide.com, dmitry.torokhov@gmail.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, jon-hunter@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/13/12 04:44, Zumeng Chen wrote:
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

Unless this concerns many boards/archs/platforms, I'd suggest you to implement
the get_pendown_state() method in the board file.
If more users will need this, it can be facilitated in the driver.
(and of course not with the ugly ifdefs...)

>  
>  	} else {
>  		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");

-- 
Regards,
Igor.
