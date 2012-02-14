From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Wed, 15 Feb 2012 01:12:07 +0530
Message-ID: <4F3AB90F.1010800@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com> <1329220678.1845.68.camel@deskari> <4F3A5A5D.4020906@ti.com> <1329225311.1845.109.camel@deskari> <4F3A61EF.4030803@ti.com> <1329226404.1845.118.camel@deskari> <4F3A6563.7000108@ti.com> <4F3A85B0.906@ti.com> <CAMQu2gxdWt0rLZYs1SVToD1OExeqgRPTXcKPeR2RkUc-Qgqgqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54333 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757159Ab2BNTm1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 14:42:27 -0500
In-Reply-To: <CAMQu2gxdWt0rLZYs1SVToD1OExeqgRPTXcKPeR2RkUc-Qgqgqw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Archit Taneja <a0393947@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

On Tuesday 14 February 2012 10:29 PM, Shilimkar, Santosh wrote:
> On Tue, Feb 14, 2012 at 9:32 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 2/14/2012 2:45 PM, Archit Taneja wrote:
>>>
>>> On Tuesday 14 February 2012 07:03 PM, Tomi Valkeinen wrote:
>>>>
>>>> On Tue, 2012-02-14 at 19:00 +0530, Archit Taneja wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Tuesday 14 February 2012 06:45 PM, Tomi Valkeinen wrote:
>>>>>>
>>>>>> On Tue, 2012-02-14 at 13:58 +0100, Cousson, Benoit wrote:
>>>>>>>
>>>>>>> Hi Tomi,
>>>>>>
>>>>>>
>>>>>>>> Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
>>>>>>>> hwmod/clk framework at some point, and the drivers could do without
>>>>>>>> these kinds of hacks? =)
>>>>>>>
>>>>>>>
>>>>>>> The best way to fix that for my point of view is to go to device tree
>>>>>>> or/and to consider the DSS as the parent of all the DSS modules.
>>>>>>> pm_runtime will then always ensure that the parent is enabled
>>>>>>> before any
>>>>>>> of the child are used.
>>>>>>
>>>>>>
>>>>>> Ah, right. Sounds fine to me.
>>>>>>
>>>>>> But is that a proper "fix"? Are we sure the MODULEMODE will then always
>>>>>> be handled correctly? Isn't the core problem still there, it just
>>>>>> doesn't happen with the setup anymore?
>>>>>>
>>>>>> I mean, if we have these special requirements regarding MODULEMODE, and
>>>>>> the code doesn't really know about it, would it get broken easily with
>>>>>> restructuring/changes?
>>>>>>
>>>>>> And no, I don't have any clear idea why/how it would break, but I have
>>>>>> just gotten the impression that the MODULEMODE is not handled quite
>>>>>> properly (and so we have these current problems), and having
>>>>>> dss_core as
>>>>>> the parent of other dss modules doesn't really fix that in any way.
>>>>>
>>>>>
>>>>> I agree with that.
>>>>>
>>>>> In the current approach, we have multiple platform devices for DSS, and
>>>>> all of them belong to the same clock domain, and the clock domain has
>>>>> just one MODULEMODE bit field.
>>>>>
>>>>> When shutting off a platform device(by calling pm_runtime_put()), hwmod
>>>>> enables/disables MODULEMODE without taking into mind that other active
>>>>> platform devices may still need it. So, for example, if we have 2
>>>>> platform devices, say dss and dispc, and we have code like:
>>>>>
>>>>> dispc_foo()
>>>>> {
>>>>> pm_runtime_get(dispc_pdev);
>>>>> ...
>>>>> ...
>>>>> pm_runtime_put(dispc_pdev);
>>>>> }
>>>>>
>>>>> dss_foo()
>>>>> {
>>>>> pm_runtime_get(dss_pdev);
>>>>> ...
>>>>> ...
>>>>> dispc_foo(); /* MODULEMODE off after this */
>>>>> ...
>>>>> ...
>>>>> pm_runtime_put(dss_pdev);
>>>>> }
>>>>>
>>>>> This will lead to the situation of one platform device disabling
>>>>> MODULEMODE even though other platform devices need it.
>>>>>
>>>>> This may not be resolved in device tree either. We would need to have
>>>>> some use count mechanism for these bits, or attach MODULEMODE only to
>>>>> one platform device, and don't give others control to enable/disable it.
>>>>
>>>>
>>>> Hmm, are you sure? Not that I checked the code, but isn't MODULEMODE
>>>> mapped to a dss clock (was it "dss_clk")?. And so, the clock's refcount
>>>> should keep the MODULEMODE enabled/disabled?
>>>
>>>
>>> Yes, that's how we are currently dealing with it and making things work.
>>> We are forced to represent MODULEMODE as a clock. I forgot to mention
>>> that in the last mail :)
>>>
>>> However, other modules don't do this. modulemode control is taken care
>>> by hwmod by itself. We just have to fill the hwmod field
>>> '.prcm.omap4.modulemode' and get done with it. If we try this approach,
>>> we get into the trouble I mentioned before.
>>>
>>> We represent MODULEMODE as dss_fck, and make this the l3 slave clock for
>>> all DSS hwmods. This way, we ensure that it gets enabled, and we get a
>>> usecount associated to it. We shouldn't stick to this approach because:
>>>
>>> - It isn't exactly correct. MODULEMODE isn't a clock, and others don't
>>> do it.
>>
>>
>> Yes, fully agree. This was done like that as a hack to avoid any regression
>> because at that time we were not sure if that dependency will have to be
>> handled by the hwmod fmwk or by the driver.
>> Now, I'm sure it should not be handled by the hwmod fmwk :-)
>>
>>
>>> - DSS requires a particular sequence of disabling clocks to go into
>>> lower power states, and with the current approach, this doesn't happen.
>>> So, DSS doesn't idle, and that's the whole purpose of this :)
>>
>>
>> I'm just curious, what particular sequence is required?
>>
> IIRC, the main issue is the order in which functional clock and what
> is so called
> optional clock enabled ....
>
>
> While enabling the module
> 1. Enable optional clock
> 2. Enabled module mode.
>
> While disabling module
> 1. Disable module mode
> 2. Disable optional clock.
>
> I think only above sequence work. Not following above in either
> path leads to modules being stuck in transition.
>
> Is that right Archit ?

Yes. Also, this transition failure happens when DSS clock domain is set 
to hardware supervised wakeup(HWAUTO).

The opt clock which requires this ordering with module mode is DSS_FCLK 
by default. However, if some other clock (like DSI PLL, sourced by 
SYS_CLK) is the source for DISPC_FCLK, then that clock is the one which 
needs to be ordered with module mode.

Archit

> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

