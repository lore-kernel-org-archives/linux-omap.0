From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 12/14] usb: hcd: Adapt to OTG core
Date: Wed, 8 Jun 2016 15:06:05 +0300
Message-ID: <57580A2D.8060308@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-13-git-send-email-rogerq@ti.com>
 <22442eeb-e927-d7ac-52c6-3aebd2106837@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <22442eeb-e927-d7ac-52c6-3aebd2106837-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/06/16 14:42, Sergei Shtylyov wrote:
> On 6/8/2016 12:03 PM, Roger Quadros wrote:
> 
>> Introduce usb_otg_add/remove_hcd() for use by host
>> controllers that are part of OTG/dual-role port.
>>
>> Non Device tree platforms can use the otg_dev argument
>> to specify the OTG controller device. If otg_dev is NULL
>> then the device tree node's otg-controller property is used to
>> get the otg_dev device.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
>> ---
>>  drivers/usb/core/hcd.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/hcd.h |  4 ++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index ae6c76d..c6f4155 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
> [...]
>> @@ -3025,6 +3030,56 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>>  }
>>  EXPORT_SYMBOL_GPL(usb_remove_hcd);
>>
>> +static struct otg_hcd_ops otg_hcd_intf = {
>> +    .add = usb_add_hcd,
>> +    .remove = usb_remove_hcd,
>> +    .usb_bus_start_enum = usb_bus_start_enum,
>> +    .usb_control_msg = usb_control_msg,
>> +    .usb_hub_find_child = usb_hub_find_child,
>> +};
>> +
>> +/**
>> + * usb_otg_add_hcd - Register the HCD with OTG core.
>> + * @hcd: the usb_hcd structure to initialize
>> + * @irqnum: Interrupt line to allocate
>> + * @irqflags: Interrupt type flags
>> + * @otg_dev: OTG controller device managing this HCD
> 
>    Device managing a driver? That's interesting. :-)

Well it is the OTG controller instance really.
How else do you want me to write it?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
