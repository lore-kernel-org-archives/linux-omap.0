From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Mon, 15 Apr 2013 11:57:29 -0500
Message-ID: <516C3179.4070501@ti.com>
References: <20130409212318.GR10155@atomide.com> <5165A1DB.3020404@ti.com> <20130410182034.GH10155@atomide.com> <5165CED4.1040800@ti.com> <20130410205407.GQ10155@atomide.com> <5165E6F1.8040102@ti.com> <20130410222749.GR10155@atomide.com> <20130413000615.GF10155@atomide.com> <5168C050.7030006@ti.com> <20130413165014.GL10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51245 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3DOQ5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 12:57:31 -0400
In-Reply-To: <20130413165014.GL10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>


On 04/13/2013 11:50 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130412 19:22]:
>>
>> On 04/12/2013 07:06 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [130410 15:32]:
>>>> * Jon Hunter <jon-hunter@ti.com> [130410 15:30]:
>>>>>
>>>>> Are you saying that you want to use the version with that is using the
>>>>> pre-processor definitions? I was thinking that may be we could do that
>>>>> as a clean-up for v3.11 and just use the original version I posted
>>>>> earlier. Seems cleaner to me.
>>>>
>>>> No let's do that the preprocessor conversion for v3.11.
>>>
>>> Hmm looks like there are few more 3430sdp dt nfsroot exposed
>>> issues in today's linux next.
>>
>> I don't even see any ethernet devices defined in the omap3430-sdp.dts
>> file. Is this something that you have added on top?
> 
> Oops sorry I meant the ks8851 on SPI on 4430sdp, not 3430.

Ok makes sense.

>>> To get nfsroot to behave, I had to have your earlier fix
>>> from this thread and also revert a2797bea (gpio/omap: force
>>> restore if context loss is not detectable).
>>>
>>> Otherwise nfsroot fails, but not necessarily every time?
>>
>> Well this patch is going to force a gpio restore everytime we call
>> pm_runtime_get() when the use-count is 0. Yes this is not efficient,
>> however, without this patch you run the risk of context being lost and
>> you would never know. Per the changelog, long term a better solution is
>> needed.
> 
> It seems that this patch kills the ks8851 GPIO interrupt somehow,
> at least most of the time.

Hmmm, let me go back and re-test this.

>>> I could not git bisect it down to the commit above, had to
>>> manually figure it out.. There may also be DMA related
>>> issues, but I don't know for sure any longer. I made a
>>> patch to fix SPI PIO mode and then hacked SPI to always use
>>> PIO to leave out the DMA related parts. Anyways, will post
>>> that separately, let's hope the DMA related issues I saw
>>> earlier are also related to dt + a2797bea.
>>
>> Ok, I don't follow that. I am not sure how gpio is related to DMA in
>> this case.
> 
> I think the DMA issues might be related to the GPIO interrupt
> not working properly.

What is the use-case? DMA + SPI? Talking to what on what board?

Cheers
Jon
