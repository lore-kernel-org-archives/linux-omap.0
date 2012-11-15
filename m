From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv2] i2c: omap: Move the remove constraint
Date: Thu, 15 Nov 2012 09:16:43 +0100
Message-ID: <CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
References: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:44720 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2KOIQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 03:16:43 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so874585iay.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 00:16:43 -0800 (PST)
In-Reply-To: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de

Hi Shubhrajyoti,

On Thu, Nov 15, 2012 at 8:34 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently we just queue the transfer and release the
> qos constraints, however we donot wait for the transfer
Typo: donot

> to complete to release the constraint. Move the remove
> constraint after the bus busy as we are sure that the
> transfers are completed by then.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Looks good!
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

> ---
> v2: rebase to the for-next branch
>
>  drivers/i2c/busses/i2c-omap.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 482c63d..fabcbe1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -654,13 +654,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>                         break;
>         }
>
> -       if (dev->set_mpu_wkup_lat != NULL)
> -               dev->set_mpu_wkup_lat(dev->dev, -1);
> -
>         if (r == 0)
>                 r = num;
>
>         omap_i2c_wait_for_bb(dev);
> +
> +       if (dev->set_mpu_wkup_lat != NULL)
> +               dev->set_mpu_wkup_lat(dev->dev, -1);
> +
>  out:
>         pm_runtime_mark_last_busy(dev->dev);
>         pm_runtime_put_autosuspend(dev->dev);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
