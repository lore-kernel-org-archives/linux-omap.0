From: Nishanth Menon <nm@ti.com>
Subject: Re: How to enable dvfs in omap.
Date: Sat, 12 Feb 2011 17:21:18 +0530
Message-ID: <4D567436.2090602@ti.com>
References: <4D5665D4.2030902@e-consystems.com> <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com> <4D566B36.8000008@e-consystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42878 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310Ab1BLLv1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 06:51:27 -0500
Received: by mail-yx0-f182.google.com with SMTP id 35so1499468yxh.27
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 03:51:26 -0800 (PST)
In-Reply-To: <4D566B36.8000008@e-consystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohamed@e-consystems.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, OMAP-KML <linux-omap@vger.kernel.org>

Mohamed Thalib H wrote, on 02/12/2011 04:42 PM:
> Hi Santosh,
>
> Thanks for the help .
>
> Regareds,
> Mohamed Thalib H.
>
> On Saturday 12 February 2011 04:27 PM, Santosh Shilimkar wrote:
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Mohamed Thalib H
>>> Sent: Saturday, February 12, 2011 4:20 PM
>>> To: OMAP-KML
>>> Subject: How to enable dvfs in omap.
>>>
>>> Hi all,
>>>
>>> I am using omap 2.6.37 running overo board. I have enabled the
>>> following
>>> option in the kernel menunconfig,
>>>
>>>
>>> CPU Power Management --->
>>> =E2=94=82 =E2=94=82 [*] CPU Frequency scaling
>>> =E2=94=82 =E2=94=82 [ ] Enable CPUfreq debugging
>>> =E2=94=82 =E2=94=82<*> CPU frequency translation statistics
>>> =E2=94=82 =E2=94=82 [*] CPU frequency translation statistics detail=
s
>>> =E2=94=82 =E2=94=82 Default CPUFreq governor (ondemand) --->
>>> =E2=94=82 =E2=94=82 -*- 'performance' governor
>>> =E2=94=82 =E2=94=82<M> 'powersave' governor
>>> =E2=94=82 =E2=94=82<*> 'userspace' governor for userspace frequency=
 scaling
>>> =E2=94=82 =E2=94=82 -*- 'ondemand' cpufreq policy governor
>>> =E2=94=82 =E2=94=82<*> 'conservative' cpufreq governor
>>> =E2=94=82 =E2=94=82 [ ] CPU idle PM support
>>>
>>>
>>> but still I could find the sys and entry in
>>> /sys/devices/system/cpu/cpufreq/ directory. Could some one help me
>>> to enable DVFS.
>>>
>> That's because tts not supported yet.
>> You may want to look at this[1] series which is in progress
>> to enable the support.
>>
>>
>> Regards,
>> Santosh
>>
>> [1] [PATCH 00/13] OMAP: Basic DVFS Framework
>> http://www.spinics.net/lists/linux-omap/msg44393.html

if you are interested,
I rebased the last set with k.org and fixes from pm tree for developmen=
t=20
for smartreflex class 1.5 here:
http://gitorious.org/linux-omap-nm-sr/linux-omap-sr/commits/dvfs

git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
branch: dvfs


--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
