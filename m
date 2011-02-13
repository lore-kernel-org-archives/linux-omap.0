From: "Kahn, Gery" <geryk@ti.com>
Subject: Re: How to enable dvfs in omap.
Date: Sun, 13 Feb 2011 17:09:32 +0200
Message-ID: <AANLkTin3MZNATS4XuY5qU3f7C=f9KogV+1A2_vZTxF-_@mail.gmail.com>
References: <4D5665D4.2030902@e-consystems.com>
	<e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com>
	<4D566B36.8000008@e-consystems.com>
	<4D567436.2090602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55178 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753989Ab1BMPJe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Feb 2011 10:09:34 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so2796059vws.5
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 07:09:33 -0800 (PST)
In-Reply-To: <4D567436.2090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: mohamed@e-consystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, OMAP-KML <linux-omap@vger.kernel.org>

Dear Nishanth,

Thank you for the git.
The pull worked good without problem.

During compilation i found such problem:

arch/arm/plat-omap/cpu-omap.c:142: error: 'struct cpuinfo_arm' has no
member named 'loops_per_jiffy'

Is there solution for the issue?

Gery

On Sat, Feb 12, 2011 at 13:51, Nishanth Menon <nm@ti.com> wrote:
> Mohamed Thalib H wrote, on 02/12/2011 04:42 PM:
>>
>> Hi Santosh,
>>
>> Thanks for the help .
>>
>> Regareds,
>> Mohamed Thalib H.
>>
>> On Saturday 12 February 2011 04:27 PM, Santosh Shilimkar wrote:
>>>>
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
> I rebased the last set with k.org and fixes from pm tree for developm=
ent for
> smartreflex class 1.5 here:
> http://gitorious.org/linux-omap-nm-sr/linux-omap-sr/commits/dvfs
>
> git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
> branch: dvfs
>
>
> --
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
