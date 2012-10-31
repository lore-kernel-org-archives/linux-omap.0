From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Wed, 31 Oct 2012 05:15:02 -0500
Message-ID: <5090FA26.5090808@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <508E266C.6090901@ti.com> <20121029080523.GC13657@arwen.pp.htv.fi> <508E3D09.9090802@ti.com> <20121029200328.GE30152@arwen.pp.htv.fi> <508F7471.8060402@ti.com> <20121030070904.GB1978@arwen.pp.htv.fi> <508FE142.2020408@ti.com> <20121030151029.GD29159@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab2JaKPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:15:10 -0400
In-Reply-To: <20121030151029.GD29159@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Linux OMAP List <linux-omap@vger.kernel.org>


On 10/30/2012 10:10 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 30, 2012 at 09:16:34AM -0500, Jon Hunter wrote:
>> Hi Felipe,
>>
>> On 10/30/2012 02:09 AM, Felipe Balbi wrote:
>>
>> ...
>>
>>>> its bit of an issue to take care. How do you ensure that GPIO
>>>> does idle on SOC idle C-state attempts in such cases. Today that
>>>> job is done by omap_gpio_[prepare/resume]_for_idle.
>>>
>>> that's only there because we pm_runtime_get_sync() on gpio_request() and
>>> pm_runtime_put_sync() only on gpio_free().
>>>
>>> That's the problem IMHO. And that's easy enough to 'fix':
>>>
>>> call pm_runtime_mark_last_busy(); pm_runtime_put_sync_autosuspend();
>>> also on gpio_request() and pm_runtime_get_sync() on gpio_free().
>>
>> Sounds like a good approach. I have been discussing with Kevin and I
>> need to look more at the resume handler as we are working around some
>> old issues in there and with this approach the resume following idle
>> will be delayed and we were not sure if there could be any implications
>> for omap2. I am hoping not, but we need to look into this.
>>
>> So I am wondering if we should just take Tim's original proposal for now
>> and then I will look into improving this long term. I really need to
>> clean-up the suspend/resume stuff for gpio and so may be we can make
>> that a separate change. What do you think?
> 
> that'll cause a regression right ?

Sorry, not sure I follow.

>>> The difficult part, IMHO, is to figure out what's a good autosuspend
>>> timeout to use. Some GPIO lines are used as IRQ lines on some devices,
>>> that means that the GPIO will be periodically triggered and, depending
>>> on our timeout, we will either loose IRQs or prevent power domain from
>>> idling. We could figure out a way to let board code to choose what it
>>> wants on a per-bank basis (maybe some extra DT attribute).
>>
>> I have also been bending Kevin's ear on this, this week and we were
>> wondering if we should make the default 0 for now as this will have the
> 
> I believe you mean -1 here ;-)

I did mean 0, so that it will autosuspend right away. Basically, it will
behave like today, however, will allow people to change the timeout. I
did not wish to make it -1 as then suspend/resume would not be exercised
and so people would need to change it via the sysfs to exercise deep
power states on the device.

>> same behaviour that we have today but would allow Tim to customise via
>> the sysfs for his specific app.
> 
> sysfs might be too late for his platform. What if he needs NFS root
> (just wondering, not sure about his use case) ?

His use case was for SPI (see the original changelog). That's a good
point, but I am wondering if we can live with that for now.

Cheers
Jon

