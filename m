From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Fri, 8 Apr 2016 10:16:30 +0300
Message-ID: <57075ACE.1010702@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-2-git-send-email-rogerq@ti.com> <87zit72rqz.fsf@intel.com>
 <5704AD76.9080806@ti.com> <20160407094246.GA9963@shlinux2.ap.freescale.net>
 <57063915.7000700@ti.com> <20160408010130.GA9070@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160408010130.GA9070@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/04/16 04:01, Peter Chen wrote:
> On Thu, Apr 07, 2016 at 01:40:21PM +0300, Roger Quadros wrote:
>> On 07/04/16 12:42, Peter Chen wrote:
>>> On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
>>>> On 06/04/16 09:09, Felipe Balbi wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>>>>> index 2ca2cef..6b1930d 100644
>>>>>> --- a/drivers/usb/core/hcd.c
>>>>>> +++ b/drivers/usb/core/hcd.c
>>>>>> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>>>>>  	int retval;
>>>>>>  	struct usb_device *rhdev;
>>>>>>  
>>>>>> +	hcd->flags = 0;
>>>>>
>>>
>>> I am not sure if this usb_add(remove)_hcd pair is safe and clean enough
>>> for start/stop host role. From my point, we may need to do like
>>> .probe/.remove host platform driver interface. In that case, we can make
>>
>> probe and remove are meant to be called from bus layer.
>> I do not see a way how OTG framework can call probe/remove of HCD driver.
>> Some HCDs may be platform devices, some PCI, so different entities are calling
>> the HCD .probe hook.
>>
>>> sure the clocks and regulators are off, and hcd will be zero-initialized
>>
>> why can't we make that sure that is taken care of within the hcd_ops?
>> Why should some driver keep its regulators and clocks enabled when hcd is stopped?
>> It doesn't need to. If it is doing so now, it needs to be fixed.
>>
> 
> Well, you may misunderstand me. I mean your hcd_ops->start or ->stop
> is hard to be a general one which only calls usb_hcd_add or
> usb_hcd_remove. It needs to implement like .probe or .remove at platform
> driver, some example code like host_start and host_stop at
> drivers/usb/chipidea/host.c.
> 
The only extra thing the host_start/stop() of that driver is doing is
enabling/disabling the VBUS regulator.
In the OTG/dual role scope VBUS regulator handling has to be done via the
OTG driver using the otg ops otg_drv_vbus() and not at HCD level. Do you agree?

I don't want to complicate the OTG to HCD interface by adding new hooks there.
If HCD driver wants to do something special for OTG case it can always do that
within the struct hc_driver interface. But ideally OTG specific handling must
be done in the OTG driver. All that the HCD driver should care about is making sure
all used resources are disabled once usb_remove_hcd() is called.

cheers,
-roger
