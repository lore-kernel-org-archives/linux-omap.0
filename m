From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: Re: How to enable dvfs in omap.
Date: Sat, 12 Feb 2011 16:42:54 +0530
Message-ID: <4D566B36.8000008@e-consystems.com>
References: <4D5665D4.2030902@e-consystems.com> <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:40108 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751051Ab1BLLM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 06:12:58 -0500
In-Reply-To: <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: OMAP-KML <linux-omap@vger.kernel.org>

Hi Santosh,

Thanks for the help .

Regareds,
Mohamed Thalib H.

On Saturday 12 February 2011 04:27 PM, Santosh Shilimkar wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Mohamed Thalib H
>> Sent: Saturday, February 12, 2011 4:20 PM
>> To: OMAP-KML
>> Subject: How to enable dvfs in omap.
>>
>> Hi all,
>>
>> I am using omap 2.6.37 running overo board. I have enabled the
>> following
>> option in the kernel menunconfig,
>>
>>
>> CPU Power Management --->
>> =E2=94=82 =E2=94=82 [*] CPU Frequency scaling
>> =E2=94=82 =E2=94=82 [ ] Enable CPUfreq debugging
>> =E2=94=82 =E2=94=82<*>  CPU frequency translation statistics
>> =E2=94=82 =E2=94=82 [*] CPU frequency translation statistics details
>> =E2=94=82 =E2=94=82 Default CPUFreq governor (ondemand) --->
>> =E2=94=82 =E2=94=82 -*- 'performance' governor
>> =E2=94=82 =E2=94=82<M>  'powersave' governor
>> =E2=94=82 =E2=94=82<*>  'userspace' governor for userspace frequency=
 scaling
>> =E2=94=82 =E2=94=82 -*- 'ondemand' cpufreq policy governor
>> =E2=94=82 =E2=94=82<*>  'conservative' cpufreq governor
>> =E2=94=82 =E2=94=82 [ ] CPU idle PM support
>>
>>
>> but still I could find the sys and entry in
>> /sys/devices/system/cpu/cpufreq/ directory. Could some one help me
>> to enable DVFS.
>>
> That's because tts not supported yet.
> You may want to look at this[1] series which is in progress
> to enable the support.
>
>
> Regards,
> Santosh
>
> [1] [PATCH 00/13] OMAP: Basic DVFS Framework
>   http://www.spinics.net/lists/linux-omap/msg44393.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
