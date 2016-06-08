From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 12/14] usb: hcd: Adapt to OTG core
Date: Wed, 8 Jun 2016 15:11:58 +0300
Message-ID: <21edbb67-8219-14ac-5c33-cabfd62d5fa1@cogentembedded.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-13-git-send-email-rogerq@ti.com>
 <22442eeb-e927-d7ac-52c6-3aebd2106837@cogentembedded.com>
 <57580A2D.8060308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57580A2D.8060308@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 6/8/2016 3:06 PM, Roger Quadros wrote:

>>> Introduce usb_otg_add/remove_hcd() for use by host
>>> controllers that are part of OTG/dual-role port.
>>>
>>> Non Device tree platforms can use the otg_dev argument
>>> to specify the OTG controller device. If otg_dev is NULL
>>> then the device tree node's otg-controller property is used to
>>> get the otg_dev device.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>> ---
>>>  drivers/usb/core/hcd.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/usb/hcd.h |  4 ++++
>>>  2 files changed, 59 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index ae6c76d..c6f4155 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>> [...]
>>> @@ -3025,6 +3030,56 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>>>  }
>>>  EXPORT_SYMBOL_GPL(usb_remove_hcd);
>>>
>>> +static struct otg_hcd_ops otg_hcd_intf = {
>>> +    .add = usb_add_hcd,
>>> +    .remove = usb_remove_hcd,
>>> +    .usb_bus_start_enum = usb_bus_start_enum,
>>> +    .usb_control_msg = usb_control_msg,
>>> +    .usb_hub_find_child = usb_hub_find_child,
>>> +};
>>> +
>>> +/**
>>> + * usb_otg_add_hcd - Register the HCD with OTG core.
>>> + * @hcd: the usb_hcd structure to initialize
>>> + * @irqnum: Interrupt line to allocate
>>> + * @irqflags: Interrupt type flags
>>> + * @otg_dev: OTG controller device managing this HCD
>>
>>    Device managing a driver? That's interesting. :-)
>
> Well it is the OTG controller instance really.
> How else do you want me to write it?

   Just HC again? Or maybe HCI (HC interface)?

> cheers,
> -roger

MBR, Sergei
