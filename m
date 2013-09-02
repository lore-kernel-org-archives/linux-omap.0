From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: omap4 ehci sporadic resume issue
Date: Mon, 2 Sep 2013 10:04:04 +0300
Message-ID: <52243864.30504@ti.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking> <51CC5105.4070301@ti.com> <20130627175623.GB21364@panicking> <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com> <20130627192413.GA14115@panicking> <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com> <20130628113314.GA25536@panicking> <51CD7783.8030907@ti.com> <20130628164751.GA1281@panicking> <51D2E6DA.6030000@ti.com> <51D2E88A.7050202@amarulasolutions.com> <51D2EBBB.8000504@ti.com> <51D5380B.3060401@amarulasolutions.com> <CAOf5uwk9U8CHWywfopCt-H5BJmYyuXrwPvpwaqqP+5-3g_qYhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwk9U8CHWywfopCt-H5BJmYyuXrwPvpwaqqP+5-3g_qYhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Michael,

On 08/30/2013 08:59 PM, Michael Trimarchi wrote:
> Hi Roger
> 
> On Thu, Jul 4, 2013 at 10:53 AM, Michael Trimarchi
> <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>> Hi
>>
>> On 07/02/2013 05:03 PM, Roger Quadros wrote:
>>>
>>> On 07/02/2013 05:49 PM, Michael Trimarchi wrote:
>>>> Hi Roger
>>>>
>>>> On 07/02/2013 04:42 PM, Roger Quadros wrote:
>>>>> On 06/28/2013 07:47 PM, Michael Trimarchi wrote:
>>>>>> Hi
>>>>>>
>>>
> 
> I'm working on PM consumption of other subsystem because it's a very
> complex device.
> Right now the pm consumption is sleep mode is 6mA just for (off mode disabled)
> 
> omap4 + LPDDR2 and TWL6032
> 
> I don't exactly know if they have updated the last bootloader but I think so.
> 
> I have tried to work on STP signal and re-enable it just before resume
> but nothing change
> 
> Anyway my idea is the problem is releated on 18clk counter and an
> invalid state of the
> hw. I will try to implement save & restore register by hand instead
> using the sar.

There are 2 erratas related to the issues you mentioned.

i693 - USB HOST EHCI - Port Resume Fails On Second Resume Iteration
i719 - HS USB: Multiple OFF Mode Transitions Introduce Corruption

cheers,
-roger

> 
> Michael
> 
> 
>>>>>>>
>>>>>>> When you said earlier that the problem doesn't happen when one of the ULPIs is used
>>>>>>> did you try both of them individually. e.g. case 1: port 1 only enabled,
>>>>>>> case 2: port 2 only enabled.
>>>>>>>
>>>>>>> Did it work in both the cases?
>>>>>>
>>>>>> Yes, so I don't think could be a problem of ulpi pins and why this happen
>>>>>> on both at the same time? Seems more connected to somenthing else.
>>>>>>
>>>>>
>>>>> Right. Seems to be related to two things. OFF Mode and 2 ports being used simultaneously.
>>>>>
>>>>> I'm not sure how to go about fixing this. How important is OFF Mode for your application.
>>>>> Can you keep it always disabled?
>>>>>
>>>
>>>
>>>>
>>>> Right now I delivery without off mode. I will try to fix in long run the usb and I think that it could be a good platform to test omap4 mainline.
>>>>
>>>
>>> Yes, our aim is to get it working with mainline as well.
>>>
>>>> Last question:
>>>> If one domain is in RET mode and not OFF mode what happen during SAR restore in OFF mode?
>>>>
>>>
>>> SAR restore will only happen when the Device enters OFF mode.
>>>
>>> Device OFF mode can only be reached when all voltage domains are switched OFF and that would depend
>>> if all power domains entered OFF or not. Just a simplistic explanation. You can refer to chapter
>>> "3.9.3 Device OFF State Management" in the TRM.
>>
>> What happen if we ask to go in off mode for all domains but one doesn't go in off mode so the device
>> will not go in off mode and the sar will not be used? How can work the restore?
>>
>>>
>>
>> I have added a check of CM_RESTORE_ST. This register need to be clear before
>> going in OFF mode and then show if the status of phase1 2a and 2b is completed.
>> So before proceed with system resume and after resetting OFF_MODE bit I have tried to wait on this register,
>> but without success.
>>
>> Michael
>>
>>> cheers,
>>> -roger
>>>
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
