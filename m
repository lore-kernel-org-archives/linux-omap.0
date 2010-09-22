From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Wed, 22 Sep 2010 20:11:19 +0400
Message-ID: <4C9A2AA7.4030504@ru.mvista.com>
References: <1285201816-26516-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201816-26516-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Hema HK wrote:

> OMAP USBOTG modules has a requirement to set the auto idle bit only after
> setting smart idle bit. Modified the _sys_enable api to set the smart idle
> first and then the autoidle bit. Setting this will not have any impact on the
> other modules.

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
[...]
> @@ -672,6 +666,19 @@ static void _sysc_enable(struct omap_hwm
>  		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
>  
>  	_write_sysconfig(v, oh);
> +
> +	/*
> +	 * Set the auto idle bit only after setting the smartidle bit
> +	 * as this is requirement for some modules like USBOTG

    Need period at the end of sentense, and the next sentense should satrt with 
capital letter. Sorry for the grammar nitpicking. :-)

> +	 * setting this will not have any impact on the other modues.
> +	 */

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
