From: Bin Liu <binmlist@gmail.com>
Subject: Re: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Fri, 6 Feb 2015 12:18:13 -0600
Message-ID: <CADYTM3brwenr4706Xqp91Vg7OVxT0CENy8aHhyzJ+vOGxxvRVw@mail.gmail.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
	<1423154113-23463-3-git-send-email-tony@atomide.com>
	<54D4BA78.9030704@ti.com>
	<20150206172313.GF25235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38916 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187AbbBFSSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2015 13:18:14 -0500
In-Reply-To: <20150206172313.GF25235@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

Tony,

On Fri, Feb 6, 2015 at 11:23 AM, Tony Lindgren <tony@atomide.com> wrote:
> * George Cherian <george.cherian@ti.com> [150206 05:05]:
>> Hi Tony,
>>
>> You also need to add similar things in dsps_musb_reset();
>>
>> Otherwise you might not recover from a BABBLE condition.
>
> Thank I totally missed that, updated patch below.
>
> Do you have some testcase that easily triggers BABBLE
> on MUSB?

I normally just shorten DP or DM to VBUS to trigger babble. No device
is connected to the port, if I remembered correctly.

Regards,
-Bin.

>
> Regards,
>
> Tony
>
> 8< ----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 4 Feb 2015 06:28:49 -0800
> Subject: [PATCH] usb: musb: Fix getting a generic phy for musb_dsps
>
> We still have a combination of legacy phys and generic phys in
> use so we need to support both types of phy for musb_dsps.c.
>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -457,12 +457,27 @@ static int dsps_musb_init(struct musb *musb)
>         if (IS_ERR(musb->xceiv))
>                 return PTR_ERR(musb->xceiv);
>
> +       musb->phy = devm_phy_get(dev->parent, "usb2-phy");
> +
>         /* Returns zero if e.g. not clocked */
>         rev = dsps_readl(reg_base, wrp->revision);
>         if (!rev)
>                 return -ENODEV;
>
>         usb_phy_init(musb->xceiv);
> +       if (IS_ERR(musb->phy))  {
> +               musb->phy = NULL;
> +       } else {
> +               ret = phy_init(musb->phy);
> +               if (ret < 0)
> +                       return ret;
> +               ret = phy_power_on(musb->phy);
> +               if (ret) {
> +                       phy_exit(musb->phy);
> +                       return ret;
> +               }
> +       }
> +
>         setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
>
>         /* Reset the musb */
> @@ -502,6 +517,8 @@ static int dsps_musb_exit(struct musb *musb)
>
>         del_timer_sync(&glue->timer);
>         usb_phy_shutdown(musb->xceiv);
> +       phy_power_off(musb->phy);
> +       phy_exit(musb->phy);
>         debugfs_remove_recursive(glue->dbgfs_root);
>
>         return 0;
> @@ -610,7 +627,7 @@ static int dsps_musb_reset(struct musb *musb)
>         struct device *dev = musb->controller;
>         struct dsps_glue *glue = dev_get_drvdata(dev->parent);
>         const struct dsps_musb_wrapper *wrp = glue->wrp;
> -       int session_restart = 0;
> +       int session_restart = 0, error;
>
>         if (glue->sw_babble_enabled)
>                 session_restart = sw_babble_control(musb);
> @@ -624,8 +641,14 @@ static int dsps_musb_reset(struct musb *musb)
>                 dsps_writel(musb->ctrl_base, wrp->control, (1 << wrp->reset));
>                 usleep_range(100, 200);
>                 usb_phy_shutdown(musb->xceiv);
> +               error = phy_power_off(musb->phy);
> +               if (error)
> +                       dev_err(dev, "phy shutdown failed: %i\n", error);
>                 usleep_range(100, 200);
>                 usb_phy_init(musb->xceiv);
> +               error = phy_power_on(musb->phy);
> +               if (error)
> +                       dev_err(dev, "phy powerup failed: %i\n", error);
>                 session_restart = 1;
>         }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
