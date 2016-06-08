From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 8 Jun 2016 13:12:10 +0300
Message-ID: <5757EF7A.20604@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com>
 <20160608095336.GA4444@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608095336.GA4444@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/06/16 12:53, Peter Chen wrote:
> On Wed, Jun 08, 2016 at 12:03:40PM +0300, Roger Quadros wrote:
>> +int usb_otg_unregister(struct device *dev)
>> +{
>> +	struct usb_otg *otg;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(dev);
>> +	if (!otg) {
>> +		dev_err(dev, "otg: %s: device not in otg list\n",
>> +			__func__);
>> +		mutex_unlock(&otg_list_mutex);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* prevent unregister till both host & gadget have unregistered */
>> +	if (otg->host || otg->gadget) {
>> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
>> +			__func__);
> 
> You need to call mutex_unlock here

Indeed. good catch.
> 
>> +
>> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
>> +{
> 
> What this API is for? Why need it in this version?

we moved gadget to otg registration from udc_bind_to_driver() to usb_add_gadget_udc_release().
This means there is a window when gadget function driver (e.g. g_zero) is not loaded.
We don't want to start the gadget controller in that window.

usb_otg_gadget_ready() is used by gadget core to notify the otg core when the function driver
is ready or not-ready.

> 
>> +	struct usb_otg *otg;
>> +	struct device *gadget_dev = &gadget->dev;
>> +	struct device *otg_dev = gadget->otg_dev;
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		dev_err(gadget_dev,
>> +			"otg: gadget %s wasn't registered with otg\n",
>> +			dev_name(&gadget->dev));
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (otg->gadget != gadget) {
>> +		mutex_unlock(&otg->fsm.lock);
>> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
>> +			dev_name(&gadget->dev));
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Start/stop FSM & gadget */
>> +	otg->gadget_ready = ready;
>> +	if (ready)
>> +		usb_otg_start_fsm(otg);
>> +	else
>> +		usb_otg_stop_fsm(otg);
>> +
>> +	dev_dbg(otg_dev, "otg: gadget %s %sready\n", dev_name(&gadget->dev),
>> +		ready ? "" : "not ");
>> +
>> +	mutex_unlock(&otg->fsm.lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_gadget_ready);
>> +
>> --- a/include/linux/usb/otg.h
>> +++ b/include/linux/usb/otg.h
>> @@ -10,10 +10,70 @@
>>  #define __LINUX_USB_OTG_H
>>  
>>  #include <linux/phy/phy.h>
>> -#include <linux/usb/phy.h>
>> -#include <linux/usb/otg-fsm.h>
>> +#include <linux/device.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/ktime.h>
> 
> The above two timer header files are not needed.

You had pointed this out earlier, but I missed it. Sorry.
