From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH] i2c: twl4030: warning: mixed declarations and code
Date: Wed, 11 Jun 2008 09:53:45 -0400
Message-ID: <a0580c510806110653p65b64857y8de6897489d60466@mail.gmail.com>
References: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:56727 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYFKNyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 09:54:19 -0400
Received: by py-out-1112.google.com with SMTP id p76so1411358pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 06:54:18 -0700 (PDT)
In-Reply-To: <1213185323-31758-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Balbi,

Sorry but I didn't get your point with your patch.

On Wed, Jun 11, 2008 at 7:55 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> Latest patches for multi-omap support introduced
> it, removing.

What exactly you are removing?

>
> Trivial patch.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
> index 7f93b4f..f546d42 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -625,8 +625,8 @@ static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
>  static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
>                struct usb_gadget *gadget)
>  {
> -       struct twl4030_usb *twl = xceiv_to_twl(xceiv);
>        u32 l;
> +       struct twl4030_usb *twl = xceiv_to_twl(xceiv);

To me you are just moving the place of this declaration.
>
>        if (!xceiv)
>                return -ENODEV;
> --
> 1.5.6.rc1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
