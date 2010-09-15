From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Wed, 15 Sep 2010 07:32:21 -0700
Message-ID: <87mxrjgjre.fsf@deeprootsystems.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
	<AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
	<AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44163 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0IOOcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 10:32:31 -0400
In-Reply-To: <AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW@mail.gmail.com>
	(venki kaps's message of "Wed, 15 Sep 2010 19:25:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: venki kaps <venkiece2005@gmail.com>
Cc: omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, s-anna@ti.com, grgupta@ti.com, ivan.gomez@ti.com, ext-andriy.shevchenko@nokia.com, x0095078@ti.com, deepak.chitriki@ti.com, nm@ti.com, ext-phil.2.carmody@nokia.com, ohad@wizery.com, devel@linuxdriverproject.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

venki kaps <venkiece2005@gmail.com> writes:

> On Tue, Sep 14, 2010 at 8:54 PM, venki kaps <venkiece2005@gmail.com> =
wrote:
>> On Tue, Sep 14, 2010 at 1:28 AM, venki kaps <venkiece2005@gmail.com>=
 wrote:
>>> Dear all,
>>>
>>> I have been facing an issue with OMAP3 PM with DSP MMU Fault (Kerne=
l 2.6.32).
>>>
>>> The issue is describing as below mentioned way,
>>> =A0 =A0 =A0 =A01). The Device is getting DSP MMU Fault when playing=
 MP4 video clip.
>>>
>>> The system is not hitting off mode in the below scenario,
>>> =A0 =A0 =A0 =A02). System boot ->play mp4 clip ->DSP MMU Fault -> a=
llow off
>>> mode -----------> Never hits off mode
>>>
>>> But surprisingly the system is hitting off mode in the below scenar=
io,
>>> =A0 =A0 =A0 3). System boot ->allow off mode ->play mp4 clip ->DSP =
MMU
>>> Fault -> allow off mode -----------> perfectly works
>>>
>>>
>>> =A0- Could you please describe the root cause about the above issue=
s 1 & 2?
>>> =A0- How could solve the above issues?
>>
>> I have found the issue with UART3.
>> In System configuration register (SYSC),-
>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- Smart idle -------> working sc=
enario =A0------>
>> system hits off mode.
>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- No idle -------> Non working s=
cenario
>> ------> system never hits off mode.
>>
>> Could you please explain why UART3 is not able to hit smart idle aft=
er
>> DSP MMU fault ( System boot ->play mp4 clip ->DSP MMU Fault -> allow
>> off -----------> Never hits off mode).,
>
> My problem is resolved.GPtimer7 was not reset during the MMU FAULT
> occurrence before the first power cycle.
> So this pending interrupt is preventing the system sleep entry.
> Now it works fine after resetting Gptimer7 in pm suspend path.

Sounds like a patch is needed for DSPBridge who manages that timer.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
