From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH RFC 1/5] omap3: add platform init code for OHCI driver
Date: Mon, 22 Mar 2010 11:01:25 -0500
Message-ID: <A24693684029E5489D1D202277BE89445428C1CF@dlee02.ent.ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40188 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0CVQB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 12:01:26 -0400
In-Reply-To: <1269171123-9874-2-git-send-email-gadiyar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>

Hi Anand,

I just have a very minor comment, nothing functional :)

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Anand Gadiyar
> Sent: Sunday, March 21, 2010 6:32 AM
> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Gadiyar, Anand
> Subject: [PATCH RFC 1/5] omap3: add platform init code for OHCI driver
> 
> Add platform init code for the OMAP3 OHCI driver.
> 
> Also, by default add mux-mode changes for all 6 pads for a
> given port. This needs to be tailored down depending on the
> actual port modes used.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/usb-ehci.c        |  131
> ++++++++++++++++++++++++++++++++++
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
> +
> +static void usb_release(struct device *dev)
> +{
> +	/* normally not freed */
> +}
> +
> +static struct platform_device ohci_device = {
> +	.name           = "ohci-omap3",
> +	.id             = 0,
> +	.dev = {
> +		.release		= usb_release,
> +		.dma_mask               = &ohci_dmamask,
> +		.coherent_dma_mask      = 0xffffffff,
> +		.platform_data          = NULL,
> +	},
> +	.num_resources  = ARRAY_SIZE(ohci_resources),
> +	.resource       = ohci_resources,
> +};
> +
> +static void setup_ohci_io_mux(enum ohci_omap3_port_mode *port_mode)
> +{
> +	/* REVISIT: these need to be tailored for each of the modes */
> +	switch (port_mode[0]) {
> +	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> +	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> +		omap_mux_init_signal("mm1_rxdp",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm1_rxdm",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm1_txse0",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm1_rxrcv",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm1_txdat",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm1_txen_n", OMAP_PIN_OUTPUT);
> +		break;
> +	case OMAP_OHCI_PORT_MODE_UNUSED:
> +	default:
> +		/* FALLTHROUGH */

Is this the right place for the fall through comment? I guess you meant
Between 'case OMAP_OHCI_PORT_MODE_UNUSED:' and "default:" lines...

Anyways, IMHO, as there's no code to execute in default case, maybe it's a bit unnecessary to state you'll falling through.

> +		break;
> +	}
> +	switch (port_mode[1]) {
> +	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> +	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> +		omap_mux_init_signal("mm2_rxdp",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm2_rxdm",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm2_txse0",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm2_rxrcv",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm2_txdat",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm2_txen_n", OMAP_PIN_OUTPUT);
> +		break;
> +	case OMAP_OHCI_PORT_MODE_UNUSED:
> +	default:
> +		/* FALLTHROUGH */

Same case here.

> +		break;
> +	}
> +	switch (port_mode[2]) {
> +	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> +	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> +		omap_mux_init_signal("mm3_rxdp",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm3_rxdm",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm3_txse0",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm3_rxrcv",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm3_txdat",
> +			OMAP_PIN_INPUT_PULLDOWN);
> +		omap_mux_init_signal("mm3_txen_n", OMAP_PIN_OUTPUT);
> +		break;
> +	case OMAP_OHCI_PORT_MODE_UNUSED:
> +	default:
> +		/* FALLTHROUGH */

And here.

Regards,
Sergio

> +		break;
> +	}
> +}
> +
> +void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data
> *pdata)
> +{
> +	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
> +
> +	/* Setup Pin IO MUX for OHCI */
> +	if (cpu_is_omap34xx())
> +		setup_ohci_io_mux(pdata->port_mode);
> +
> +	if (platform_device_register(&ohci_device) < 0) {
> +		pr_err("Unable to register FS-USB (OHCI) device\n");
> +		return;
> +	}
> +}
> +
> +#else
> +
> +void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data
> *pdata)
> +{
> +}
> +
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
>  /*-----------------------------------------------------------------------
> --*/
> 
>  #define OMAP1_OTG_BASE			0xfffb0400
> @@ -55,6 +73,8 @@ extern void usb_musb_init(struct omap_mu
> 
>  extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data
> *pdata);
> 
> +extern void usb_ohci_init(struct ohci_hcd_omap_platform_data *pdata);
> +
>  #endif
> 
>  void omap_usb_init(struct omap_usb_config *pdata);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
