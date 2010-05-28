From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3 v3] AM35x: Add musb support
Date: Fri, 28 May 2010 18:09:16 +0400
Message-ID: <4BFFCE8C.40909@ru.mvista.com>
References: <1274769522-28212-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274769522-28212-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
> It has USB phy built inside the IP itself.

> Also added ARCH_AM35x which is required to differentiate musb ips
> between OMAP3x and AM35x. This config would be used to for below
> purposes,
> 	- Select am3517.c instead of omap2430.c for compilation
> 	  at drivers/usb/musb directory. Please note there are
> 	  significant differneces in these two files as musb ip
> 	  in quite different on AM35x.
> 	- Select workaround codes applicable for AM35x musb issues.
> 	  one such workaround is for bytewise read issue on AM35x.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

[...]

> @@ -375,6 +376,43 @@ static void __init am3517_evm_init_irq(void)
>  	omap_gpio_init();
>  }
>  
> +static struct omap_musb_board_data musb_board_data = {
> +	.interface_type         = MUSB_INTERFACE_ULPI,
> +	.mode                   = MUSB_OTG,
> +	.power                  = 500,
> +};
> +
> +static __init void am3517_evm_musb_init(void)
> +{
> +	u32 devconf2;
> +
> +	/*
> +	 * Set up USB clock/mode in the DEVCONF2 register.
> +	 */
> +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> +
> +	/* USB2.0 PHY reference clock is 13 MHz */
> +	devconf2 &= ~CONF2_REFFREQ;
> +	devconf2 |=  CONF2_REFFREQ_13MHZ;
> +
> +	/*
> +	 * We have to override VBUS/ID signals when MUSB is configured into the
> +	 * host-only mode -- ID pin will float if no cable is connected, so the
> +	 * controller won't be able to drive VBUS thinking that it's a B-device.
> +	 * Otherwise, we want to use the OTG mode and enable VBUS comparators.
> +	 */
> +	devconf2 &= ~CONF2_OTGMODE;
> +#ifdef	CONFIG_USB_MUSB_HOST
> +	devconf2 |=  CONF2_FORCE_HOST;

    Well, this is only necessary if the board doesn't have pulldown on 
the USB ID signal. On DA830 EVM, rev. of the board A had it, and it got 
removed on the later revisions (presumably it conflicted with OTG 
function?), so this override became necessary. So, make sure this is 
indeed necessary on your board as using the overrides isn't generally 
desirable (they all also override VBUS sensing in addition to ID pin).

> +#else
> +	devconf2 |=  CONF2_SESENDEN | CONF2_VBDTCTEN;
> +#endif
> +
> +	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> +
> +	usb_musb_init(&musb_board_data);
> +}
> +
>  static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
>  	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
>  #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
