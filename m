From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [patch-2.6.34-rc2+ 11/11] musb_core: fix musb_init_controller()
 error cleanup path
Date: Wed, 24 Mar 2010 15:16:09 +0300
Message-ID: <4BAA0289.1090807@ru.mvista.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com> <1269431279-22438-12-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45600 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0CXMQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:16:42 -0400
In-Reply-To: <1269431279-22438-12-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello.

Felipe Balbi wrote:

> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> This function forgets to call usb_remove_hcd() or musb_gadget_cleanup() iff
> sysfs_create_group() fails.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> [ felipe.balbi@nokia.com : review the entire error path
> 	not only when we fail hcd or gadget ]
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/musb_core.c |   50 +++++++++++++++++++++++++++--------------
>  1 files changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 90ac17b..13f36bf 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
[...]


> @@ -2047,7 +2052,7 @@ bad_config:
>  
>  	}
>  	if (status < 0)
> -		goto fail2;
> +		goto fail4;
>   

   No, the label should be 'fail3' here. In this case usb_add_hcd() or 
musb_gadget_setup() have failed, so we shouldn't undo them...

>  	status = musb_init_debugfs(musb);
>  	if (status < 0)
>   

   Is there also a 'goto' that needs to be fixed up?

> @@ -2056,7 +2061,7 @@ bad_config:
>  #ifdef CONFIG_SYSFS
>  	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
>  	if (status)
> -		goto fail2;
> +		goto fail4;
>  #endif
>  
>  	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
> @@ -2073,17 +2078,28 @@ bad_config:
>  
>  	return 0;
>  
> -fail2:
> +fail4:
> +	if (!is_otg_enabled(musb) && is_host_enabled(musb))
> +		usb_remove_hcd(musb_to_hcd(musb));
> +	else
> +		musb_gadget_cleanup(musb);
> +	device_init_wakeup(dev, 0);
> +
> +fail3:
>  	musb_platform_exit(musb);
> -fail:
> -	dev_err(musb->controller,
> -		"musb_init_controller failed with status %d\n", status);
>  
> +fail2:
>  	if (musb->clock)
>  		clk_put(musb->clock);
> -	device_init_wakeup(dev, 0);
> +
> +fail1:
> +	dev_err(musb->controller,
> +		"musb_init_controller failed with status %d\n", status);
> +
>  	musb_free(musb);
>  
> +fail0:
> +
>  	return status;
>  
>  }
>   

WBR, Sergei

