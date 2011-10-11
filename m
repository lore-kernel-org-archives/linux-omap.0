From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Mon, 10 Oct 2011 18:40:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101838500.5205@utopia.booyaka.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317901099-2519-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

and some comments on this one ...

On Thu, 6 Oct 2011, Keshava Munegowda wrote:

> From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> 
> Following 2 hwmod structures are added
> 1. usb_host_hs
>      The hwmod of usbhs with uhh, ehci and ohci base addresses
>      functional clock and ehci, ohci irqs
> 
> 2. usb_tll_hs
>       hwmod of usbhs with the TLL base address and irq.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> 
> - rebased to kernel version 3.0
> - Workarounds for hardware issues
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  206 +++++++++++++++++++++++++++-
>  1 files changed, 205 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 6201422..e404fd6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c

...

> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs = {
> +	.master		= &omap44xx_l4_cfg_hwmod,
> +	.slave		= &omap44xx_usb_tll_hs_hwmod,
> +	.addr		= omap44xx_usb_tll_hs_addrs,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};

This one has the .master pointing to something reasonable, but is missing 
a .clk entry.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
