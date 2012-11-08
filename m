From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: Fix the pins debug output
Date: Thu, 8 Nov 2012 09:58:37 -0800
Message-ID: <20121108175836.GF6801@atomide.com>
References: <509BEF60.1030805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756373Ab2KHR6k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 12:58:40 -0500
Content-Disposition: inline
In-Reply-To: <509BEF60.1030805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>

* Benoit Cousson <b-cousson@ti.com> [121108 09:46]:
> The offset parameter is in fact the pin index. The printed
> value is then most of the time wrong.
> Multiply that value by the width to get the proper offset.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> 
> Hi Tony,
> 
> I guess that should probably go for 3.7-rc.
> 
> Regards,
> Benoit

There is a similar patch already posted by Haojian at:

http://www.spinics.net/lists/arm-kernel/msg205682.html

Linus' take was that by definition a debug output fix
is not a fix, so not for the -rc cycle.

Haojian is adding support for pinconf, so let's use his
version as it also removes the fmask allowing it to
show the whole register.

Regards,

Tony
 
>  drivers/pinctrl/pinctrl-single.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 726a729..aeca3bd 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -251,7 +251,7 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
>  
>  	pcs = pinctrl_dev_get_drvdata(pctldev);
>  
> -	val = pcs->read(pcs->base + offset);
> +	val = pcs->read(pcs->base + offset * (pcs->width / BITS_PER_BYTE));
>  	val &= pcs->fmask;
>  
>  	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
> -- 
> 1.7.0.4
