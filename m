From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH] ARM: DRA: hwmod: RTC: Add reset function for RTC
Date: Fri, 13 Feb 2015 11:07:16 +0530
Message-ID: <54DD8D8C.60203@ti.com>
References: <1416199402-3865-1-git-send-email-lokeshvutla@ti.com> <546DB513.6000104@ti.com> <alpine.DEB.2.02.1411201644470.9204@utopia.booyaka.com> <5473FF68.3070805@ti.com> <alpine.DEB.2.02.1411260649330.16047@utopia.booyaka.com> <alpine.DEB.2.02.1501022252580.27058@utopia.booyaka.com> <alpine.DEB.2.02.1502121641320.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbBMFjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 00:39:43 -0500
In-Reply-To: <alpine.DEB.2.02.1502121641320.3767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, balbi@ti.com, nm@ti.com

Hi Paul,
On Thursday 12 February 2015 10:11 PM, Paul Walmsley wrote:
> + Felipe, Nishanth
> 
> Hi Lokesh,
> 
> what's the status here?
Sorry for the delayed response.
I am currently on a high priority issue. Once I am done with it Ill address your
comments and repost the patch.

Thanks and regards,
Lokesh
> 
> - Paul
> 
> 
> On Fri, 2 Jan 2015, Paul Walmsley wrote:
> 
>> Ping.  Are you going to redo this one?
>>
>> - Paul
>>
>> On Wed, 26 Nov 2014, Paul Walmsley wrote:
>>
>>> Hi Lokesh 
>>>
>>> On Tue, 25 Nov 2014, Lokesh Vutla wrote:
>>>
>>>> Hi Paul,
>>>> On Thursday 20 November 2014 10:26 PM, Paul Walmsley wrote:
>>>>> On Thu, 20 Nov 2014, Lokesh Vutla wrote:
>>>>>
>>>>>> On Monday 17 November 2014 10:13 AM, Lokesh Vutla wrote:
>>>>>>> RTC IP have kicker feature which prevents spurious writes to its registers.
>>>>>>> In order to write into any of the RTC registers, KICK values has te be
>>>>>>> written to KICK registers. Currently hwmod is updating the IDLEMODE in rtc
>>>>>>> sysconfig register without writing into any kick register which is a noop.
>>>>>>> When autoidle is allowed for rtc, interruts are not received until IDLEMODE
>>>>>>> is set to SIDLE_SMART_WKUP.
>>>>>>> Adding a reset function to unlock RTC registers so that IDLEMODE is
>>>>>>> updated.
>>>>>> Ping..!!
>>>>>> Is this patch acceptable?
>>>>>
>>>>> Lokesh
>>>>>
>>>>> 1. This looks like a fix.  Is this intended to go in as a v3.18-rc patch, 
>>>>> or against v3.19?  If so it would be very helpful for the maintainers if 
>>>>> you were to state that somewhere.
>>>> Yes. This is a fix, intended to go in 3.18-rc. Sorry should have
>>>> mentioned it.
>>>
>>> A few questions.  Do you know when this problem started (in terms of 
>>> kernel versions)?
>>>
>>> Also: the patch description states that this is only a problem when 
>>> autoidle is allowed for RTC.  What enables autoidle for RTC - the RTCSS 
>>> driver?  Or does hwmod wind up doing this after the RTCSS driver unlocks 
>>> it?
>>>
>>>>> 2. Your patch unlocks the RTC registers, but never relocks it.  This seems 
>>>>> to defeat the point of the spurious write protection.  Shouldn't your 
>>>>> patch only unlock the RTC immediately before the hwmod code touches the 
>>>>> RTC registers, and then relock it immediately afterwards, per SPRUHZ6 
>>>>> section 23.4.3.3?  If so then the .reset function pointer is the wrong 
>>>>> place for this; I would suggest adding some .lock and .unlock function 
>>>>> pointers that are to be called before and after any register write to the 
>>>>> IP block.
>>>> Yeah I agree with you.
>>>> Currently rtc driver unlocks these kick registers in probe and leaves it unlocks for
>>>> further use.
>>>> But if hwmod does unlock and lock for every sysconfig write driver should also
>>>> implement unlock and lock for every rtc register write, which adds an extra overhead.
>>>> I am not sure if some one writes into rtc registers other than hwmod and driver.
>>>> IMO we can leave it unlocked as the driver does.
>>>
>>> I would think that the best approach would be to set up .lock and .unlock 
>>> function pointers, then add a temporary hwmod flag that, if set, would 
>>> prevent the .lock function from ever being called.  Then once the driver 
>>> is fixed, that flag can be dropped.
>>>
>>>>> 3. Your macros don't mention DRA7xx specifically.  Does this sequence 
>>>>> apply to some other TI chips, or just DRA7xx?  Please document this in a 
>>>>> comment above the macros, and possibly change the name of the macros to 
>>>>> refer to DRA7XX.
>>>> This sequence applies to AM43xx and AM33xx also. So made it generic.
>>>> Ill document it.
>>>
>>> OK but it would need more than just documentation, right?  Wouldn't the 
>>> hwmod data also need to be modified for AM33xx/AM43xx to add the .reset 
>>> function pointer?  Any reason why folks wouldn't have seen this problem on 
>>> AM33xx/AM43xx?
>>>
>>>
>>> - Paul
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> - Paul
>>
> 
> 
> - Paul
> 

