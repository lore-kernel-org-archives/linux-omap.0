From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [4/7 v3] usb: otg: OMAP4430: Add phy_suspend function pointer
 to twl4030_usb_data
Date: Wed, 16 Feb 2011 14:57:04 +0300
Message-ID: <4D5BBB90.1080004@ru.mvista.com>
References: <1297857049-27367-1-git-send-email-hemahk@ti.com> <1297857049-27367-4-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297857049-27367-4-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 16-02-2011 14:50, Hema HK wrote:

> From: Kalliguddi, Hema<hemahk-l0cyMroinI0@public.gmane.org>

> Introduce the .phy_suspend function pointer to twl4030_usb_data structure.
> assign the function to it for both sdp board and panda boards.
> This will be used by the twl6030-usb transceiver driver.

> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
> arch/arm/mach-omap2/board-4430sdp.c    |    1 +
>   arch/arm/mach-omap2/board-omap4panda.c |    1 +
>   arch/arm/plat-omap/include/plat/usb.h  |    1 +
>   include/linux/i2c/twl.h                |    2 ++
>   4 files changed, 5 insertions(+)
>
> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> @@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
>   	.phy_exit	= omap4430_phy_exit,
>   	.phy_power	= omap4430_phy_power,
>   	.phy_set_clock	= omap4430_phy_set_clk,
> +	.phy_suspend	= omap4430_phy_suspend,
>   };
>
>   static struct omap2_hsmmc_info mmc[] = {
> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> @@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
>   	.phy_exit	= omap4430_phy_exit,
>   	.phy_power	= omap4430_phy_power,
>   	.phy_set_clock	= omap4430_phy_set_clk,
> +	.phy_suspend	= omap4430_phy_suspend,
>   };
>
>   static struct omap2_hsmmc_info mmc[] = {
> Index: linux-2.6/include/linux/i2c/twl.h
> ===================================================================
> --- linux-2.6.orig/include/linux/i2c/twl.h
> +++ linux-2.6/include/linux/i2c/twl.h
> @@ -600,6 +600,8 @@ struct twl4030_usb_data {
>   	int		(*phy_power)(struct device *dev, int iD, int on);
>   	/* enable/disable  phy clocks */
>   	int		(*phy_set_clock)(struct device *dev, int on);
> +	/* suspend/resume of phy */
> +	int		(*phy_suspend)(struct device *dev, int suspend);
>   };
>
>   struct twl4030_ins {

    You're still doing things backwards. Sigh...

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
