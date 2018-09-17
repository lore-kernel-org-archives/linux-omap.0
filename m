From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Date: Mon, 17 Sep 2018 10:51:31 -0700
Message-ID: <20180917175131.GA104770@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917052254.12336-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:
> When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> the counter will be incremented but the resume callback not called,
> so enumeration and charging will not start properly.
> To avoid that happen, wait and try again later.
> 
> Practically this happens when the device is woken up from suspend by
> plugging in usb.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> index a44680d64f9b..1f3cf4e48383 100644
> --- a/drivers/phy/ti/phy-twl4030-usb.c
> +++ b/drivers/phy/ti/phy-twl4030-usb.c
> @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  
>  	status = twl4030_usb_linkstat(twl);
>  
> +	/* we might get here too early when runtime is not ready yet
> +	 * and we will get an EACCESS later, so try again later
> +	 */

How exactly can this happen? What disables (and later re-enables)
runtime PM? How can we guarantee that the interrupt will be
re-triggered?

> +	if (!pm_runtime_enabled(twl->dev)) {
> +		cancel_delayed_work(&twl->id_workaround_work);
> +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> +		return IRQ_HANDLED;
> +	}
> +
>  	mutex_lock(&twl->lock);
>  	if (status >= 0 && status != twl->linkstat) {
>  		status_changed =
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
