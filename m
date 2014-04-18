From: Leigh Brown <leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org>
Subject: Re: [PATCH 5/8] usb: phy: rename =?UTF-8?Q?usb=5Fnop=5Fxceiv=20to?=
 =?UTF-8?Q?=20usb=5Fphy=5Fgeneric?=
Date: Fri, 18 Apr 2014 11:44:51 +0100
Message-ID: <1564d4581233022aef43b7eb5f7a9761@doppler.thel33t.co.uk>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
 <1397683595-3606-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397683595-3606-6-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 2014-04-16 22:26, Felipe Balbi wrote:
> no functional changes, just renaming the function
> in order to make it slightly clearer what it should
> be used for, also matching the driver name.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
[...]
> diff --git a/include/linux/usb/usb_phy_gen_xceiv.h
> b/include/linux/usb/usb_phy_gen_xceiv.h
> index cc8d818..c00176d 100644
> --- a/include/linux/usb/usb_phy_gen_xceiv.h
> +++ b/include/linux/usb/usb_phy_gen_xceiv.h
> @@ -3,7 +3,7 @@
> 
>  #include <linux/usb/otg.h>
> 
> -struct usb_phy_gen_xceiv_platform_data {
> +struct usb_phy_generic_platform_data {
>  	enum usb_phy_type type;
>  	unsigned long clk_rate;
> 
> @@ -15,14 +15,14 @@ struct usb_phy_gen_xceiv_platform_data {
> 
>  #if defined(CONFIG_NOP_USB_XCEIV) ||
> (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
>  /* sometimes transceivers are accessed only through e.g. ULPI */
> -extern void usb_nop_xceiv_register(void);
> -extern void usb_nop_xceiv_unregister(void);
> +extern void usb_phy_generic_register(void);
> +extern void usb_phy_generic_unregister(void);
>  #else
> -static inline void usb_nop_xceiv_register(void)
> +static inline void usb_phy_generic_register(void)
>  {
>  }
> 
> -static inline void usb_nop_xceiv_unregister(void)
> +static inline void usb_phy_generic_unregister(void)
>  {
>  }
>  #endif

I applied this against mainline and arch/arm/mach-omap2/usb-host.c also 
needed to be fixed up.

Regards,

Leigh.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
