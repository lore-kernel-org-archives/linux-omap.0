From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 04/13] usb: gadget: add usb_gadget_start/stop()
Date: Thu, 16 Apr 2015 15:07:41 +0300
Message-ID: <552FA60D.5030707@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <1429008120-5395-5-git-send-email-rogerq@ti.com> <20150416114839.GD3181@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbbDPMHu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 08:07:50 -0400
In-Reply-To: <20150416114839.GD3181@shlinux2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 16/04/15 14:48, Peter Chen wrote:
> On Tue, Apr 14, 2015 at 01:41:51PM +0300, Roger Quadros wrote:
>> The OTG state machine needs a mechanism to start and
>> stop the gadget controller. Add usb_gadget_start()
>> and usb_gadget_stop().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/gadget/udc/udc-core.c | 74 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/gadget.h        |  3 ++
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
>> index 5a81cb0..3aa5dd5 100644
>> --- a/drivers/usb/gadget/udc/udc-core.c
>> +++ b/drivers/usb/gadget/udc/udc-core.c
>> @@ -187,6 +187,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
>>   */
>>  static inline int usb_gadget_udc_start(struct usb_udc *udc)
>>  {
>> +	dev_dbg(&udc->dev, "%s\n", __func__);
>>  	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
>>  }
>>  
>> @@ -204,10 +205,83 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
>>   */
>>  static inline void usb_gadget_udc_stop(struct usb_udc *udc)
>>  {
>> +	dev_dbg(&udc->dev, "%s\n", __func__);
>>  	udc->gadget->ops->udc_stop(udc->gadget);
>>  }
>>  
>>  /**
>> + * usb_gadget_start - start the usb gadget controller and connect to bus
>> + * @gadget: the gadget device to start
>> + *
>> + * This is external API for use by OTG core.
>> + *
>> + * Start the usb device controller and connect to bus (enable pull).
>> + */
>> +int usb_gadget_start(struct usb_gadget *gadget)
>> +{
>> +	int ret;
>> +	struct usb_udc *udc = NULL;
>> +
>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
>> +	mutex_lock(&udc_lock);
>> +	list_for_each_entry(udc, &udc_list, list)
>> +		if (udc->gadget == gadget)
>> +			goto found;
>> +
>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>> +		__func__);
>> +	mutex_unlock(&udc_lock);
>> +	return -EINVAL;
>> +
>> +found:
>> +	ret = usb_gadget_udc_start(udc);
>> +	if (ret)
>> +		dev_err(&udc->dev, "USB Device Controller didn't start: %d\n",
>> +			ret);
>> +	else
>> +		usb_gadget_connect(udc->gadget);
> 
> OTG FSM manages its pullup/pulldown itself through its fsm->ops->loc_conn

That API usb_gadget_udc_start() is used by DRD (dual-role) FSM as well
and it doesn't use ops->loc_conn. So i'm wondering how to make this work for
both.

I could probably remove the pull up control from usb_gadget_start/stop()
and move it into the DRD FSM.

cheers,
-roger

> 
>> +
>> +	mutex_unlock(&udc_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_start);
>> +
>> +/**
>> + * usb_gadget_stop - disconnect from bus and stop the usb gadget
>> + * @gadget: The gadget device we want to stop
>> + *
>> + * This is external API for use by OTG core.
>> + *
>> + * Disconnect from the bus (disable pull) and stop the
>> + * gadget controller.
>> + */
>> +int usb_gadget_stop(struct usb_gadget *gadget)
>> +{
>> +	struct usb_udc *udc = NULL;
>> +
>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
>> +	mutex_lock(&udc_lock);
>> +	list_for_each_entry(udc, &udc_list, list)
>> +		if (udc->gadget == gadget)
>> +			goto found;
>> +
>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>> +		__func__);
>> +	mutex_unlock(&udc_lock);
>> +	return -EINVAL;
>> +
>> +found:
>> +	usb_gadget_disconnect(udc->gadget);
>> +	udc->driver->disconnect(udc->gadget);
>> +	usb_gadget_udc_stop(udc);
>> +	mutex_unlock(&udc_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_stop);
>> +
>> +/**
>>   * usb_udc_release - release the usb_udc struct
>>   * @dev: the dev member within usb_udc
>>   *
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index e2f00fd..7ada7e6 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -922,6 +922,9 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver);
>>   */
>>  int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
>>  
>> +int usb_gadget_start(struct usb_gadget *gadget);
>> +int usb_gadget_stop(struct usb_gadget *gadget);
>> +
>>  extern int usb_add_gadget_udc_release(struct device *parent,
>>  		struct usb_gadget *gadget, void (*release)(struct device *dev));
>>  extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
>> -- 
>> 2.1.0
>>
> 

