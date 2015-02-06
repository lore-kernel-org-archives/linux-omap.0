From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Fri, 6 Feb 2015 18:28:32 +0530
Message-ID: <54D4BA78.9030704@ti.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com> <1423154113-23463-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423154113-23463-3-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

You also need to add similar things in dsps_musb_reset();

Otherwise you might not recover from a BABBLE condition.

On 02/05/2015 10:05 PM, Tony Lindgren wrote:
> We still have a combination of legacy phys and generic phys in
> use so we need to support both types of phy for musb_dsps.c.
>
> Cc: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/usb/musb/musb_dsps.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -457,12 +457,25 @@ static int dsps_musb_init(struct musb *musb)
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
> +		if (ret)
> +			return ret;
> +	}
> +
>   	setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
>   
>   	/* Reset the musb */
> @@ -502,6 +515,10 @@ static int dsps_musb_exit(struct musb *musb)
>   
>   	del_timer_sync(&glue->timer);
>   	usb_phy_shutdown(musb->xceiv);
> +	if (musb->phy) {
> +		phy_power_off(musb->phy);
> +		phy_exit(musb->phy);
> +	}
>   	debugfs_remove_recursive(glue->dbgfs_root);
>   
>   	return 0;
-George

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
