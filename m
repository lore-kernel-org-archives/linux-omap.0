From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Tue, 31 Jan 2017 15:25:07 +0200
Message-ID: <6634e129-fe4f-04d6-abcc-ef7583ecb013@ti.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
 <87a8anjm5z.fsf@linux.intel.com>
 <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com>
 <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com>
 <87inp07fkx.fsf@linux.intel.com>
 <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com>
 <8760l07dfh.fsf@linux.intel.com> <87wpdg5wtx.fsf@linux.intel.com>
 <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815@ti.com>
 <87o9yo66w7.fsf@linux.intel.com>
 <19de4c77-0e95-f7b5-0f56-a705134fd4cc@ti.com>
 <87inow662n.fsf@linux.intel.com> <87d1f464mp.fsf@linux.intel.com>
 <90f70eb2-8b87-d33e-71cd-335c05c6f65a@ti.com>
 <87mve74esx.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87mve74esx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 31/01/17 14:03, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>>>>> -DALEPENA = 0x0000000f
>>>>>>>> +DALEPENA = 0x00000000
>>>>>>>
>>>>>>> Thanks for the hints.
>>>>>>>
>>>>>>> This problem is because reason dwc3_gadget_run_stop() is timing out
>>>>>>> during the suspend sequence and so dwc3_disconnect_gadget() and
>>>>>>> __dwc3_gadget_stop() are not being called.
>>>>>>
>>>>>> I see
>>>>>>
>>>>>>> dwc3_suspend() does not consider dwc3_gadget_suspend()'s return value
>>>>>>> and happily continues suspending the machine.
>>>>>>>
>>>>>>> If I force dwc3_gadget_run_stop() to return 0 then everything works fine.
>>>>>>>
>>>>>>> Any ideas why DWC3_DSTS_DEVCTRLHLT is not getting set?
>>>>>>
>>>>>> no idea. It should always get set when run_stop is cleared. Can you
>>>>>> check if suspending with cable detached has any difference?
>>>>>
>>>>> After cable detach, it still timed out the next suspend. But on
>>>>> subsequent suspends there were no timeouts. (I didn't plug the cable
>>>>> back at all)
>>>>>
>>>>> This behaviour is on dra7. I will test the behaviour on am43x as well.
>>>>
>>>> wonder if there's something odd with 2.02a. AM437x is 2.40a IIRC,
>>>> testing that is, indeed, a good idea.
>>
>> Tried on am437x which is 2.40a but same timeout problem there as well.
>>
>>>
>>> What if your platform just takes longer to halt?
>>>
>>> Can you try below?
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 4db97ecae885..d2e405793b1f 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -1586,7 +1586,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>>  {
>>>         u32                     reg;
>>> -       u32                     timeout = 500;
>>> +       u32                     timeout = 500000;
>>>  
>>>         if (pm_runtime_suspended(dwc->dev))
>>>                 return 0;
>>>
>>>
>>
>> Tried this but it doesn't resolve the issue.
> 
> Interesting. I have no idea what to try now. How about checking if that
> susphy quirk flags help? Maybe your platform can't accept PHY being
> suspended, or something.
> 

The susphy quirks are already enabled for both dra7 and am43 platforms.
I too don't have any clues as to what's going on. :(

-- 
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
