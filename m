From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: Re: How to enable dvfs in omap.
Date: Sat, 12 Feb 2011 17:51:32 +0530
Message-ID: <4D567B4C.5030502@e-consystems.com>
References: <4D5665D4.2030902@e-consystems.com> <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com> <4D566B36.8000008@e-consystems.com> <4D567436.2090602@ti.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:44873 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753548Ab1BLMVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 07:21:36 -0500
In-Reply-To: <4D567436.2090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, OMAP-KML <linux-omap@vger.kernel.org>


On Saturday 12 February 2011 05:21 PM, Nishanth Menon wrote:
> Mohamed Thalib H wrote, on 02/12/2011 04:42 PM:
>> Hi Santosh,
>>
>> Thanks for the help .
>>
>> Regareds,
>> Mohamed Thalib H.
>>
>> On Saturday 12 February 2011 04:27 PM, Santosh Shilimkar wrote:
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Mohamed Thalib H
>>>> Sent: Saturday, February 12, 2011 4:20 PM
>>>> To: OMAP-KML
>>>> Subject: How to enable dvfs in omap.
>>>>
>>>> Hi all,
>>>>
>>>> I am using omap 2.6.37 running overo board. I have enabled the
>>>> following
>>>> option in the kernel menunconfig,
>>>>
>>>>
>>>> CPU Power Management --->
>>>> =E2=94=82 =E2=94=82 [*] CPU Frequency scaling
>>>> =E2=94=82 =E2=94=82 [ ] Enable CPUfreq debugging
>>>> =E2=94=82 =E2=94=82<*> CPU frequency translation statistics
>>>> =E2=94=82 =E2=94=82 [*] CPU frequency translation statistics detai=
ls
>>>> =E2=94=82 =E2=94=82 Default CPUFreq governor (ondemand) --->
>>>> =E2=94=82 =E2=94=82 -*- 'performance' governor
>>>> =E2=94=82 =E2=94=82<M> 'powersave' governor
>>>> =E2=94=82 =E2=94=82<*> 'userspace' governor for userspace frequenc=
y scaling
>>>> =E2=94=82 =E2=94=82 -*- 'ondemand' cpufreq policy governor
>>>> =E2=94=82 =E2=94=82<*> 'conservative' cpufreq governor
>>>> =E2=94=82 =E2=94=82 [ ] CPU idle PM support
>>>>
>>>>
>>>> but still I could find the sys and entry in
>>>> /sys/devices/system/cpu/cpufreq/ directory. Could some one help me
>>>> to enable DVFS.
>>>>
>>> That's because tts not supported yet.
>>> You may want to look at this[1] series which is in progress
>>> to enable the support.
>>>
>>>
>>> Regards,
>>> Santosh
>>>
>>> [1] [PATCH 00/13] OMAP: Basic DVFS Framework
>>> http://www.spinics.net/lists/linux-omap/msg44393.html
>
> if you are interested,
> I rebased the last set with k.org and fixes from pm tree for=20
> development for smartreflex class 1.5 here:
> http://gitorious.org/linux-omap-nm-sr/linux-omap-sr/commits/dvfs
>
> git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
> branch: dvfs
>
>
Thanks for your help Nishanth,

Surely I will pull the git and checkout..

Regards,
Thalib.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
