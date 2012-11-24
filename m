From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: twl4030-pwrbutton: Change
 TWL4030_MODULE_PM_MASTER to TWL_MODULE_PM_MASTER
Date: Sat, 24 Nov 2012 00:32:03 -0800
Message-ID: <20121124083203.GF24711@core.coreip.homeip.net>
References: <1352799508-22212-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352799508-22212-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 13, 2012 at 10:38:28AM +0100, Peter Ujfalusi wrote:
> To facilitate upcoming cleanup in twl stack.
> No functional changes.

Applied, thank you Peter.
 
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index b3dd96d..27c2bc8 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -39,8 +39,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
>  	int err;
>  	u8 value;
>  
> -	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
> -				STS_HW_CONDITIONS);
> +	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &value, STS_HW_CONDITIONS);
>  	if (!err)  {
>  		pm_wakeup_event(pwr->dev.parent, 0);
>  		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
> -- 
> 1.8.0
> 
> 

-- 
Dmitry
