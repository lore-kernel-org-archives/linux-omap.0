From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH 2/9] usb: gadget: add usb_gadget_start/stop()
Date: Fri, 20 Mar 2015 13:08:25 +0200
Message-ID: <550BFFA9.7050400@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com> <1426686963-11613-3-git-send-email-rogerq@ti.com> <20150319032944.GA2476@shlinux2> <550AA18F.2000106@ti.com> <20150319140859.GA7950@shlinux1.ap.freescale.net> <550AE237.8000404@ti.com> <20150320071818.GF7537@shlinux2> <550BEC7F.8050303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550BEC7F.8050303@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Li Jun <b47624@freescale.com>, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/03/15 11:46, Roger Quadros wrote:
> On 20/03/15 09:18, Peter Chen wrote:
>> On Thu, Mar 19, 2015 at 04:50:31PM +0200, Roger Quadros wrote:
>>> On 19/03/15 16:09, Li Jun wrote:
>>>> On Thu, Mar 19, 2015 at 12:14:39PM +0200, Roger Quadros wrote:
>>>>> On 19/03/15 05:30, Peter Chen wrote:
>>>>>> On Wed, Mar 18, 2015 at 03:55:56PM +0200, Roger Quadros wrote:
>>>>>>> The OTG state machine needs a mechanism to start and
>>>>>>> stop the gadget controller. Add usb_gadget_start()
>>>>>>> and usb_gadget_stop().
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>>> ---
>>>>>>>  drivers/usb/gadget/udc/udc-core.c | 166 +++++++++++++++++++++++++++++++++++---
>>>>>>>  include/linux/usb/gadget.h        |   3 +
>>>>>>>  2 files changed, 158 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
>>>>>>> index 5a81cb0..69b4123 100644
>>>>>>> --- a/drivers/usb/gadget/udc/udc-core.c
>>>>>>> +++ b/drivers/usb/gadget/udc/udc-core.c
>>>>>>> @@ -35,6 +35,8 @@
>>>>>>>   * @dev - the child device to the actual controller
>>>>>>>   * @gadget - the gadget. For use by the class code
>>>>>>>   * @list - for use by the udc class driver
>>>>>>> + * @running - udc is running
>>>>>>
>>>>>> Doesn't OTG FSM should know it?
>>>>>
>>>>> Not really, as the gadget driver might not have been loaded yet or userspace might
>>>>> have disabled softconnect when the OTG FSM wants UDC to start.
>>>>>
>>>>> So only UDC knows if it has really started or not based on this flag.
>>>>>
>>>>
>>>> why this can not be known by check the otg fsm state? i.e. if the device in
>>>> b_peripheral or a_peripheral state, udc should had started, isn't it?
>>>
>>> If gadget function driver (which is different from UDC driver) is not yet loaded
>>> then we can't start UDC even if otg fsm is in b_peripheral.
>>> Also, if userspace has disabled softconnect we can't start UDC.
>>>
>>> So, b_peripheral != UDC_started.
>>>
>>> I've tried to address this issue by adding the checks in usb_gadget_start().
>>>
>>
>> Ok, maybe we have different understanding for 'B-Device' at software,
>> In spec, it says the Micro-AB receptacle with nothing connected can be
>> 'B-Device', but in fact, we may not enable device mode before loading
>> gadget driver, in chipidea fsm design, if the gadget driver is not
>> loaded, the FSM will not start, and it is at OTG_STATE_UNDEFINED.
> 
> Right. I mixed up into thinking that we should respect the softconnect
> while in OTG mode. It seems that we should ignore it.
> 
>>
>> One more thing is we may need to find a place to issue SRP when we
>> load gadget driver, since we may at b_idle  at that time due to host
>> closes the vbus (timeout for a_wait_bcon).
> 
> Issuing SRP should be done by the otg-fsm and not udc-core.
> The udc-core can at the least call usb_otg_kick_fsm() after setting the gadget
> driver so that otg-fsm knows that we now have a valid gadget and can take
> necessary action. i.e. change from b_idle to b_srp_init and then to b_peripheral.

To clarify further. Is it right to assume that OTG FSM will not be started till
both gadget UDC driver _AND_ gadget function driver are loaded?

And it will be stopped when either of them unloads.

This simplifies things a lot.

cheers,
-roger

> 
>>
>> What is the "softconnect" used for? In otg fsm, we use b_bus_req for FSM.
>>
> I understand now that we shouldn't bother with softconnect when we are in OTG fsm mode.
> That solves our problem with the running flags.
> 
> So now, b_peripheral == UDC_started.
> 
> I will address this in v2.
> 
> cheers,
> -roger
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
