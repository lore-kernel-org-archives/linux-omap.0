From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH 2/9] usb: gadget: add usb_gadget_start/stop()
Date: Thu, 19 Mar 2015 12:14:39 +0200
Message-ID: <550AA18F.2000106@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com> <1426686963-11613-3-git-send-email-rogerq@ti.com> <20150319032944.GA2476@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150319032944.GA2476@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 19/03/15 05:30, Peter Chen wrote:
> On Wed, Mar 18, 2015 at 03:55:56PM +0200, Roger Quadros wrote:
>> The OTG state machine needs a mechanism to start and
>> stop the gadget controller. Add usb_gadget_start()
>> and usb_gadget_stop().
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/gadget/udc/udc-core.c | 166 +++++++++++++++++++++++++++++++++++---
>>  include/linux/usb/gadget.h        |   3 +
>>  2 files changed, 158 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
>> index 5a81cb0..69b4123 100644
>> --- a/drivers/usb/gadget/udc/udc-core.c
>> +++ b/drivers/usb/gadget/udc/udc-core.c
>> @@ -35,6 +35,8 @@
>>   * @dev - the child device to the actual controller
>>   * @gadget - the gadget. For use by the class code
>>   * @list - for use by the udc class driver
>> + * @running - udc is running
> 
> Doesn't OTG FSM should know it?

Not really, as the gadget driver might not have been loaded yet or userspace might
have disabled softconnect when the OTG FSM wants UDC to start.

So only UDC knows if it has really started or not based on this flag.

cheers,
-roger

> 
> Peter
>> + * @softconnect - sysfs softconnect says OK to connect
>>   *
>>   * This represents the internal data structure which is used by the UDC-class
>>   * to hold information about udc driver and gadget together.
>> @@ -44,6 +46,8 @@ struct usb_udc {
>>  	struct usb_gadget		*gadget;
>>  	struct device			dev;
>>  	struct list_head		list;
>> +	bool				running;
>> +	bool				softconnect;
>>  };
>>  
>>  static struct class *udc_class;
>> @@ -187,7 +191,14 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
>>   */
>>  static inline int usb_gadget_udc_start(struct usb_udc *udc)
>>  {
>> -	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
>> +	int ret;
>> +
>> +	dev_dbg(&udc->dev, "%s\n", __func__);
>> +	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
>> +	if (!ret)
>> +		udc->running = 1;
>> +
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -204,10 +215,140 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
>>   */
>>  static inline void usb_gadget_udc_stop(struct usb_udc *udc)
>>  {
>> +	dev_dbg(&udc->dev, "%s\n", __func__);
>>  	udc->gadget->ops->udc_stop(udc->gadget);
>> +	udc->running = 0;
>>  }
>>  
>>  /**
>> + * usb_udc_start - Start the usb device controller only if conditions met
>> + * @udc: The UDC to be started
>> + *
>> + * Start the UDC and connect to bus (enable pull) only if the
>> + * following conditions are met
>> + * - UDC is not already running
>> + * - gadget function driver is loaded
>> + * - userspace softconnect says OK to connect
>> + *
>> + * NOTE: udc_lock must be held by caller.
>> + *
>> + * Returs 0 on success or not ready to start, else negative errno.
>> + */
>> +static int usb_udc_start(struct usb_udc *udc)
>> +{
>> +	int ret;
>> +
>> +	if (udc->running) {
>> +		dev_err(&udc->dev, "%s: not starting as already running\n",
>> +			__func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (udc->driver && udc->softconnect) {
>> +		ret = usb_gadget_udc_start(udc);
>> +		if (ret)
>> +			return ret;
>> +
>> +		usb_gadget_connect(udc->gadget);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * usb_udc_stop - Stop the usb device controller
>> + * @udc: The UDC to be stopped
>> + *
>> + * Disconnect from bus (disable pull) and stop the UDC.
>> + *
>> + * NOTE: udc_lock must be held by caller.
>> + *
>> + * Returs 0 on success, else negative errno.
>> + */
>> +static int usb_udc_stop(struct usb_udc *udc)
>> +{
>> +	if (!udc->running) {
>> +		dev_err(&udc->dev, "%s: not stopping as already halted\n",
>> +			__func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	usb_gadget_disconnect(udc->gadget);
>> +	udc->driver->disconnect(udc->gadget);
>> +	usb_gadget_udc_stop(udc);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * usb_gadget_start - start the usb gadget controller
>> + * @gadget: the gadget device to start
>> + *
>> + * This is external API for use by OTG core.
>> + *
>> + * Start the usb device controller and connect to bus (enable pull).
>> + * There is no guarantee that the controller is started
>> + * as we might be missing some dependencies
>> + * i.e. gadget function driver not loaded or softconnect disabled.
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
>> +	ret = usb_udc_start(udc);
>> +	mutex_unlock(&udc_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_start);
>> +
>> +/**
>> + * usb_gadget_stop - stop the usb gadget
>> + * @gadget: The gadget device we want to stop
>> + *
>> + * This is external API for use by OTG core.
>> + *
>> + * Disconnect from the bus (disable pull) and stop the
>> + * gadget controller.
>> + */
>> +int usb_gadget_stop(struct usb_gadget *gadget)
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
>> +	ret = usb_udc_stop(udc);
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
>> @@ -278,6 +419,7 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
>>  		goto err3;
>>  
>>  	udc->gadget = gadget;
>> +	udc->softconnect = 1;	/* connect by default */
>>  
>>  	mutex_lock(&udc_lock);
>>  	list_add_tail(&udc->list, &udc_list);
>> @@ -329,10 +471,8 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
>>  
>>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>  
>> -	usb_gadget_disconnect(udc->gadget);
>> -	udc->driver->disconnect(udc->gadget);
>> +	usb_udc_stop(udc);
>>  	udc->driver->unbind(udc->gadget);
>> -	usb_gadget_udc_stop(udc);
>>  
>>  	udc->driver = NULL;
>>  	udc->dev.driver = NULL;
>> @@ -378,6 +518,7 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
>>  
>>  /* ------------------------------------------------------------------------- */
>>  
>> +/* udc_lock must be held */
>>  static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
>>  {
>>  	int ret;
>> @@ -392,12 +533,12 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>>  	ret = driver->bind(udc->gadget, driver);
>>  	if (ret)
>>  		goto err1;
>> -	ret = usb_gadget_udc_start(udc);
>> +
>> +	ret = usb_udc_start(udc);
>>  	if (ret) {
>>  		driver->unbind(udc->gadget);
>>  		goto err1;
>>  	}
>> -	usb_gadget_connect(udc->gadget);
>>  
>>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>  	return 0;
>> @@ -510,12 +651,15 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
>>  	}
>>  
>>  	if (sysfs_streq(buf, "connect")) {
>> -		usb_gadget_udc_start(udc);
>> -		usb_gadget_connect(udc->gadget);
>> +		mutex_lock(&udc_lock);
>> +		udc->softconnect = 1;
>> +		usb_udc_start(udc);
>> +		mutex_unlock(&udc_lock);
>>  	} else if (sysfs_streq(buf, "disconnect")) {
>> -		usb_gadget_disconnect(udc->gadget);
>> -		udc->driver->disconnect(udc->gadget);
>> -		usb_gadget_udc_stop(udc);
>> +		mutex_lock(&udc_lock);
>> +		udc->softconnect = 0;
>> +		usb_udc_stop(udc);
>> +		mutex_unlock(&udc_lock);
>>  	} else {
>>  		dev_err(dev, "unsupported command '%s'\n", buf);
>>  		return -EINVAL;
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
