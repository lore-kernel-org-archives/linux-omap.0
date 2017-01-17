From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Add support for optional VBUS irq to dsps
 glue layer
Date: Tue, 17 Jan 2017 08:08:05 -0600
Message-ID: <20170117140744.GB31716@uda0271908>
References: <20170112214046.20079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170112214046.20079-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 12, 2017 at 01:40:46PM -0800, Tony Lindgren wrote:
> We can now configure the PMIC interrupt to provide us VBUS
> events. In that case we don't need to constantly poll the
> status and can make it optional. This is only wired up
> for the mini-B interface on beaglebone.
> 
> Note that eventually we should get also the connect status
> for the host interface when the am335x internal PM coprocessor
> provides us with an IRQ chip. For now, we still need to poll
> for the host mode status.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied. Thanks.
-Bin.

> ---
> 
> Changes since v1:
> 
> - Updated based on comments from Bin mostly to limit to peripheral
>   mode only
> 
> ---
>  drivers/usb/musb/musb_dsps.c | 117 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -118,6 +118,7 @@ struct dsps_glue {
>  	struct device *dev;
>  	struct platform_device *musb;	/* child musb pdev */
>  	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
> +	int vbus_irq;			/* optional vbus irq */
>  	struct timer_list timer;	/* otg_workaround timer */
>  	unsigned long last_timer;    /* last timer data for each instance */
>  	bool sw_babble_enabled;
> @@ -145,6 +146,29 @@ static const struct debugfs_reg32 dsps_musb_regs[] = {
>  	{ "mode",		0xe8 },
>  };
>  
> +static void dsps_mod_timer(struct dsps_glue *glue, int wait_ms)
> +{
> +	int wait;
> +
> +	if (wait_ms < 0)
> +		wait = msecs_to_jiffies(glue->wrp->poll_timeout);
> +	else
> +		wait = msecs_to_jiffies(wait_ms);
> +
> +	mod_timer(&glue->timer, jiffies + wait);
> +}
> +
> +/*
> + * If no vbus irq from the PMIC is configured, we need to poll VBUS status.
> + */
> +static void dsps_mod_timer_optional(struct dsps_glue *glue)
> +{
> +	if (glue->vbus_irq)
> +		return;
> +
> +	dsps_mod_timer(glue, -1);
> +}
> +
>  /**
>   * dsps_musb_enable - enable interrupts
>   */
> @@ -167,8 +191,7 @@ static void dsps_musb_enable(struct musb *musb)
>  	/* start polling for ID change in dual-role idle mode */
>  	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
>  			musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
> -		mod_timer(&glue->timer, jiffies +
> -				msecs_to_jiffies(wrp->poll_timeout));
> +		dsps_mod_timer(glue, -1);
>  }
>  
>  /**
> @@ -199,6 +222,9 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  	u8 devctl;
>  	int skip_session = 0;
>  
> +	if (glue->vbus_irq)
> +		del_timer(&glue->timer);
> +
>  	/*
>  	 * We poll because DSPS IP's won't expose several OTG-critical
>  	 * status change events (from the transceiver) otherwise.
> @@ -209,8 +235,7 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_WAIT_VRISE:
> -		mod_timer(&glue->timer, jiffies +
> -				msecs_to_jiffies(wrp->poll_timeout));
> +		dsps_mod_timer_optional(glue);
>  		break;
>  	case OTG_STATE_A_WAIT_BCON:
>  		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> @@ -219,17 +244,19 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  
>  	case OTG_STATE_A_IDLE:
>  	case OTG_STATE_B_IDLE:
> -		if (devctl & MUSB_DEVCTL_BDEVICE) {
> -			musb->xceiv->otg->state = OTG_STATE_B_IDLE;
> -			MUSB_DEV_MODE(musb);
> -		} else {
> -			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> -			MUSB_HST_MODE(musb);
> +		if (!glue->vbus_irq) {
> +			if (devctl & MUSB_DEVCTL_BDEVICE) {
> +				musb->xceiv->otg->state = OTG_STATE_B_IDLE;
> +				MUSB_DEV_MODE(musb);
> +			} else {
> +				musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> +				MUSB_HST_MODE(musb);
> +			}
> +			if (!(devctl & MUSB_DEVCTL_SESSION) && !skip_session)
> +				musb_writeb(mregs, MUSB_DEVCTL,
> +					    MUSB_DEVCTL_SESSION);
>  		}
> -		if (!(devctl & MUSB_DEVCTL_SESSION) && !skip_session)
> -			musb_writeb(mregs, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
> -		mod_timer(&glue->timer, jiffies +
> -				msecs_to_jiffies(wrp->poll_timeout));
> +		dsps_mod_timer_optional(glue);
>  		break;
>  	case OTG_STATE_A_WAIT_VFALL:
>  		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> @@ -332,15 +359,13 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>  			 */
>  			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
> -			mod_timer(&glue->timer, jiffies +
> -					msecs_to_jiffies(wrp->poll_timeout));
> +			dsps_mod_timer_optional(glue);
>  			WARNING("VBUS error workaround (delay coming)\n");
>  		} else if (drvvbus) {
>  			MUSB_HST_MODE(musb);
>  			musb->xceiv->otg->default_a = 1;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> -			mod_timer(&glue->timer, jiffies +
> -				  msecs_to_jiffies(wrp->poll_timeout));
> +			dsps_mod_timer_optional(glue);
>  		} else {
>  			musb->is_active = 0;
>  			MUSB_DEV_MODE(musb);
> @@ -364,8 +389,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_B_IDLE:
>  	case OTG_STATE_A_WAIT_BCON:
> -		mod_timer(&glue->timer, jiffies +
> -				msecs_to_jiffies(wrp->poll_timeout));
> +		dsps_mod_timer_optional(glue);
>  		break;
>  	default:
>  		break;
> @@ -469,8 +493,7 @@ static int dsps_musb_init(struct musb *musb)
>  		musb_writeb(musb->mregs, MUSB_BABBLE_CTL, val);
>  	}
>  
> -	mod_timer(&glue->timer, jiffies +
> -		  msecs_to_jiffies(glue->wrp->poll_timeout));
> +	dsps_mod_timer(glue, -1);
>  
>  	return dsps_musb_dbg_init(musb, glue);
>  }
> @@ -765,6 +788,47 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
>  	return ret;
>  }
>  
> +static irqreturn_t dsps_vbus_threaded_irq(int irq, void *priv)
> +{
> +	struct dsps_glue *glue = priv;
> +	struct musb *musb = platform_get_drvdata(glue->musb);
> +
> +	if (!musb)
> +		return IRQ_NONE;
> +
> +	dev_dbg(glue->dev, "VBUS interrupt\n");
> +	dsps_mod_timer(glue, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
> +					struct dsps_glue *glue)
> +{
> +	int error;
> +
> +	glue->vbus_irq = platform_get_irq_byname(pdev, "vbus");
> +	if (glue->vbus_irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (glue->vbus_irq <= 0) {
> +		glue->vbus_irq = 0;
> +		return 0;
> +	}
> +
> +	error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
> +					  NULL, dsps_vbus_threaded_irq,
> +					  IRQF_ONESHOT,
> +					  "vbus", glue);
> +	if (error) {
> +		glue->vbus_irq = 0;
> +		return error;
> +	}
> +	dev_dbg(glue->dev, "VBUS irq %i configured\n", glue->vbus_irq);
> +
> +	return 0;
> +}
> +
>  static int dsps_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -793,6 +857,12 @@ static int dsps_probe(struct platform_device *pdev)
>  	glue->dev = &pdev->dev;
>  	glue->wrp = wrp;
>  
> +	if (usb_get_dr_mode(&pdev->dev) == USB_DR_MODE_PERIPHERAL) {
> +		ret = dsps_setup_optional_vbus_irq(pdev, glue);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	platform_set_drvdata(pdev, glue);
>  	pm_runtime_enable(&pdev->dev);
>  	ret = dsps_create_musb_pdev(glue, pdev);
> @@ -903,8 +973,7 @@ static int dsps_resume(struct device *dev)
>  	musb_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
>  	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
>  	    musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
> -		mod_timer(&glue->timer, jiffies +
> -				msecs_to_jiffies(wrp->poll_timeout));
> +		dsps_mod_timer(glue, -1);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
