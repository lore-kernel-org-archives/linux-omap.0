From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 19:15:07 +0530
Message-ID: <4F3A6563.7000108@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com>  <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com>  <1329225311.1845.109.camel@deskari>  <4F3A61EF.4030803@ti.com> <1329226404.1845.118.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34824 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760038Ab2BNNpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 08:45:23 -0500
In-Reply-To: <1329226404.1845.118.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

On Tuesday 14 February 2012 07:03 PM, Tomi Valkeinen wrote:
> On Tue, 2012-02-14 at 19:00 +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Tuesday 14 February 2012 06:45 PM, Tomi Valkeinen wrote:
>>> On Tue, 2012-02-14 at 13:58 +0100, Cousson, Benoit wrote:
>>>> Hi Tomi,
>>>
>>>>> Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
>>>>> hwmod/clk framework at some point, and the drivers could do without
>>>>> these kinds of hacks? =)
>>>>
>>>> The best way to fix that for my point of view is to go to device tree
>>>> or/and to consider the DSS as the parent of all the DSS modules.
>>>> pm_runtime will then always ensure that the parent is enabled before any
>>>> of the child are used.
>>>
>>> Ah, right. Sounds fine to me.
>>>
>>> But is that a proper "fix"? Are we sure the MODULEMODE will then always
>>> be handled correctly? Isn't the core problem still there, it just
>>> doesn't happen with the setup anymore?
>>>
>>> I mean, if we have these special requirements regarding MODULEMODE, and
>>> the code doesn't really know about it, would it get broken easily with
>>> restructuring/changes?
>>>
>>> And no, I don't have any clear idea why/how it would break, but I have
>>> just gotten the impression that the MODULEMODE is not handled quite
>>> properly (and so we have these current problems), and having dss_core as
>>> the parent of other dss modules doesn't really fix that in any way.
>>
>> I agree with that.
>>
>> In the current approach, we have multiple platform devices for DSS, and
>> all of them belong to the same clock domain, and the clock domain has
>> just one MODULEMODE bit field.
>>
>> When shutting off a platform device(by calling pm_runtime_put()), hwmod
>> enables/disables MODULEMODE without taking into mind that other active
>> platform devices may still need it. So, for example, if we have 2
>> platform devices, say dss and dispc, and we have code like:
>>
>> dispc_foo()
>> {
>> 	pm_runtime_get(dispc_pdev);
>> 		...
>> 		...
>> 	pm_runtime_put(dispc_pdev);
>> }
>>
>> dss_foo()
>> {
>> 	pm_runtime_get(dss_pdev);
>> 		...
>> 		...
>> 		dispc_foo(); /* MODULEMODE off after this */
>> 		...
>> 		...
>> 	pm_runtime_put(dss_pdev);
>> }
>>
>> This will lead to the situation of one platform device disabling
>> MODULEMODE even though other platform devices need it.
>>
>> This may not be resolved in device tree either. We would need to have
>> some use count mechanism for these bits, or attach MODULEMODE only to
>> one platform device, and don't give others control to enable/disable it.
>
> Hmm, are you sure? Not that I checked the code, but isn't MODULEMODE
> mapped to a dss clock (was it "dss_clk")?. And so, the clock's refcount
> should keep the MODULEMODE enabled/disabled?

Yes, that's how we are currently dealing with it and making things work. 
We are forced to represent MODULEMODE as a clock. I forgot to mention 
that in the last mail :)

However, other modules don't do this. modulemode control is taken care 
by hwmod by itself. We just have to fill the hwmod field 
'.prcm.omap4.modulemode' and get done with it. If we try this approach, 
we get into the trouble I mentioned before.

We represent MODULEMODE as dss_fck, and make this the l3 slave clock for 
all DSS hwmods. This way, we ensure that it gets enabled, and we get a 
usecount associated to it. We shouldn't stick to this approach because:

- It isn't exactly correct. MODULEMODE isn't a clock, and others don't 
do it.

- DSS requires a particular sequence of disabling clocks to go into 
lower power states, and with the current approach, this doesn't happen. 
So, DSS doesn't idle, and that's the whole purpose of this :)

Archit

>
>   Tomi
>

