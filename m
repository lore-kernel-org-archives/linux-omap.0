From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Tue, 13 Oct 2015 09:48:28 +0530
Message-ID: <561C8614.8080402@ti.com>
References: <1440561575-3740-1-git-send-email-j-keerthy@ti.com>
 <55E5DE12.6070407@ti.com> <20150901180347.GO4215@atomide.com>
 <55E640ED.6070004@ti.com> <20151012171716.GG23801@atomide.com>
 <20151012172941.GH23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012172941.GH23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org



On Monday 12 October 2015 10:59 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151012 10:17]:
>> * Keerthy <a0393675@ti.com> [150901 17:24]:
>>>
>>>
>>> On Tuesday 01 September 2015 11:33 PM, Tony Lindgren wrote:
>>>> * Keerthy <a0393675@ti.com> [150901 10:22]:
>>>>>
>>>>>
>>>>> On Wednesday 26 August 2015 09:29 AM, Keerthy wrote:
>>>>>> Currently apart from dra7, omap5 and amx3 all the other SoCs
>>>>>> are identified using cpu_is_* functions which is not right since
>>>>>> they are all SoCs(System on Chips). Hence changing the SoC
>>>>>> identification code to use soc_is instead of cpu_is and keeping
>>>>>> defines for cpu_is where needed. This allows us to replace the
>>>>>> rest of cpu_is usage along with other fixes as needed.
>>>>>
>>>>> Tony,
>>>>>
>>>>> A Gentle ping on this.
>>>>
>>>> Looks good to me for v4.4. I'll apply it after some testing
>>>> after -rc1.
>>>
>>> Thanks Tony.
>>
>> Now with the fixes finally out of the way, applying into
>> omap-for-v4.4/cleanup.
>
> Uhh actually not applying. This breaks builds quite a bit depending o=
n
> the .config options chosen:
>
> arch/arm/mach-omap2/io.c:767:6: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap24xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> arch/arm/mach-omap2/control.c:257:15: error: implicit declaration of =
function =E2=80=98cpu_is_omap243x=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> arch/arm/mach-omap2/control.c:259:8: error: implicit declaration of f=
unction =E2=80=98cpu_is_omap44xx=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> ...
> arch/arm/mach-omap2/io.c:389:7: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap34xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> arch/arm/mach-omap2/io.c:767:6: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap24xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> ...
> arch/arm/mach-omap2/io.c:389:7: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap34xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> arch/arm/mach-omap2/io.c:767:6: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap24xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> ...
> arch/arm/mach-omap2/io.c:767:6: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap24xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> arch/arm/mach-omap2/control.c:257:15: error: implicit declaration of =
function =E2=80=98cpu_is_omap243x=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> arch/arm/mach-omap2/control.c:259:8: error: implicit declaration of f=
unction =E2=80=98cpu_is_omap44xx=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> ...
> arch/arm/mach-omap2/io.c:767:6: error: implicit declaration of functi=
on =E2=80=98cpu_is_omap24xx=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>
> Keerthy, can you please test this with just single SoC configurations
> and run randconfig builds on this overnight.

I will do that Tony. I tested omap2plus_defconfig and boot tested on=20
multiple platforms.

>
> And then we obviously need to test to make sure that this does not
> break booting on various platforms for multi SoC and single SoC
> configurations.

Okay.

>
> And then you can repost, please include what all was tested.

Sure.

>
> Thanks,
>
> Tony
>
