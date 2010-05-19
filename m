From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
Date: Wed, 19 May 2010 18:04:31 +0200
Message-ID: <4BF40C0F.4000308@ti.com>
References: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com> <4BF3D23F.6070308@ti.com> <FCCFB4CDC6E5564B9182F639FC356087030527036D@dbde02.ent.ti.com> <4BF3F5FF.20407@ti.com> <FCCFB4CDC6E5564B9182F639FC356087030527039F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42696 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0ESQEg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 12:04:36 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4JG4ZF3004472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 11:04:35 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030527039F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 5/19/2010 4:37 PM, Sripathy, Vishwanath wrote:
> Hi Benoit,
>
>> -----Original Message-----
>> From: Cousson, Benoit
>> Sent: Wednesday, May 19, 2010 8:00 PM
>> To: Sripathy, Vishwanath
>> Cc: Gulati, Shweta; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
>>
>> On 5/19/2010 3:50 PM, Sripathy, Vishwanath wrote:
>>> Hi Benoit,
>>>
>>>> -----Original Message-----
>>>> From: Cousson, Benoit
>>>> Sent: Wednesday, May 19, 2010 5:28 PM
>>>> To: Gulati, Shweta
>>>> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath
>>>> Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
>>>>
>>>> Hi Vishwa,
>>>>
>>>> On 5/13/2010 12:12 PM, shweta gulati wrote:
>>>>> From: Vishwanath Sripathy<vishwanath.bs@ti.com>
>>>>>
>>>>> OMAP3430/3630 has a Silicon bug because of which SDRC is
>>>>> released from IDLE even before Core DPLL has locked. This leads
>>>>> to undefined behaviour of SDRC DLL.
>>>>>
>>>>> This patch has workaround for the same.
>>>>>
>>>>> Description of WA for 3430:
>>>>> Initialization:
>>>>> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3
>>>>> 	is always locked.
>>>>>
>>>>> Before CORE Voltage Domain (VDD2) Sleep Transition to RETENTION or OFF
>> mode:
>>>>> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP2 Frequency
>>>>> 	(by changing M2 Divider value). This is increasing the period duration of
>>>>> 	one L3 clock cycle.
>>>>> 	o	In case of CORE is at OPP3 (166MHz@1.15V):
>>>>> 	"	Lower the frequency to 83MHz.
>>>>>
>>>>> 	o	In case of CORE is at OPP2 (83MHz@1.05V):
>>>>> 	"	Keep the frequency as it is (83MHz).
>>>>>
>>>>> 2.	Increase CORE Voltage to 1.2V. This is reducing the timing duration of
>> the
>>>>> 	critical path signal which will now fit to one L3 clock cycle.
>>>>>
>>>>> 3.	Enable DPLL3 Automatic mode. This will ensure proper transition to
>>>>> 	RETENTION or OFF mode.
>>>>>
>>>>> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
>>>>> 1.	Disable DPLL3 Automatic mode.
>>>>> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
>>>>>
>>>>> Description of WA for 3630:
>>>>> Initialization:
>>>>> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 is
>>>> always locked.
>>>>>
>>>>> Before CORE Voltage Domain(VDD2) Sleep Transition to RETENTION or OFF
>> mode:
>>>>> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP50 Frequency
>>>>> 	(by changing M2 Divider value) and set VDD2 Voltage for OPP100.
>>>>> 	This is increasing the period duration of one L3 clock cycle and reducing
>>>>> 	the timing duration of the critical path signal which will now fit to one
>>>>> 	L3 clock cycle.
>>>>> 	o	In case of CORE is at OPP100 (L3=200MHz, VDD2=1.1375V):
>>>>> 		"	Lower the frequency to 100MHz.
>>>>> 		"	Keep the voltage as it is (1.1375V).
>>>>>
>>>>> 	o	In case of CORE is at OPP50 (L3=100MHz, VDD2=0.93V):
>>>>> 		"	Keep the frequency as it is (100MHz).
>>>>> 		"	Increase the voltage to 1.1375V.
>>>>>
>>>>> 2.	Enable DPLL3 Automatic mode. This will ensure proper transition to
>>>>> 	RETENTION or OFF mode.
>>>>>
>>>>> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
>>>>> 1.	Disable DPLL3 Automatic mode.
>>>>> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
>>>>>
>>>>> Also OSWR should not be attempted if DPLL3 has locked. This should be done as
>>>> part of OSWR patch series.
>>>>>
>>>>> Patch tested on 3430SDP and 3630 ZOOM3.
>>>>>
>>>>
>>>> Do you have a more accurate description of the bug? What is the defect ID?
>>>>
>>> Defect Id is i581.
>>>> The subject is about DPLL3 lock issue, and the description is all about
>>>> the transition to CORE RET or OFF and playing with voltage... and why
>>>> OSWR is affected as well?
>>>> I'm a little bit confused by that...
>>>>
>>>> Is this bug dependent of the target power state? What about INACTIVE?
>>> The root cause of the issue is that SDRC IDLEREQ is deasserted before DPLL3 has
>> locked. Because of this DLL may/may not lock based on Process Voltage Temperature
>> conditions. The bug can occur when DPLL3 automatic transition is enabled. So DPLL3
>> automatic transition is disabled by default and it is enabled only when system is
>> entering ret/off state (to facilitate voltage scaling). So when system is entering ret/off
>> state, WA is applied (since DPLL3 autoidle is enabled, we can possibly hit the issue;
>> hence the WA)
>>
>> Thanks, but that still not explain why this WA is considered only for
>> device transition to RET or OFF. The DPLL3 can got to idle as soon as
>> the CORE is INACTIVE. How this case is handled?
> DPLL3 auto idle is disabled when Core is in ON or INACTIVE state. So DPLL3 cannot goto idle state. We enable DPPL3 auto idle only when Core is about to enter RET or OFF state (otherwise VDD2 will not be able to scale the voltage down).

Why did you prevent that mode for INACTIVE? If I remember well, during 
the early measurement we did on 3430, the DPLL consumption in locked 
mode is around 5mw, so you can save a good amount of power for very low 
load use cases.

Did you try to enable that in CPUIdle to check the power saving you can 
achieve with that mode?

Benoit
