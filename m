From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Fri, 23 Oct 2015 20:58:33 +0300
Message-ID: <562A7549.3070400@ti.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com>
 <562A2D0D.3060104@ti.com> <20151023163957.GW3078@atomide.com>
 <877fmdcyzi.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877fmdcyzi.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/23/2015 07:48 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Date: Fri, 23 Oct 2015 09:03:22 -0700
>> Subject: [PATCH] usb: musb: omap2430: Fix regression caused by driver core
>>   change
>>
>> Commit ddef08dd00f5 ("Driver core: wakeup the parent device before trying
>> probe") started automatically ensuring the parent device is enabled when
>> the child gets probed.
>>
>> This however caused a regression for MUSB omap2430 interface as the
>> runtime PM for the parent device needs the child initialized to access
>> the MUSB hardware registers.
>>
>> Let's delay the enabling of PM runtime for the parent until the child
>> has been properly initialized as suggested in an earlier patch by
>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
>>
>> In addition to delaying pm_runtime_enable, we now also need to make sure
>> the parent is enabled during omap2430_musb_init. We also want to propagate
>> an error from omap2430_runtime_resume if struct musb is not initialized.
>>
>> Note that we use pm_runtime_put_noidle here for both the child and parent
>> to prevent an extra runtime_suspend/resume cycle.
>>
>> Let's also add some comments to avoid confusion between the
>> two different devices.
>>
>> Fixes: ddef08dd00f5 ("Driver core: wakeup the parent device before
>> trying probe")
>> Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> I'm fine with this patch to fix this v4.3 regression. Greg, do you want
> a pull request or can you take this in as a patch ? In any case:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

It always fun when DD/PM core is updated to fix some driver/subsystem's
specific PM issue :(

> 
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -391,9 +391,20 @@ static int omap2430_musb_init(struct musb *musb)
>>   	}
>>   	musb->isr = omap2430_musb_interrupt;
>>   
>> +	/*
>> +	 * Enable runtime PM for musb parent (this driver). We can't
>> +	 * do it earlier as struct musb is not yet allocated and we
>> +	 * need to touch the musb registers for runtime PM.
>> +	 */
>> +	pm_runtime_enable(glue->dev);
>> +	status = pm_runtime_get_sync(glue->dev);
>> +	if (status < 0)
>> +		goto err1;
>> +
>>   	status = pm_runtime_get_sync(dev);

Hm. My assumption was that *Parent* device (omap2430) will be enabled
here :( But as I can see this will not happen:

static int rpm_resume(struct device *dev, int rpmflags)
{...
	if (!parent && dev->parent) {
		/*
		 * Increment the parent's usage counter and resume it if
		 * necessary.  Not needed if dev is irq-safe; then the
		 * parent is permanently resumed.
		 */
		parent = dev->parent;
		if (dev->power.irq_safe)
			goto skip_parent;

^^^ and musb device is irq_safe :( 



>>   	if (status < 0) {
>>   		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
>> +		pm_runtime_put_sync(glue->dev);
>>   		goto err1;
>>   	}
>>   
>> @@ -426,6 +437,7 @@ static int omap2430_musb_init(struct musb *musb)
>>   	phy_power_on(musb->phy);
>>   
>>   	pm_runtime_put_noidle(musb->controller);
>> +	pm_runtime_put_noidle(glue->dev);
>>   	return 0;
>>   
>>   err1:
>> @@ -626,7 +638,11 @@ static int omap2430_probe(struct platform_device *pdev)
>>   		goto err2;
>>   	}
>>   
>> -	pm_runtime_enable(&pdev->dev);
>> +	/*
>> +	 * Note that we cannot enable PM runtime yet for this
>> +	 * driver as we need struct musb initialized first.
>> +	 * See omap2430_musb_init above.
>> +	 */
>>   
>>   	ret = platform_device_add(musb);
>>   	if (ret) {
>> @@ -675,11 +691,12 @@ static int omap2430_runtime_resume(struct device *dev)
>>   	struct omap2430_glue		*glue = dev_get_drvdata(dev);
>>   	struct musb			*musb = glue_to_musb(glue);
>>   
>> -	if (musb) {
>> -		omap2430_low_level_init(musb);
>> -		musb_writel(musb->mregs, OTG_INTERFSEL,
>> -				musb->context.otg_interfsel);
>> -	}
>> +	if (!musb)
>> +		return -EPROBE_DEFER;
>> +
>> +	omap2430_low_level_init(musb);
>> +	musb_writel(musb->mregs, OTG_INTERFSEL,
>> +		    musb->context.otg_interfsel);
>>   
>>   	return 0;
>>   }
> 


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
