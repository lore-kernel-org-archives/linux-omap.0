From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] musb: add musb support for AM35x
Date: Fri, 12 Mar 2010 18:04:47 +0300
Message-ID: <4B9A580F.4030600@ru.mvista.com>
References: <1267017527-17591-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267017527-17591-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:

> AM35x has musb interface and uses CPPI4.1 DMA engine.
> Current patch supports only PIO mode and there are on-going
> discussions on location of CPPI4.1 DMA.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

   Overlooked one thing...

[...]

> +int musb_platform_exit(struct musb *musb)
> +{
>   
[...]
> +	phy_off();
> +
> +	usb_nop_xceiv_unregister();
> +
> +	return 0;
>   

   You forgot the calls to clk_disable() for both your clocks...

> +}
> +
>   
WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
