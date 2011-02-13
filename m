From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: How to enable dvfs in omap.
Date: Sun, 13 Feb 2011 16:38:53 +0100
Message-ID: <0ECA9072-4E28-4DE4-B366-6080F835C288@dominion.thruhere.net>
References: <4D5665D4.2030902@e-consystems.com> <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com> <4D566B36.8000008@e-consystems.com> <4D567436.2090602@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51812 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1BMPi6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Feb 2011 10:38:58 -0500
Received: by wyb28 with SMTP id 28so3977339wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 07:38:57 -0800 (PST)
In-Reply-To: <4D567436.2090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: OMAP-KML <linux-omap@vger.kernel.org>


Op 12 feb 2011, om 12:51 heeft Nishanth Menon het volgende geschreven:

> Mohamed Thalib H wrote, on 02/12/2011 04:42 PM:
>> Hi Santosh,
>>=20
>> Thanks for the help .
>>=20
>> Regareds,
>> Mohamed Thalib H.
>>=20
>> On Saturday 12 February 2011 04:27 PM, Santosh Shilimkar wrote:
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Mohamed Thalib H
>>>> Sent: Saturday, February 12, 2011 4:20 PM
>>>> To: OMAP-KML
>>>> Subject: How to enable dvfs in omap.
>>>>=20
>>>> Hi all,
>>>>=20
>>>> I am using omap 2.6.37 running overo board. I have enabled the
>>>> following
>>>> option in the kernel menunconfig,
>>>>=20
>>>>=20
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
>>>>=20
>>>>=20
>>>> but still I could find the sys and entry in
>>>> /sys/devices/system/cpu/cpufreq/ directory. Could some one help me
>>>> to enable DVFS.
>>>>=20
>>> That's because tts not supported yet.
>>> You may want to look at this[1] series which is in progress
>>> to enable the support.
>>>=20
>>>=20
>>> Regards,
>>> Santosh
>>>=20
>>> [1] [PATCH 00/13] OMAP: Basic DVFS Framework
>>> http://www.spinics.net/lists/linux-omap/msg44393.html
>=20
> if you are interested,
> I rebased the last set with k.org and fixes from pm tree for developm=
ent for smartreflex class 1.5 here:
> http://gitorious.org/linux-omap-nm-sr/linux-omap-sr/commits/dvfs

Do you also have a branch that is fully rebased with no merge commits?

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
