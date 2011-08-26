From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 1/3] OMAP: I2C: Reset support
Date: Fri, 26 Aug 2011 16:06:29 -0700
Message-ID: <87bovbzsay.fsf@ti.com>
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312524035-5549-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Fri, 5 Aug 2011 11:30:33 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Needs update/rebase to apply against my for_3.2/i2c-cleanup branch...

[...]

> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 98ae49b..8aa91b6 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
>  	int		(*device_enable) (struct platform_device *pdev);
>  	int		(*device_shutdown) (struct platform_device *pdev);
>  	int		(*device_idle) (struct platform_device *pdev);

The above functions no longer exist in the platform_data struct.

> +	int		(*device_reset) (struct device *dev);
>  };
>  
>  #endif

Kevin
