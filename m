From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 16 May 2016 11:26:57 +0300
Message-ID: <57398451.2060103@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160516070249.GB24609@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 16/05/16 10:02, Peter Chen wrote:
> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
>> +
>> +static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
>> +{
>> +	struct usb_udc *udc;
>> +
>> +	mutex_lock(&udc_lock);
>> +	udc = usb_gadget_to_udc(gadget);
>> +	if (!udc) {
>> +		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>> +			__func__);
>> +		mutex_unlock(&udc_lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (connect) {
>> +		if (!gadget->connected)
>> +			usb_gadget_connect(udc->gadget);
>> +	} else {
>> +		if (gadget->connected) {
>> +			usb_gadget_disconnect(udc->gadget);
>> +			udc->driver->disconnect(udc->gadget);
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&udc_lock);
>> +
>> +	return 0;
>> +}
>> +
> 
> Since this is called for vbus interrupt, why not using
> usb_udc_vbus_handler directly, and call udc->driver->disconnect
> at usb_gadget_stop.

We can't assume that this is always called for vbus interrupt so
I decided not to call usb_udc_vbus_handler.

udc->vbus is really pointless for us. We keep vbus states in our
state machine and leave udc->vbus as ture always.

Why do you want to move udc->driver->disconnect() to stop?
If USB controller disconnected from bus then the gadget driver
must be notified about the disconnect immediately. The controller
may or may not be stopped by the core.

> 
>>  	return 0;
>> @@ -660,9 +830,15 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
>>  		return -EOPNOTSUPP;
>>  	}
>>  
>> +	/* In OTG mode we don't support softconnect, but b_bus_req */
>> +	if (udc->gadget->otg_dev) {
>> +		dev_err(dev, "soft-connect not supported in OTG mode\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
> 
> The soft-connect can be supported at dual-role mode currently, we can
> use b_bus_req entry once it is implemented later.

Soft-connect should be done via sysfs handling within the OTG core.
This can be added later. I don't want anything outside the OTG core
to handle soft-connect behaviour as it will be hard to keep things
in sync.

I can update the comment to something like this.

/* In OTG/dual-role mode, soft-connect should be handled by OTG core */

> 
>>  	if (sysfs_streq(buf, "connect")) {
>>  		usb_gadget_udc_start(udc);
>> -		usb_gadget_connect(udc->gadget);
>> +		usb_udc_connect_control(udc);
> 
> This line seems to be not related with this patch.
> 
Right. I'll remove it.

cheers,
-roger
