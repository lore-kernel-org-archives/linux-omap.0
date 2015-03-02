From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 13/15] twl4030_charger: add ac/mode to match usb/mode
Date: Mon, 2 Mar 2015 22:13:27 +0100
Message-ID: <20150302211327.GQ13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.8071.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043352.4243.8071.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:53, NeilBrown wrote:
> This allows AC charging to be turned off, much like usb charging.
> 
> "continuous" (aka "linear") mode maps to the CVENAC (constant voltage)
> feature of the twl4030.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -112,7 +112,7 @@ struct twl4030_bci {
>  	int			ichg_eoc, ichg_lo, ichg_hi;
>  	int			usb_cur, ac_cur;
>  	bool			ac_is_active;
> -	int			usb_mode; /* charging mode requested */
> +	int			usb_mode, ac_mode; /* charging mode requested */
>  #define	CHARGE_OFF	0
>  #define	CHARGE_AUTO	1
>  #define	CHARGE_LINEAR	2
> @@ -449,12 +449,18 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
>  /*
>   * Enable/Disable AC Charge funtionality.
>   */
> -static int twl4030_charger_enable_ac(bool enable)
> +static int twl4030_charger_enable_ac(struct twl4030_bci *bci, bool enable)
>  {
>  	int ret;
>  
> -	if (enable)
> -		ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOAC);
> +	if (bci->ac_mode == CHARGE_OFF)
> +		enable = false;
> +
> +	if (enable && bci->ac_mode == CHARGE_LINEAR)
> +		ret = twl4030_clear_set_boot_bci(0, (TWL4030_CVENAC |
> +						     TWL4030_BCIAUTOAC));
> +	else if (enable)
> +		ret = twl4030_clear_set_boot_bci(TWL4030_CVENAC, TWL4030_BCIAUTOAC);
>  	else
>  		ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC, 0);
>  
> @@ -688,9 +694,15 @@ twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = 2;
>  	else
>  		return -EINVAL;
> -	twl4030_charger_enable_usb(bci, false);
> -	bci->usb_mode = mode;
> -	status = twl4030_charger_enable_usb(bci, true);
> +	if (dev == bci->ac.dev) {
> +		twl4030_charger_enable_ac(bci, false);
> +		bci->ac_mode = mode;
> +		status = twl4030_charger_enable_ac(bci, true);
> +	} else {
> +		twl4030_charger_enable_usb(bci, false);
> +		bci->usb_mode = mode;
> +		status = twl4030_charger_enable_usb(bci, true);
> +	}
>  	return (status == 0) ? n : status;
>  }
>  
> @@ -704,9 +716,13 @@ twl4030_bci_mode_show(struct device *dev,
>  	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
>  	int len = 0;
>  	int i;
> +	int mode = bci->usb_mode;
> +
> +	if (dev == bci->ac.dev)
> +		mode = bci->ac_mode;
>  
>  	for (i = 0; i < ARRAY_SIZE(modes); i++)
> -		if (bci->usb_mode == i)
> +		if (mode == i)
>  			len += snprintf(buf+len, PAGE_SIZE-len,
>  					"[%s] ", modes[i]);
>  		else
> @@ -900,6 +916,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
>  	else
>  		bci->usb_cur = 100000;  /* 100mA */
>  	bci->usb_mode = CHARGE_AUTO;
> +	bci->ac_mode = CHARGE_AUTO;
>  
>  	bci->dev = &pdev->dev;
>  	bci->irq_chg = platform_get_irq(pdev, 0);
> @@ -988,10 +1005,12 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(bci->usb.dev, &dev_attr_mode))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> +	if (device_create_file(bci->ac.dev, &dev_attr_mode))
> +		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(bci->ac.dev, &dev_attr_max_current))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  
> -	twl4030_charger_enable_ac(true);
> +	twl4030_charger_enable_ac(bci, true);
>  	if (!IS_ERR_OR_NULL(bci->transceiver))
>  		twl4030_bci_usb_ncb(&bci->usb_nb,
>  				    bci->transceiver->last_event,
> @@ -1014,13 +1033,14 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
>  {
>  	struct twl4030_bci *bci = platform_get_drvdata(pdev);
>  
> -	twl4030_charger_enable_ac(false);
> +	twl4030_charger_enable_ac(bci, false);
>  	twl4030_charger_enable_usb(bci, false);
>  	twl4030_charger_enable_backup(0, 0);
>  
>  	device_remove_file(bci->usb.dev, &dev_attr_max_current);
>  	device_remove_file(bci->ac.dev, &dev_attr_max_current);
>  	device_remove_file(bci->usb.dev, &dev_attr_mode);
> +	device_remove_file(bci->ac.dev, &dev_attr_mode);
>  	/* mask interrupts */
>  	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
>  			 TWL4030_INTERRUPTS_BCIIMR1A);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
