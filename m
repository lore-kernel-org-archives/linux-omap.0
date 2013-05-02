From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Fri, 3 May 2013 00:13:53 +0100
Message-ID: <20130502231353.GF21614@n2100.arm.linux.org.uk>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru> <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru> <20130502164058.GC8577@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130502164058.GC8577-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 02, 2013 at 07:40:58PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, May 02, 2013 at 08:28:44PM +0400, Alexander Shiyan wrote:
> > > On 20:03-20130502, Alexander Shiyan wrote:
> > > > 
> > > > Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> > > > ---
> > > >  arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
> > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> > > > index aa27d7f..8d17a0d 100644
> > > > --- a/arch/arm/mach-omap2/usb-host.c
> > > > +++ b/arch/arm/mach-omap2/usb-host.c
> > > > @@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > > >  	supplies->dev_name = dev_id;
> > > >  
> > > >  	reg_data = kzalloc(sizeof(*reg_data), GFP_KERNEL);
> > > > -	if (!reg_data)
> > > > +	if (!reg_data) {
> > > > +		kfree(supplies);
> > > >  		return -ENOMEM;
> > > > +	}
> > > >  
> > > >  	reg_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
> > > >  	reg_data->consumer_supplies = supplies;
> > > > @@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > > >  
> > > >  	config = kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
> > > >  			GFP_KERNEL);
> > > > -	if (!config)
> > > > +	if (!config) {
> > > > +		kfree(supplies);
> > > > +		kfree(reg_data);
> > > >  		return -ENOMEM;
> > > > +	}
> > > >  
> > > >  	config->supply_name = name;
> > > >  	config->gpio = gpio;
> > > > @@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > > >  
> > > >  	/* create a regulator device */
> > > >  	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> > > > -	if (!pdev)
> > > > +	if (!pdev) {
> > > > +		kfree(supplies);
> > > > +		kfree(reg_data);
> > > > +		kfree(config);
> > > >  		return -ENOMEM;
> > > > +	}
> > > >  
> > > >  	pdev->id = PLATFORM_DEVID_AUTO;
> > > >  	pdev->name = reg_name;
> > > >  	pdev->dev.platform_data = config;
> > > >  
> > > >  	ret = platform_device_register(pdev);
> > > > -	if (ret)
> > > > +	if (ret) {
> > > >  		pr_err("%s: Failed registering regulator %s for %s\n",
> > > >  				__func__, name, dev_id);
> > > > +		kfree(supplies);
> > > > +		kfree(reg_data);
> > > > +		kfree(config);
> > > > +	}
> > > 
> > > Might be better to switch to devm_XXX managed functions?
> 
> I don't think it makes sense since the platform_device hasn't been
> registered yet.
> 
> Still, patch can be improved with proper goto labels instead of
> sprinkling different kfree() calls in every single error branch.
> 
> > If anyone can rewrite driver to use devm_xx, it would have been better.
> > I'm not going to redo the patch yet, let it be so, I just showed a point
> > for OMAP-developers.
> 
> fair enough.

Well, as long as this crap violates the driver model by using kfree() on
a device...  Devices are refcounted and must only be freed when the
refcount drops to zero.

This is exactly why we have platform_device_alloc(),
platform_device_register_full() and friends - so that people don't have to
fsck around with kzalloc themselves and get it wrong like the above does.

Would you like me to pass your details to gregkh for another one of his
public humilation exercises over basic kernel programming stuff? :)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
