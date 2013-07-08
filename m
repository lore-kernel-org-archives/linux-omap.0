From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v3 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Mon, 8 Jul 2013 22:44:02 +0300
Message-ID: <20130708194402.GA8516@blackmetal.musicnaut.iki.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
 <1371575221-360-5-git-send-email-aaro.koskinen@iki.fi>
 <20130708072109.GA16635@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130708072109.GA16635-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jul 08, 2013 at 10:21:09AM +0300, Felipe Balbi wrote:
> On Tue, Jun 18, 2013 at 08:07:01PM +0300, Aaro Koskinen wrote:
> > +static ssize_t vbus_state_show(struct device *device,
> > +			       struct device_attribute *attr, char *buf)
> > +{
> > +	struct tahvo_usb *tu = dev_get_drvdata(device);
> > +	return sprintf(buf, "%d\n", tu->vbus_state);
> > +}
> > +static DEVICE_ATTR(vbus_state, 0444, vbus_state_show, NULL);
> 
> VBUS status sounds generic enough, also, you should be printing on/off
> here instead of tahvo-specific values. Some users might not have access
> to the docs, or even the kernel sources, to understand what that integer
> means.

Ok, I'll fix.

> > +static void tahvo_usb_become_host(struct tahvo_usb *tu)
> > +{
> > +	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
> > +
> > +	extcon_set_cable_state(&tu->extcon, "USB-HOST", true);
> > +
> > +	/* Power up the transceiver in USB host mode */
> > +	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
> > +		   USBR_MASTER_SW2 | USBR_MASTER_SW1);
> > +	tu->phy.state = OTG_STATE_A_IDLE;
> > +
> > +	check_vbus_state(tu);
> > +}
> > +
> > +static void tahvo_usb_stop_host(struct tahvo_usb *tu)
> > +{
> > +	tu->phy.state = OTG_STATE_A_IDLE;
> 
> shouldn't you undo tahvo_usb_become_host() here ? I mean, set the
> transceiver to SLAVE ?

tahvo_usb_become_peripheral() (or power_off) is always called after this
function. Actually, these stop functions can be eliminated altogether
as they are only called from a single place...

> > +static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
> > +{
> > +	struct tahvo_usb *tu = container_of(otg->phy, struct tahvo_usb, phy);
> > +
> > +	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
> > +
> > +	if (otg == NULL)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&tu->serialize);
> > +
> > +	if (host == NULL) {
> > +		if (tu->tahvo_mode == TAHVO_MODE_HOST)
> > +			tahvo_usb_power_off(tu);
> > +		otg->host = NULL;
> > +		mutex_unlock(&tu->serialize);
> > +		return 0;
> > +	}
> > +
> > +	if (tu->tahvo_mode == TAHVO_MODE_HOST) {
> > +		otg->host = NULL;
> > +		tahvo_usb_become_host(tu);
> > +	}
> > +
> > +	otg->host = host;
> > +
> > +	mutex_unlock(&tu->serialize);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tahvo_usb_set_peripheral(struct usb_otg *otg,
> > +				    struct usb_gadget *gadget)
> 
> I want to get rid of the extra 'gadget' and 'host' parameters on
> ->set_host() and ->set_peripheral(). Nobody really uses them other than:
> 
> my_phy->phy.otg->{gadget,host} = {gadget,host};
> 
> For that, I need all other PHYs to stop relying on those parameters and
> I'll cook patches for that for v3.12 merge window.

How will the PHY know if there is a host/gadget driver present? I guess
I will need to wait for those patches...

> > +static ssize_t otg_mode_store(struct device *device,
> > +			      struct device_attribute *attr,
> > +			      const char *buf, size_t count)
> > +{
> > +	struct tahvo_usb *tu = dev_get_drvdata(device);
> > +	int r;
> > +
> > +	mutex_lock(&tu->serialize);
> > +	if (count >= 4 && strncmp(buf, "host", 4) == 0) {
> > +		if (tu->tahvo_mode == TAHVO_MODE_PERIPHERAL)
> > +			tahvo_usb_stop_peripheral(tu);
> > +		tu->tahvo_mode = TAHVO_MODE_HOST;
> > +		if (tu->phy.otg->host) {
> > +			dev_info(device, "HOST mode: host controller present\n");
> > +			tahvo_usb_become_host(tu);
> > +		} else {
> > +			dev_info(device, "HOST mode: no host controller, powering off\n");
> > +			tahvo_usb_power_off(tu);
> > +		}
> > +		r = strlen(buf);
> > +	} else if (count >= 10 && strncmp(buf, "peripheral", 10) == 0) {
> > +		if (tu->tahvo_mode == TAHVO_MODE_HOST)
> > +			tahvo_usb_stop_host(tu);
> > +		tu->tahvo_mode = TAHVO_MODE_PERIPHERAL;
> > +		if (tu->phy.otg->gadget) {
> > +			dev_info(device, "PERIPHERAL mode: gadget driver present\n");
> > +			tahvo_usb_become_peripheral(tu);
> > +		} else {
> > +			dev_info(device, "PERIPHERAL mode: no gadget driver, powering off\n");
> > +			tahvo_usb_power_off(tu);
> > +		}
> > +		r = strlen(buf);
> > +	} else {
> > +		r = -EINVAL;
> > +	}
> > +	mutex_unlock(&tu->serialize);
> > +
> > +	return r;
> > +}
> > +
> > +static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
> 
> this looks like something which would be very nice if implemented
> generically. Since you, anyway miss the documentation in
> Documentation/ABI/ and need to respin the patch, how about making this
> generic ?

Ok, I'll try to come up with something...

> > +static int tahvo_usb_probe(struct platform_device *pdev)
> > +{
> > +	struct retu_dev *rdev = dev_get_drvdata(pdev->dev.parent);
> > +	struct tahvo_usb *tu;
> > +	int ret;
> > +
> > +	tu = devm_kzalloc(&pdev->dev, sizeof(*tu), GFP_KERNEL);
> > +	if (!tu)
> > +		return -ENOMEM;
> > +
> > +	tu->phy.otg = devm_kzalloc(&pdev->dev, sizeof(*tu->phy.otg),
> > +				   GFP_KERNEL);
> > +	if (!tu->phy.otg)
> > +		return -ENOMEM;
> > +
> > +	tu->pt_dev = pdev;
> > +
> > +	/* Default mode */
> > +#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
> > +	tu->tahvo_mode = TAHVO_MODE_HOST;
> > +#else
> > +	tu->tahvo_mode = TAHVO_MODE_PERIPHERAL;
> > +#endif
> 
> should you call become_host()/become_peripheral() here ?

Not needed. Once the PHY is registered, the framework will call set_host /
set_peripheral and the HW gets set to correct state.

> > +	mutex_init(&tu->serialize);
> > +
> > +	tu->ick = devm_clk_get(&pdev->dev, "usb_l4_ick");
> > +	if (!IS_ERR(tu->ick))
> > +		clk_enable(tu->ick);
> > +
> > +	/*
> > +	 * Set initial state, so that we generate kevents only on state changes.
> > +	 */
> > +	tu->vbus_state = retu_read(rdev, TAHVO_REG_IDSR) & TAHVO_STAT_VBUS;
> > +
> > +	tu->extcon.name = DRIVER_NAME;
> > +	tu->extcon.supported_cable = tahvo_cable;
> > +	ret = extcon_dev_register(&tu->extcon, &pdev->dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not register extcon device: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Set the initial cable state. */
> > +	extcon_set_cable_state(&tu->extcon, "USB-HOST",
> > +			       tu->tahvo_mode == TAHVO_MODE_HOST);
> > +	extcon_set_cable_state(&tu->extcon, "USB", tu->vbus_state);
> > +
> > +	tu->irq = platform_get_irq(pdev, 0);
> > +	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt, 0,
> > +				   "tahvo-vbus", tu);
> 
> since your hardirq handler is NULL, you *must* pass IRQF_ONESHOT.

Ok.

> /Could also use devm_request_threaded_irq()

Does not really help much, since the IRQ has to be freed manually anyway
(to ensure it's disabled before usb_remove_phy(); also looks like it's
currently enabled too early...).

> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not register tahvo-vbus irq: %d\n",
> > +			ret);
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	/* Attributes */
> > +	ret = device_create_file(&pdev->dev, &dev_attr_vbus_state);
> > +	ret |= device_create_file(&pdev->dev, &dev_attr_otg_mode);
> 
> heh, Greg wrote a very interesting article recently (look at his blog)
> discussing kernel/userland races wrt creation of sysfs files.

[...]

> what if someone accesses the sysfs file you've already created before
> you call dev_set_drvdata? (not sure  if it's possible).

Yes, that's a bug, will fix.

Thanks for comments,

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
