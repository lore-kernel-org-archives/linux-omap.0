From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH RFC 2/5] usb: ohci: introduce omap3 ohci-hcd driver
Date: Sun, 21 Mar 2010 20:43:46 +0200
Message-ID: <20100321184345.GB3841@gandalf>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1269171123-9874-3-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Mar 21, 2010 at 05:02:00PM +0530, Anand Gadiyar wrote:
> This driver has been sitting in internal trees for a long time,
> for no real reason. I've finally found the time to clean it
> up and submit it for review.

Thanks a lot :-)

> +struct ohci_hcd_omap {
> +	struct ohci_hcd		*ohci;
> +	struct device		*dev;
> +
> +	struct clk		*usbhost_ick;
> +	struct clk		*usbhost2_120m_fck;
> +	struct clk		*usbhost1_48m_fck;
> +	struct clk		*usbtll_fck;
> +	struct clk		*usbtll_ick;
> +
> +	/* port_mode: TLL/PHY, 2/3/4/6-PIN, DP-DM/DAT-SE0 */
> +	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> +	void __iomem		*uhh_base;
> +	void __iomem		*tll_base;
> +	void __iomem		*ohci_base;

this is something we need to think carefully, right ? I believe ehci is
already ioremap()ing uhh_base and tll_base ??

> +static void ohci_omap3_clock_power(struct ohci_hcd_omap *omap, int on)
> +{
> +	if (on) {
> +		clk_enable(omap->usbtll_ick);
> +		clk_enable(omap->usbtll_fck);
> +		clk_enable(omap->usbhost_ick);
> +		clk_enable(omap->usbhost1_48m_fck);
> +		clk_enable(omap->usbhost2_120m_fck);
> +	} else {
> +		clk_disable(omap->usbhost2_120m_fck);
> +		clk_disable(omap->usbhost1_48m_fck);
> +		clk_disable(omap->usbhost_ick);
> +		clk_disable(omap->usbtll_fck);
> +		clk_disable(omap->usbtll_ick);
> +	}
> +}
> +
> +static int ohci_omap3_init(struct usb_hcd *hcd)
> +{
> +	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +	int ret;
> +
> +	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
> +
> +	ret = ohci_init(ohci);
> +
> +	return ret;

how about:

static int ohci_omap3_init(struct usb_hcd *hcd)
{
	dev_dbg(hcd->self.controller, "starting OHCI controller\n");

	return ohci_init(hcd_to_ohci(hcd));
}

> +static int ohci_omap3_start(struct usb_hcd *hcd)
> +{
> +	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> +	int ret;
> +
> +	/*
> +	 * RemoteWakeupConnected has to be set explicitly before
> +	 * calling ohci_run. The reset value of RWC is 0.
> +	 */
> +	ohci->hc_control = OHCI_CTRL_RWC;
> +	writel(OHCI_CTRL_RWC, &ohci->regs->control);
> +
> +	ret = ohci_run(ohci);
> +
> +	if (ret < 0) {
> +		dev_err(hcd->self.controller, "can't start\n");
> +		ohci_stop(hcd);
> +		return ret;
> +	}

add a blank line before return

> +	return 0;
> +}
> +
> +

one blank line only.

> +/*-------------------------------------------------------------------------*/
> +
> +static unsigned ohci_omap3_fslsmode(enum ohci_omap3_port_mode mode)
> +{
> +	switch (mode) {
> +	case OMAP_OHCI_PORT_MODE_UNUSED:
> +	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> +		return 0x0;

what are these magic numbers ? Could we have some defines for those ? Or
at least some comment about them.

> +/* omap_start_ohc
> + *	- Start the TI USBHOST controller
> + */
> +static int omap_start_ohc(struct ohci_hcd_omap *omap, struct usb_hcd *hcd)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +	u32 reg = 0;
> +	int ret = 0;
> +
> +	dev_dbg(omap->dev, "starting TI OHCI USB Controller\n");
> +
> +	/* Get all the clock handles we need */
> +	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
> +	if (IS_ERR(omap->usbhost_ick)) {

some dev_dbg() or dev_err() on the failing cases would help when
debugging probe() failures.

> +		ret =  PTR_ERR(omap->usbhost_ick);
> +		goto err_host_ick;
> +	}
> +
> +	omap->usbhost2_120m_fck = clk_get(omap->dev, "usbhost_120m_fck");
> +	if (IS_ERR(omap->usbhost2_120m_fck)) {
> +		ret = PTR_ERR(omap->usbhost2_120m_fck);
> +		goto err_host_120m_fck;
> +	}
> +
> +	omap->usbhost1_48m_fck = clk_get(omap->dev, "usbhost_48m_fck");
> +	if (IS_ERR(omap->usbhost1_48m_fck)) {
> +		ret = PTR_ERR(omap->usbhost1_48m_fck);
> +		goto err_host_48m_fck;
> +	}
> +
> +	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
> +	if (IS_ERR(omap->usbtll_fck)) {
> +		ret = PTR_ERR(omap->usbtll_fck);
> +		goto err_tll_fck;
> +	}
> +
> +	omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
> +	if (IS_ERR(omap->usbtll_ick)) {
> +		ret = PTR_ERR(omap->usbtll_ick);
> +		goto err_tll_ick;
> +	}
> +
> +	/* Now enable all the clocks in the correct order */
> +	ohci_omap3_clock_power(omap, 1);
> +
> +	/* perform TLL soft reset, and wait until reset is complete */
> +	ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
> +			OMAP_USBTLL_SYSCONFIG_SOFTRESET);
> +
> +	/* Wait for TLL reset to complete */
> +	while (!(ohci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
> +			& OMAP_USBTLL_SYSSTATUS_RESETDONE)) {
> +		cpu_relax();
> +
> +		if (time_after(jiffies, timeout)) {
> +			dev_dbg(omap->dev, "operation timed out\n");
> +			ret = -EINVAL;
> +			goto err_sys_status;
> +		}
> +	}
> +
> +	dev_dbg(omap->dev, "TLL reset done\n");
> +
> +	/* (1<<3) = no idle mode only for initial debugging */
> +	ohci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
> +			OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
> +			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
> +			OMAP_USBTLL_SYSCONFIG_CACTIVITY);
> +
> +
> +	/* Put UHH in NoIdle/NoStandby mode */
> +	reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_SYSCONFIG);
> +	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
> +			| OMAP_UHH_SYSCONFIG_SIDLEMODE
> +			| OMAP_UHH_SYSCONFIG_CACTIVITY
> +			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
> +	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
> +	reg &= ~OMAP_UHH_SYSCONFIG_SOFTRESET;
> +
> +	ohci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
> +
> +	reg = ohci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
> +
> +	/* setup ULPI bypass and burst configurations */
> +	reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
> +			| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
> +			| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
> +	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
> +
> +	/*
> +	 * REVISIT: Pi_CONNECT_STATUS controls MStandby
> +	 * assertion and Swakeup generation - let us not
> +	 * worry about this for now. OMAP HWMOD framework
> +	 * might take care of this later. If not, we can
> +	 * update these registers when adding aggressive
> +	 * clock management code.
> +	 *
> +	 * For now, turn off all the Pi_CONNECT_STATUS bits
> +	 *
> +	if (omap->port_mode[0] == OMAP_OHCI_PORT_MODE_UNUSED)
> +		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
> +	if (omap->port_mode[1] == OMAP_OHCI_PORT_MODE_UNUSED)
> +		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
> +	if (omap->port_mode[2] == OMAP_OHCI_PORT_MODE_UNUSED)
> +		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
> +	 */
> +	reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
> +	reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
> +	reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
> +
> +	 if (omap_rev() <= OMAP3430_REV_ES2_1) {

can we do this check on the platform code instead and set a flag on the
platform_data ??

the driver has to be compilable on other archs so we don't break
randconfig.

> +static const struct hc_driver ohci_omap3_hc_driver = {
> +	.description =		hcd_name,
> +	.product_desc =		"OMAP3 OHCI Host Controller",
> +	.hcd_priv_size =	sizeof(struct ohci_hcd),
> +
> +	/*
> +	 * generic hardware linkage
> +	 */
> +	.irq =			ohci_irq,
> +	.flags =		HCD_USB11 | HCD_MEMORY,
> +
> +	/*
> +	 * basic lifecycle operations
> +	 */
> +	.reset =		ohci_omap3_init,
> +	.start =		ohci_omap3_start,
> +	.stop =			ohci_stop,
> +	.shutdown =		ohci_shutdown,
> +
> +	/*
> +	 * managing i/o requests and associated device resources
> +	 */
> +	.urb_enqueue =		ohci_urb_enqueue,
> +	.urb_dequeue =		ohci_urb_dequeue,
> +	.endpoint_disable =	ohci_endpoint_disable,
> +
> +	/*
> +	 * scheduling support
> +	 */
> +	.get_frame_number =	ohci_get_frame,
> +
> +	/*
> +	 * root hub support
> +	 */
> +	.hub_status_data =	ohci_hub_status_data,
> +	.hub_control =		ohci_hub_control,
> +#ifdef	CONFIG_PM
> +	.bus_suspend =		ohci_bus_suspend,
> +	.bus_resume =		ohci_bus_resume,
> +#endif
> +	.start_port_reset =	ohci_start_port_reset,
> +};
> +
> +/*-------------------------------------------------------------------------*/
> +
> +

one blank like only.

> +/* configure so an HC device and id are always provided */
> +/* always called with process context; sleeping is OK */

multi-line comment style is wrong.

> +/**
> + * ohci_hcd_omap_probe - initialize OMAP-based HCDs
> + *
> + * Allocates basic resources for this USB host controller, and
> + * then invokes the start() method for the HCD associated with it
> + * through the hotplug entry's driver_data.
> + */
> +static int ohci_hcd_omap_probe(struct platform_device *pdev)

__init or __devinit ??

> +{
> +	struct ohci_hcd_omap_platform_data *pdata = pdev->dev.platform_data;
> +	struct ohci_hcd_omap *omap;
> +	struct resource *res;
> +	struct usb_hcd *hcd;
> +
> +	int irq = platform_get_irq(pdev, 0);
> +	int ret = -ENODEV;
> +
> +	if (!pdata) {
> +		dev_dbg(&pdev->dev, "missing platform_data\n");
> +		goto err_pdata;
> +	}
> +
> +	if (usb_disabled())
> +		goto err_disabled;

you should do this before even testing for a platform_data.

> +/* may be called without controller electrically present */
> +/* may be called with controller, bus, and devices active */

multi-line comment style.

> +/**
> + * ohci_hcd_omap_remove - shutdown processing for OHCI HCDs
> + * @pdev: USB Host Controller being removed
> + *
> + * Reverses the effect of usb_hcd_omap_probe(), first invoking
> + * the HCD's stop() method.  It is always called from a thread
> + * context, normally "rmmod", "apmd", or something similar.
> + */
> +static int ohci_hcd_omap_remove(struct platform_device *pdev)

__exit or __devexit ??

> +static struct platform_driver ohci_hcd_omap3_driver = {
> +	.probe		= ohci_hcd_omap_probe,
> +	.remove		= ohci_hcd_omap_remove,

__exit_p() or __devexit_p() ??

> +	.shutdown	= ohci_hcd_omap_shutdown,
> +	.driver		= {
> +		.name	= "ohci-omap3",
> +	},

no suspend/resume yet ?? :-(

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
