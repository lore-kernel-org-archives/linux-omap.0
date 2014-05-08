From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 3/5] usb: musb: core: Convert the musb_platform_reset
 to have a return value.
Date: Thu, 08 May 2014 11:47:47 +0200
Message-ID: <536B52C3.3010109@gmail.com>
References: <1399541743-14158-1-git-send-email-george.cherian@ti.com> <1399541743-14158-4-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399541743-14158-4-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

Hi Geroge,

On 05/08/2014 11:35 AM, George Cherian wrote:
> -static inline void musb_platform_reset(struct musb *musb)
> +static inline int  musb_platform_reset(struct musb *musb)
>  {
> -	if (musb->ops->reset)
> -		musb->ops->reset(musb);
> +	if (!musb->ops->reset)
> +		return -EINVAL;
> +
> +	return musb->ops->reset(musb);
>  }
>  
>  static inline int musb_platform_get_vbus_status(struct musb *musb)
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 74c4193..8438200 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -536,7 +536,7 @@ static int dsps_musb_set_mode(struct musb *musb, u8 mode)
>  	return 0;
>  }
>  
> -static void dsps_musb_reset(struct musb *musb)
> +static int dsps_musb_reset(struct musb *musb)
>  {
>  	struct device *dev = musb->controller;
>  	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
> @@ -548,6 +548,7 @@ static void dsps_musb_reset(struct musb *musb)
>  	usleep_range(100, 200);
>  	usb_phy_init(musb->xceiv);
>  
> +	return 1;

Could we follow the general kernel rule here and return 0 for success,
and < 0 on failure?



Thanks,
Daniel
