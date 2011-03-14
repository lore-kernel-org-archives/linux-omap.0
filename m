From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] power button repeat input events
Date: Mon, 14 Mar 2011 20:29:45 +0530
Message-ID: <4D7E2D61.1030709@ti.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com> <4D7A53FF.4060004@ti.com> <20110314111327.GA10563@smart.research.nokia.com> <AANLkTinrU2ziCS+xZibz=dSTuFaxypbD7Xh-0yHqty7z@mail.gmail.com> <20110314143533.GA15827@smart.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37187 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391Ab1CNPBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 11:01:40 -0400
Received: by vws2 with SMTP id 2so2871812vws.34
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 08:01:12 -0700 (PDT)
In-Reply-To: <20110314143533.GA15827@smart.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Denis Karpov wrote, on 03/14/2011 08:05 PM:
> On Mon, Mar 14, 2011 at 05:10:22PM +0530, ext Menon, Nishanth wrote:
>> Date: Mon, 14 Mar 2011 17:10:22 +0530
>> From: "ext Menon, Nishanth"<nm@ti.com>
>> To: Denis Karpov<ext-denis.2.karpov@nokia.com>
>> CC: tony@atomide.com, linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 0/2] power button repeat input events
>> In-Reply-To:<20110314111327.GA10563@smart.research.nokia.com>
>>
>> On Mon, Mar 14, 2011 at 16:43, Denis Karpov
>> <ext-denis.2.karpov@nokia.com>  wrote:
>>>
>>> On Fri, Mar 11, 2011 at 10:25:27PM +0530, ext Nishanth Menon wrote:
>>>>
>>>> Denis Karpov wrote, on 03/11/2011 10:07 PM:
>>>>> Hi,
>>>>>
>>>>> this patchset adds optional generation of repeat input events for
>>>>> twl4030 power button. It adds optional platform data for
>>>>> twl4030-pwrbutton and initializes it for RX51/N900 (default
>>>>> behavior kept - repeated input events disabled).
>>>>>
>>>>> We are working on an OMAP3 with TWL5031 MFD. In one of the use
>>>>> scenarios userspace wants to receive repeated input events from
>>>>> long press of power button.
>>>>
>>>> dumb question - is'nt this a userspace responsibility as far as power
>>>> button is concerned? what is the benefit of providing repeat events
>>>> like a generic keypad for the power button?
>>>
>>> In our case userspace needs this to track the continuous button press
>>> of power button.
>> thanks for your explanation, but a follow on dumb question:
>> include/linux/input.h
>> #define KEY_POWER               116     /* SC System Power Down */
>>
>> in twl-powerbutton.c, I see:
>> input_report_key(pwr, KEY_POWER, value&  PWR_PWRON_IRQ);
>> where value is the value from the register status, should'nt we get
>> two events? one on press and one on release after say 10 mins(assuming
>> person keeps it pressed for 10 mins?
>>
>> Is there different behavior we intend to implement in userspace which
>> differentiates 1 KEY_POWER event Vs 10 KEY_POWER event?
>
> No, but due to specifics of userspace sw components involved it seems
> not to be possible to reliably save the state for power button to detect
> long keypresses.
>
> I thought that this change if implemented as optional feature and
> localized to scpecific devices/boards would not hurt.
> twl-keypad.c implements exactly same behavior for keypad keys, why not
> to do this for the power key ?
Are'nt the key events different? KEY_POWER is meant to shutdown the 
system if my reading is right (other keys need repeatability) - I mean 
trying to add a feature because userspace handling is flawed in some 
manner makes me wonder if we are moving the code to kernelspace because 
it is convenient?

I have no debates about just the board in question using this, but just 
worried if we are taking a hack for userspace in kernel given that no 
other board or other userspace variants had a necessity for this change 
previously.

-- 
Regards,
Nishanth Menon
