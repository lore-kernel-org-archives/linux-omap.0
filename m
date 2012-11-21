From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 04/16] mfd: omap-usb-tll: Move port clock handling out
 of runtime ops
Date: Wed, 21 Nov 2012 14:45:46 +0200
Message-ID: <50ACCCFA.6060605@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-5-git-send-email-rogerq@ti.com> <20121121120408.GF10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57296 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab2KUMpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 07:45:49 -0500
In-Reply-To: <20121121120408.GF10216@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/21/2012 02:06 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:02PM +0200, Roger Quadros wrote:
>> The port clocks are not required to access the port registers,
>> they are only needed when the PORT is used. So we move the port clock
>> handling code to omap_tll_enable/disable().
>>
>> Also get of unnecessary spinlock code in probe function and check for
>> missing platform data.
> 
> this second sentence needs some rephrasing, I don't fully understand
> what you mean.

Oops. should have been "get _rid_ of".
> 
> This patch also does more than what $SUBJECT says, should be splitted
> up.

OK.

> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-tll.c |  102 +++++++++++++++++---------------------------
>>  1 files changed, 39 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index 7054395e..31ac7db 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
>> @@ -114,8 +114,8 @@ struct usbtll_omap {
>>  
>>  /*-------------------------------------------------------------------------*/
>>  
>> -const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
>> -struct platform_device	*tll_pdev;
>> +static const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
>> +static struct device *tll_dev;
>>  
>>  /*-------------------------------------------------------------------------*/
>>  
>> @@ -217,7 +217,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
>>  	struct resource				*res;
>>  	struct usbtll_omap			*tll;
>>  	unsigned				reg;
>> -	unsigned long				flags;
>>  	int					ret = 0;
>>  	int					i, ver;
>>  	bool needs_tll;
>> @@ -230,6 +229,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	if (!pdata) {
>> +		dev_err(dev, "%s : Platform data mising\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>>  	spin_lock_init(&tll->lock);
>>  
>>  	tll->pdata = pdata;
>> @@ -253,8 +257,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
>>  	pm_runtime_enable(dev);
>>  	pm_runtime_get_sync(dev);
>>  
>> -	spin_lock_irqsave(&tll->lock, flags);
>> -
>>  	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
>>  	switch (ver) {
>>  	case OMAP_USBTLL_REV1:
>> @@ -331,13 +333,13 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	tll_pdev = pdev;
>> +	/* only after this can omap_tll_enable/disable work */
>> +	tll_dev = dev;
> 
> I'd like to get rid of that, actually. But for now we can keep it...
> 
>>  err_clk:
>>  	for (--i; i >= 0 ; i--)
>>  		clk_put(tll->ch_clk[i]);
>>  
>> -	spin_unlock_irqrestore(&tll->lock, flags);
>>  	pm_runtime_put_sync(dev);
>>  	if (ret == 0) {
>>  		pr_info("OMAP USB TLL : revision 0x%x, channels %d\n",
>> @@ -364,6 +366,7 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
>>  	struct usbtll_omap *tll = platform_get_drvdata(pdev);
>>  	int i;
>>  
>> +	tll_dev = NULL;
>>  	iounmap(tll->base);
>>  	for (i = 0; i < tll->nch; i++)
>>  		clk_put(tll->ch_clk[i]);
>> @@ -373,98 +376,71 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> -static int usbtll_runtime_resume(struct device *dev)
>> +static struct platform_driver usbtll_omap_driver = {
>> +	.driver = {
>> +		.name		= (char *)usbtll_driver_name,
>> +		.owner		= THIS_MODULE,
>> +	},
>> +	.probe		= usbtll_omap_probe,
>> +	.remove		= __devexit_p(usbtll_omap_remove),
> 
> there is a big patchset floating around dropping CONFIG_HOTPLUG, that
> means that __devinit, __devexit, __devexit_p(), __devinitdata,
> __devinitconst will all vanish. Please don't re-add them ;-)
> 

OK. good to know.

>> +};
>> +
>> +int omap_tll_enable(void)
>>  {
>> -	struct usbtll_omap			*tll = dev_get_drvdata(dev);
>> -	struct usbtll_omap_platform_data	*pdata = tll->pdata;
>> +	struct usbtll_omap			*tll;
>>  	unsigned long				flags;
>>  	int i;
>>  
>> -	dev_dbg(dev, "usbtll_runtime_resume\n");
>> -
>> -	if (!pdata) {
>> -		dev_dbg(dev, "missing platform_data\n");
>> +	if (!tll_dev) {
>> +		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
>>  		return  -ENODEV;
>>  	}
>>  
>> +	tll = dev_get_drvdata(tll_dev);
>>  	spin_lock_irqsave(&tll->lock, flags);
>>  
>>  	for (i = 0; i < tll->nch; i++) {
>> -		if (mode_needs_tll(pdata->port_mode[i])) {
>> +		if (mode_needs_tll(tll->pdata->port_mode[i])) {
>>  			int r;
>>  			r = clk_enable(tll->ch_clk[i]);
>>  			if (r) {
>> -				dev_err(dev,
>> -				 "%s : Error enabling ch %d clock: %d\n",
>> -				 __func__, i, r);
>> +				dev_err(tll_dev,
>> +				  "%s : Error enabling ch %d clock: %d\n",
>> +				  __func__, i, r);
> 
> no need for __func__
> 
>>  			}
>>  		}
>>  	}
>>  
>> +	i = pm_runtime_get_sync(tll_dev);
> 
> fair enough, you're trying to re-use the variable. But I would be more
> explicit and create another ret variable. I'm sure GCC will optimize
> variable usage here anyway.
> 

fine.

>>  	spin_unlock_irqrestore(&tll->lock, flags);
>>  
>> -	return 0;
>> +	return i;
>>  }
>> +EXPORT_SYMBOL_GPL(omap_tll_enable);
>>  
>> -static int usbtll_runtime_suspend(struct device *dev)
>> +int omap_tll_disable(void)
> 
> why ?? Why are you actually dropping runtime PM from this driver ? have
> you tested PM transitions after applying this patch ?
> 

I'm not dropping runtime PM as such. Just separating enabling of channel
clocks from runtime PM (read enabling hwmod). The only user for this
driver is omap-usb-host.c via the omap_tll_enable/disable() calls.

These calls still call pm_runtime_get/put() to enable the TLL hwmod.

I have tested PM transitions on bus suspend/resume and modprobe/rmmod.
They still work fine.

cheers,
-roger
