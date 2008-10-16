From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-omap-git+] twl4030-usb updates/fixes
Date: Thu, 16 Oct 2008 13:09:23 -0700
Message-ID: <20081016200922.GR15820@atomide.com>
References: <200810161232.43199.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60713 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYJPUJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 16:09:28 -0400
Content-Disposition: inline
In-Reply-To: <200810161232.43199.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081016 12:34]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Simplify handling of VBUS and ID status and the USB_PRES interrupt.
> This seems to resolve the problems I previously saw on Beagle and
> Overo boards.
> 
>  - Read the status directly, instead of trying to infer it from
>    dodgey side effects of IRQ handling and trigger tweaking.
> 
>  - Stop trying to arrange those dodgey side effects; just leave
>    the IRQ enabled at all times.
> 
>  - Check that status as part of driver probe, so the PHY can
>    always be active by the time it's needed.  (BUGFIX!)
> 
>  - Re-sequence probe() to be less racey, and to avoid duplicating
>    logic found elsewhere (notably irq handling and PHY activation).
> 
>  - Make the irq_chip be the exclusive owner of PWR_EDR (finally).
> 
>  - Get rid of needless work_struct ... in this irq handling thread,
>    it's safe and cheap to call sysfs_notify() directly.
> 
> Stop enabling IRQs on the USB subchip.  There's no IRQ handler for
> them, and since ALT_INT_REROUTE isn't being set they'll never
> arrive ... so there's no point to enabling them.
> 
> Also add some comments about other things such an otg_transciever
> driver should be doing, fixing minor omissions; and remove some
> unnecessary file inclusions.

Pushing today, I guess that's it for the USB problems for now.

Tony

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> NOTE:  applies on top of the previous patches updating IRQ
> handling and creating drivers/mfd/twl4030-irq.c ...
> 
>  drivers/i2c/chips/twl4030-usb.c |  209 ++++++++++++++++++--------------------
>  1 file changed, 104 insertions(+), 105 deletions(-)
> 
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -26,16 +26,12 @@
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/time.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
>  #include <linux/io.h>
> -#include <linux/usb.h>
> -#include <linux/usb/ch9.h>
> -#include <linux/usb/gadget.h>
> +#include <linux/delay.h>
>  #include <linux/usb/otg.h>
>  #include <linux/i2c/twl4030.h>
>  #include <mach/usb.h>
> @@ -237,10 +233,6 @@
>  #define PMBR1				0x0D
>  #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
>  
> -/* In module TWL4030_MODULE_INT */
> -#define REG_PWR_EDR1			0x05
> -#define USB_PRES_FALLING		(1 << 4)
> -#define USB_PRES_RISING			(1 << 5)
>  
>  /* bits in OTG_CTRL */
>  #define	OTG_XCEIV_OUTPUTS \
> @@ -256,8 +248,14 @@
>  	OTG_CTRL_BITS)
>  
>  
> +enum linkstat {
> +	USB_LINK_UNKNOWN = 0,
> +	USB_LINK_NONE,
> +	USB_LINK_VBUS,
> +	USB_LINK_ID,
> +};
> +
>  struct twl4030_usb {
> -	struct work_struct	irq_work;
>  	struct otg_transceiver	otg;
>  	struct device		*dev;
>  
> @@ -267,8 +265,8 @@ struct twl4030_usb {
>  	/* pin configuration */
>  	enum twl4030_usb_mode	usb_mode;
>  
> -	unsigned		vbus:1;
>  	int			irq;
> +	u8			linkstat;
>  	u8			asleep;
>  	bool			irq_enabled;
>  };
> @@ -326,21 +324,27 @@ static inline int twl4030_usb_write(stru
>  	return ret;
>  }
>  
> -static inline int twl4030_usb_read(struct twl4030_usb *twl, u8 address)
> +static inline int twl4030_readb(struct twl4030_usb *twl, u8 module, u8 address)
>  {
>  	u8 data;
>  	int ret = 0;
>  
> -	ret = twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data, address);
> +	ret = twl4030_i2c_read_u8(module, &data, address);
>  	if (ret >= 0)
>  		ret = data;
>  	else
>  		dev_warn(twl->dev,
> -			"TWL4030:USB:Read[0x%x] Error %d\n", address, ret);
> +			"TWL4030:readb[0x%x,0x%x] Error %d\n",
> +					module, address, ret);
>  
>  	return ret;
>  }
>  
> +static inline int twl4030_usb_read(struct twl4030_usb *twl, u8 address)
> +{
> +	return twl4030_readb(twl, TWL4030_MODULE_USB, address);
> +}
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static inline int
> @@ -357,6 +361,39 @@ twl4030_usb_clear_bits(struct twl4030_us
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static enum linkstat twl4030_usb_linkstat(struct twl4030_usb *twl)
> +{
> +	int	status;
> +	int	linkstat = USB_LINK_UNKNOWN;
> +
> +	/* STS_HW_CONDITIONS */
> +	status = twl4030_readb(twl, TWL4030_MODULE_PM_MASTER, 0x0f);
> +	if (status < 0)
> +		dev_err(twl->dev, "USB link status err %d\n", status);
> +	else if (status & BIT(7))
> +		linkstat = USB_LINK_VBUS;
> +	else if (status & BIT(2))
> +		linkstat = USB_LINK_ID;
> +	else
> +		linkstat = USB_LINK_NONE;
> +
> +	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
> +			status, status, linkstat);
> +
> +	spin_lock_irq(&twl->lock);
> +	twl->linkstat = linkstat;
> +	if (linkstat == USB_LINK_ID) {
> +		twl->otg.default_a = true;
> +		twl->otg.state = OTG_STATE_A_IDLE;
> +	} else {
> +		twl->otg.default_a = false;
> +		twl->otg.state = OTG_STATE_B_IDLE;
> +	}
> +	spin_unlock_irq(&twl->lock);
> +
> +	return linkstat;
> +}
> +
>  static void twl4030_usb_set_mode(struct twl4030_usb *twl, int mode)
>  {
>  	twl->usb_mode = mode;
> @@ -410,24 +447,6 @@ static void twl4030_i2c_access(struct tw
>  	}
>  }
>  
> -static void usb_irq_enable(struct twl4030_usb *twl, int trigger)
> -{
> -	set_irq_type(twl->irq, trigger);
> -
> -	if (!twl->irq_enabled) {
> -		enable_irq(twl->irq);
> -		twl->irq_enabled = true;
> -	}
> -}
> -
> -static void usb_irq_disable(struct twl4030_usb *twl)
> -{
> -	if (twl->irq_enabled) {
> -		disable_irq(twl->irq);
> -		twl->irq_enabled = false;
> -	}
> -}
> -
>  static void twl4030_phy_power(struct twl4030_usb *twl, int on)
>  {
>  	u8 pwr;
> @@ -448,16 +467,9 @@ static void twl4030_phy_power(struct twl
>  
>  static void twl4030_phy_suspend(struct twl4030_usb *twl, int controller_off)
>  {
> -	if (controller_off)
> -		usb_irq_disable(twl);
> -
>  	if (twl->asleep)
>  		return;
>  
> -	if (!controller_off)
> -		/* enable rising edge interrupt to detect cable attach */
> -		usb_irq_enable(twl, IRQ_TYPE_EDGE_RISING);
> -
>  	twl4030_phy_power(twl, 0);
>  	twl->asleep = 1;
>  }
> @@ -467,9 +479,6 @@ static void twl4030_phy_resume(struct tw
>  	if (!twl->asleep)
>  		return;
>  
> -	/* enable falling edge interrupt to detect cable detach */
> -	usb_irq_enable(twl, IRQ_TYPE_EDGE_FALLING);
> -
>  	twl4030_phy_power(twl, 1);
>  	twl4030_i2c_access(twl, 1);
>  	twl4030_usb_set_mode(twl, twl->usb_mode);
> @@ -514,25 +523,18 @@ static ssize_t twl4030_usb_vbus_show(str
>  	int ret = -EINVAL;
>  
>  	spin_lock_irqsave(&twl->lock, flags);
> -	ret = sprintf(buf, "%s\n", twl->vbus ? "on" : "off");
> +	ret = sprintf(buf, "%s\n",
> +			(twl->linkstat == USB_LINK_VBUS) ? "on" : "off");
>  	spin_unlock_irqrestore(&twl->lock, flags);
>  
>  	return ret;
>  }
>  static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
>  
> -static void twl4030_usb_irq_work(struct work_struct *work)
> -{
> -	struct twl4030_usb *twl = container_of(work,
> -			struct twl4030_usb, irq_work);
> -
> -	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
> -}
> -
>  static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  {
>  	struct twl4030_usb *twl = _twl;
> -	u8 val;
> +	int status;
>  
>  #ifdef CONFIG_LOCKDEP
>  	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
> @@ -542,27 +544,28 @@ static irqreturn_t twl4030_usb_irq(int i
>  	local_irq_enable();
>  #endif
>  
> -	/* FIXME stop accessing PWR_EDR1 ... if nothing else, we
> -	 * know which edges we told the IRQ to trigger on.  And
> -	 * there seem to be OTG_specific registers and irqs that
> -	 * provide the right info without guessing like this:
> -	 * USB_INT_STS, ID_STATUS, STS_HW_CONDITIONS, etc.
> -	 */
> +	status = twl4030_usb_linkstat(twl);
> +	if (status != USB_LINK_UNKNOWN) {
>  
> -	/* action based on cable attach or detach */
> -	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
> -				&val, REG_PWR_EDR1) < 0);
> +		/* FIXME add a set_power() method so that B-devices can
> +		 * configure the charger appropriately.  It's not always
> +		 * correct to consume VBUS power, and how much current to
> +		 * consume is a function of the USB configuration chosen
> +		 * by the host.
> +		 *
> +		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
> +		 * its disconnect() sibling, when changing to/from the
> +		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
> +		 * starts to handle softconnect right.
> +		 */
> +		twl4030charger_usb_en(status == USB_LINK_VBUS);
>  
> -	if (val & USB_PRES_RISING) {
> -		twl4030_phy_resume(twl);
> -		twl4030charger_usb_en(1);
> -		twl->vbus = 1;
> -	} else {
> -		twl4030charger_usb_en(0);
> -		twl->vbus = 0;
> -		twl4030_phy_suspend(twl, 0);
> +		if (status == USB_LINK_NONE)
> +			twl4030_phy_suspend(twl, 0);
> +		else
> +			twl4030_phy_resume(twl);
>  	}
> -	schedule_work(&twl->irq_work);
> +	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
>  
>  	return IRQ_HANDLED;
>  }
> @@ -608,11 +611,6 @@ static int twl4030_set_peripheral(struct
>  
>  	twl->otg.state = OTG_STATE_B_IDLE;
>  
> -	twl4030_usb_set_bits(twl, USB_INT_EN_RISE,
> -			USB_INT_SESSVALID | USB_INT_VBUSVALID);
> -	twl4030_usb_set_bits(twl, USB_INT_EN_FALL,
> -			USB_INT_SESSVALID | USB_INT_VBUSVALID);
> -
>  	return 0;
>  }
>  
> @@ -639,8 +637,7 @@ static int twl4030_set_host(struct otg_t
>  	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
>  			TWL4030_OTG_CTRL_DMPULLDOWN
>  				| TWL4030_OTG_CTRL_DPPULLDOWN);
> -	twl4030_usb_set_bits(twl, USB_INT_EN_RISE, USB_INT_IDGND);
> -	twl4030_usb_set_bits(twl, USB_INT_EN_FALL, USB_INT_IDGND);
> +
>  	twl4030_usb_set_bits(twl, FUNC_CTRL, FUNC_CTRL_SUSPENDM);
>  	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL, TWL4030_OTG_CTRL_DRVVBUS);
>  
> @@ -651,8 +648,7 @@ static int __init twl4030_usb_probe(stru
>  {
>  	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
>  	struct twl4030_usb	*twl;
> -	int status;
> -	u8			vbus;
> +	int			status;
>  
>  	twl = kzalloc(sizeof *twl, GFP_KERNEL);
>  	if (!twl)
> @@ -663,26 +659,38 @@ static int __init twl4030_usb_probe(stru
>  		return -EINVAL;
>  	}
>  
> -	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
> -				&vbus, REG_PWR_EDR1) < 0);
> -	vbus &= USB_PRES_RISING;
> -
>  	twl->dev		= &pdev->dev;
>  	twl->irq		= platform_get_irq(pdev, 0);
> +	twl->otg.dev		= twl->dev;
> +	twl->otg.label		= "twl4030";
>  	twl->otg.set_host	= twl4030_set_host;
>  	twl->otg.set_peripheral	= twl4030_set_peripheral;
>  	twl->otg.set_suspend	= twl4030_set_suspend;
>  	twl->usb_mode		= pdata->usb_mode;
> -	twl->vbus		= vbus ? 1 : 0;
> +	twl->asleep		= 1;
>  
>  	/* init spinlock for workqueue */
>  	spin_lock_init(&twl->lock);
>  
> -	/* init irq workqueue before request_irq */
> -	INIT_WORK(&twl->irq_work, twl4030_usb_irq_work);
> +	twl4030_usb_ldo_init(twl);
> +	otg_set_transceiver(&twl->otg);
> +
> +	platform_set_drvdata(pdev, twl);
> +	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> +		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  
> +	/* Our job is to use irqs and status from the power module
> +	 * to keep the transceiver disabled when nothing's connected.
> +	 *
> +	 * FIXME we actually shouldn't start enabling it until the
> +	 * USB controller drivers have said they're ready, by calling
> +	 * set_host() and/or set_peripheral() ... OTG_capable boards
> +	 * need both handles, otherwise just one suffices.
> +	 */
>  	twl->irq_enabled = true;
> -	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
> +	status = request_irq(twl->irq, twl4030_usb_irq,
> +			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +			"twl4030_usb", twl);
>  	if (status < 0) {
>  		dev_dbg(&pdev->dev, "can't get IRQ %d, err %d\n",
>  			twl->irq, status);
> @@ -690,25 +698,17 @@ static int __init twl4030_usb_probe(stru
>  		return status;
>  	}
>  
> -	twl4030_usb_ldo_init(twl);
> -	twl4030_phy_power(twl, 1);
> -	twl4030_i2c_access(twl, 1);
> -	twl4030_usb_set_mode(twl, twl->usb_mode);
> -
> -	twl->asleep = 0;
> -
> -	if (twl->usb_mode == T2_USB_MODE_ULPI) {
> -		twl4030_i2c_access(twl, 0);
> -		twl4030_phy_suspend(twl, 0);
> -	}
> +	/* The IRQ handler just handles changes from the previous states
> +	 * of the ID and VBUS pins ... in probe() we must initialize that
> +	 * previous state.  The easy way:  fake an IRQ.
> +	 *
> +	 * REVISIT:  a real IRQ might have happened already, if PREEMPT is
> +	 * enabled.  Else the IRQ may not yet be configured or enabled,
> +	 * because of scheduling delays.
> +	 */
> +	twl4030_usb_irq(twl->irq, twl);
>  
> -	otg_set_transceiver(&twl->otg);
> -	platform_set_drvdata(pdev, twl);
>  	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
> -
> -	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
> -
>  	return 0;
>  }
>  
> @@ -717,7 +717,6 @@ static int __exit twl4030_usb_remove(str
>  	struct twl4030_usb *twl = platform_get_drvdata(pdev);
>  	int val;
>  
> -	usb_irq_disable(twl);
>  	free_irq(twl->irq, twl);
>  	device_remove_file(twl->dev, &dev_attr_vbus);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
