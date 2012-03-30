From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 15:59:41 +0530
Message-ID: <4F758B15.1040905@ti.com>
References: <1333094862.1932.15.camel@deskari>  <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com> <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com> <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:35869 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932841Ab2C3K3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 06:29:50 -0400
Received: by obqv19 with SMTP id v19so960644obq.12
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 03:29:46 -0700 (PDT)
In-Reply-To: <4F7589A3.6080104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Friday 30 March 2012 03:53 PM, Cousson, Benoit wrote:
> On 3/30/2012 10:44 AM, Santosh Shilimkar wrote:
>> On Friday 30 March 2012 02:04 PM, Archit Taneja wrote:
>>> On Friday 30 March 2012 02:01 PM, Santosh Shilimkar wrote:
>>>> + Kevin
>>>>
>>>> On Friday 30 March 2012 01:56 PM, Tomi Valkeinen wrote:
>>>>> On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
>>>>>> On Fri, Mar 30, 2012 at 1:37 PM, Tomi
>>>>>> Valkeinen<tomi.valkeinen@ti.com>   wrote:
>>>>>
>>>>>>> All OMAP4 versions seem to be affected. I couldn't find a mention
>>>>>>> about
>>>>>>> this in the mainline kernel. Any ideas how and where this should be
>>>>>>> fixed?
>>>>>>>
>>>>>> It's not patched for mainline. Generally clock-domain code
>>>>>> is abstracted from drivers but considering the errata and affected
>>>>>> modules, I guees it should be handled by DSS driver
>>>>>> since that is where the state of DSS or ISS will be known. Note
>>>>>> ISS will be automatically taken care since it will always use
>>>>>> disaplay.
>>>>>>
>>>>>> In internal tree's this was handled as part of DSS early
>>>>>> suspend/resume
>>>>>
>>>>> That version doesn't work as it uses functions that are not
>>>>> exported to
>>>>> drivers.
>>>>>
>>>>> I don't know much about the clock domain code, but I hope there's a
>>>>> way
>>>>> to handle it there. Otherwise I guess I need to add a new set of
>>>>> platform callback functions, so that the dss driver can call
>>>>> arch/arm/mach-omap2 code to enable and disable the work-around. I
>>>>> dislike that because I'm currently trying to remove those kinds of
>>>>> hacks
>>>>> to make dss work better with DT =).
>>>>>
>>>> I agree. In fact I faced similar issue when I briefly tried moving
>>>> OMAP cpuidle code to drivers/idle/*.
>>>>
>>>> That time me and Kevin concluded that till we move the powerdomain,
>>>> clockdomain code to drivers/* and export it, the cpuidle movement
>>>> needs to be deferred.
>>>
>>> How about preventing the issue to occur by keeping DSS and ISS in
>>> No-standby mode for the affected OMAP versions. The errata says:
>>>
>>> "Such a situation can occur when the impacted initiator is generating
>>> short MStandby pulses (pulse durations less than one L4 clock cycle)"
>>>
>>> Chaning the mstandby hwmod data for DSS and ISS would prevent the need
>>> for exporting these clock domain functions only for this errata.
>>>
>> That will just break PM :-)
> 
> Not at all. At least it will not be worst than the current WA.
> 
> I think Archit is right, at least this is the exact same question I'm
> asking to the designers :-).
>
Am not sure what do you mean by here. What Archit said is statitically
setting up DSS/ISS sysnconfig to no standby. It will definitely break
PM.

The WA was doing runtime this with clockdomain APIs. If you say manage
the sysconfig runtime in driver, then it will work.

>> With this change DSS will never assert standby and then PRCM can never
>> send idle-req to modules. Indirectly no power transitions.
> 
> This is exactly what will happen if you set the clock domain in NO_IDLE.
> So in any case, you cannot have autoidle during the
> 
Guess I was not clear. The idea was to put CD in no_idle
when DSS active and allow idle when not active.

Looks like you saying OK to hack sysconfig for which we have
been pushing back on drivers not to do it. Ofcourse errata
and various reset bugs have broken that rule anyways.

Regards
Santosh

Regards
santosh

