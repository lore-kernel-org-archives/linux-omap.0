From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 18 May 2016 15:45:11 +0300
Message-ID: <573C63D7.9050200@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net> <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net> <57399839.90706@ti.com>
 <20160518031829.GA4244@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160518031829.GA4244-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 18/05/16 06:18, Peter Chen wrote:
> On Mon, May 16, 2016 at 12:51:53PM +0300, Roger Quadros wrote:
>> On 16/05/16 12:23, Peter Chen wrote:
>>> On Mon, May 16, 2016 at 11:26:57AM +0300, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 16/05/16 10:02, Peter Chen wrote:
>>>>> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
>>>>>> +
>>>>>> +static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
>>>>>> +{
>>>>>> +	struct usb_udc *udc;
>>>>>> +
>>>>>> +	mutex_lock(&udc_lock);
>>>>>> +	udc = usb_gadget_to_udc(gadget);
>>>>>> +	if (!udc) {
>>>>>> +		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>>>>>> +			__func__);
>>>>>> +		mutex_unlock(&udc_lock);
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (connect) {
>>>>>> +		if (!gadget->connected)
>>>>>> +			usb_gadget_connect(udc->gadget);
>>>>>> +	} else {
>>>>>> +		if (gadget->connected) {
>>>>>> +			usb_gadget_disconnect(udc->gadget);
>>>>>> +			udc->driver->disconnect(udc->gadget);
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	mutex_unlock(&udc_lock);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Since this is called for vbus interrupt, why not using
>>>>> usb_udc_vbus_handler directly, and call udc->driver->disconnect
>>>>> at usb_gadget_stop.
>>>>
>>>> We can't assume that this is always called for vbus interrupt so
>>>> I decided not to call usb_udc_vbus_handler.
>>>>
>>>> udc->vbus is really pointless for us. We keep vbus states in our
>>>> state machine and leave udc->vbus as ture always.
>>>>
>>>> Why do you want to move udc->driver->disconnect() to stop?
>>>> If USB controller disconnected from bus then the gadget driver
>>>> must be notified about the disconnect immediately. The controller
>>>> may or may not be stopped by the core.
>>>>
>>>
>>> Then, would you give some comments when this API will be used?
>>> I was assumed it is only used for drd state machine.
>>
>> drd_state machine didn't even need this API in the first place :).
>> You guys wanted me to separate out start/stop and connect/disconnect for full OTG case.
>> Won't full OTG state machine want to use this API? If not what would it use?
>>
> 
> Oh, I meant only drd and fully otg state machine needs it. I am
> wondering if we need have a new API to do it. Two questions:

OK.
> 
> - Except for vbus interrupt, any chances this API will be used at
> current logic?

I don't think so. But we can't assume caller behaviour for any API.

> - When this API is called but without a coming gadget->stop?
> 
Never for DRD case. But we want to catch wrong users.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
