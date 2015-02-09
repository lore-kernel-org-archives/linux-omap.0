From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Mon, 9 Feb 2015 11:26:03 +0530
Message-ID: <54D84BF3.7060801@ti.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com> <1423154113-23463-3-git-send-email-tony@atomide.com> <54D4BA78.9030704@ti.com> <20150206172313.GF25235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150206172313.GF25235-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On 02/06/2015 10:53 PM, Tony Lindgren wrote:
> * George Cherian <george.cherian-l0cyMroinI0@public.gmane.org> [150206 05:05]:
>> Hi Tony,
>>
>> You also need to add similar things in dsps_musb_reset();
>>
>> Otherwise you might not recover from a BABBLE condition.
> Thank I totally missed that, updated patch below.
>
> Do you have some testcase that easily triggers BABBLE
> on MUSB?
On a BBB or BBW you can connect a HUB with multiple device connected on HUB.
Then do a repeated Connect and Disconnect of the HUB, This should 
trigger a BABBLE interrupt.
Not all HUB's might not lead you to a BABBLE condition.

> Regards,
>
> Tony
>
> 8< ----------------------
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Wed, 4 Feb 2015 06:28:49 -0800
> Subject: [PATCH] usb: musb: Fix getting a generic phy for musb_dsps
>
> We still have a combination of legacy phys and generic phys in
> use so we need to support both types of phy for musb_dsps.c.
>
> Cc: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -457,12 +457,27 @@ static int dsps_musb_init(struct musb *musb)
>   	if (IS_ERR(musb->xceiv))
>   		return PTR_ERR(musb->xceiv);
>   
> +	musb->phy = devm_phy_get(dev->parent, "usb2-phy");
> +
>   	/* Returns zero if e.g. not clocked */
>   	rev = dsps_readl(reg_base, wrp->revision);
>   	if (!rev)
>   		return -ENODEV;
>   
>   	usb_phy_init(musb->xceiv);
> +	if (IS_ERR(musb->phy))  {
> +		musb->phy = NULL;
> +	} else {
> +		ret = phy_init(musb->phy);
> +		if (ret < 0)
> +			return ret;
> +		ret = phy_power_on(musb->phy);
> +		if (ret) {
> +			phy_exit(musb->phy);
> +			return ret;
> +		}
> +	}
> +
>   	setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
>   
>   	/* Reset the musb */
> @@ -502,6 +517,8 @@ static int dsps_musb_exit(struct musb *musb)
>   
>   	del_timer_sync(&glue->timer);
>   	usb_phy_shutdown(musb->xceiv);
> +	phy_power_off(musb->phy);
> +	phy_exit(musb->phy);
>   	debugfs_remove_recursive(glue->dbgfs_root);
>   
>   	return 0;
> @@ -610,7 +627,7 @@ static int dsps_musb_reset(struct musb *musb)
>   	struct device *dev = musb->controller;
>   	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
>   	const struct dsps_musb_wrapper *wrp = glue->wrp;
> -	int session_restart = 0;
> +	int session_restart = 0, error;
>   
>   	if (glue->sw_babble_enabled)
>   		session_restart = sw_babble_control(musb);
> @@ -624,8 +641,14 @@ static int dsps_musb_reset(struct musb *musb)
>   		dsps_writel(musb->ctrl_base, wrp->control, (1 << wrp->reset));
>   		usleep_range(100, 200);
>   		usb_phy_shutdown(musb->xceiv);
> +		error = phy_power_off(musb->phy);
> +		if (error)
> +			dev_err(dev, "phy shutdown failed: %i\n", error);
>   		usleep_range(100, 200);
>   		usb_phy_init(musb->xceiv);
> +		error = phy_power_on(musb->phy);
> +		if (error)
> +			dev_err(dev, "phy powerup failed: %i\n", error);
>   		session_restart = 1;
>   	}
>   

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
