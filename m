From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH RFC 1/5] omap3: add platform init code for OHCI driver
Date: Sun, 21 Mar 2010 20:26:24 +0200
Message-ID: <20100321182623.GA3841@gandalf>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1269171123-9874-2-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Mar 21, 2010 at 05:01:59PM +0530, Anand Gadiyar wrote:
> Add platform init code for the OMAP3 OHCI driver.
> 
> Also, by default add mux-mode changes for all 6 pads for a
> given port. This needs to be tailored down depending on the
> actual port modes used.
> 
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/usb-ehci.c        |  131 ++++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/usb.h |   20 +++++
>  2 files changed, 151 insertions(+)
> 
> Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
> +++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
> @@ -236,3 +236,134 @@ void __init usb_ehci_init(const struct e
>  
>  #endif /* CONFIG_USB_EHCI_HCD */
>  
> +#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +
> +static struct resource ohci_resources[] = {
> +	{
> +		.start   = OMAP34XX_OHCI_BASE,
> +		.end     = OMAP34XX_OHCI_BASE + SZ_1K - 1,
> +		.flags   = IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= OMAP34XX_UHH_CONFIG_BASE,
> +		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= OMAP34XX_USBTLL_BASE,
> +		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{         /* general IRQ */
> +		.start   = INT_34XX_OHCI_IRQ,
> +		.flags   = IORESOURCE_IRQ,
> +	}
> +};
> +
> +/* The dmamask must be set for OHCI to work */
> +static u64 ohci_dmamask = ~(u32)0;

DMA_BIT_MASK(32); ??

> +static void usb_release(struct device *dev)
> +{
> +	/* normally not freed */
> +}

unnecessary ?

> +static struct platform_device ohci_device = {
> +	.name           = "ohci-omap3",
> +	.id             = 0,
> +	.dev = {
> +		.release		= usb_release,
> +		.dma_mask               = &ohci_dmamask,
> +		.coherent_dma_mask      = 0xffffffff,
> +		.platform_data          = NULL,

static variable, doesn't need the NULL initialization.

[snip]

> +#endif /* CONFIG_USB_OHCI_HCD */
> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> @@ -13,6 +13,20 @@ enum ehci_hcd_omap_mode {
>  	EHCI_HCD_OMAP_MODE_TLL,
>  };
>  
> +enum ohci_omap3_port_mode {
> +	OMAP_OHCI_PORT_MODE_UNUSED,
> +	OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
> +	OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM,
> +	OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
> +	OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM,
> +	OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0,
> +	OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM,
> +	OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0,
> +	OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM,
> +	OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0,
> +	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM,
> +};
> +
>  struct ehci_hcd_omap_platform_data {
>  	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
>  	unsigned			phy_reset:1;
> @@ -21,6 +35,10 @@ struct ehci_hcd_omap_platform_data {
>  	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
>  };
>  
> +struct ohci_hcd_omap_platform_data {
> +	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  
>  #define OMAP1_OTG_BASE			0xfffb0400
> @@ -55,6 +73,8 @@ extern void usb_musb_init(struct omap_mu
>  
>  extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
>  
> +extern void usb_ohci_init(struct ohci_hcd_omap_platform_data *pdata);

missing const ??

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
