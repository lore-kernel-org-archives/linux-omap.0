From: venki kaps <venkiece2005@gmail.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Wed, 15 Sep 2010 19:25:56 +0530
Message-ID: <AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW__16002.6911566549$1284558990$gmane$org@mail.gmail.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
	<AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61994 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0IONz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 09:55:57 -0400
In-Reply-To: <AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, s-anna@ti.com, grgupta@ti.com, iva

On Tue, Sep 14, 2010 at 8:54 PM, venki kaps <venkiece2005@gmail.com> wr=
ote:
> On Tue, Sep 14, 2010 at 1:28 AM, venki kaps <venkiece2005@gmail.com> =
wrote:
>> Dear all,
>>
>> I have been facing an issue with OMAP3 PM with DSP MMU Fault (Kernel=
 2.6.32).
>>
>> The issue is describing as below mentioned way,
>> =A0 =A0 =A0 =A01). The Device is getting DSP MMU Fault when playing =
MP4 video clip.
>>
>> The system is not hitting off mode in the below scenario,
>> =A0 =A0 =A0 =A02). System boot ->play mp4 clip ->DSP MMU Fault -> al=
low off
>> mode -----------> Never hits off mode
>>
>> But surprisingly the system is hitting off mode in the below scenari=
o,
>> =A0 =A0 =A0 3). System boot ->allow off mode ->play mp4 clip ->DSP M=
MU
>> Fault -> allow off mode -----------> perfectly works
>>
>>
>> =A0- Could you please describe the root cause about the above issues=
 1 & 2?
>> =A0- How could solve the above issues?
>
> I have found the issue with UART3.
> In System configuration register (SYSC),-
> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- Smart idle -------> working sce=
nario =A0------>
> system hits off mode.
> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- No idle -------> Non working sc=
enario
> ------> system never hits off mode.
>
> Could you please explain why UART3 is not able to hit smart idle afte=
r
> DSP MMU fault ( System boot ->play mp4 clip ->DSP MMU Fault -> allow
> off -----------> Never hits off mode).,

My problem is resolved.GPtimer7 was not reset during the MMU FAULT
occurrence before the first power cycle.
So this pending interrupt is preventing the system sleep entry.
Now it works fine after resetting Gptimer7 in pm suspend path.

> Thanks in advance.
>
>> Best Regards,
>> Venkii
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
