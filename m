From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 20 Jan 2012 14:47:47 +0100
Message-ID: <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
	<CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
	<CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
	<CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
	<CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
	<CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
	<CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
	<CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
	<CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
	<CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
	<CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32874 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab2ATNrs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 08:47:48 -0500
Received: by wics10 with SMTP id s10so413747wic.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 05:47:47 -0800 (PST)
In-Reply-To: <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

Started afresh from:

90a4c0f uml: fix compile for x86-64

And added 3, 4, 5, 6:
603c316 arm: omap4: pmu: support runtime pm
4899fbd arm: omap4: support pmu
d737bb1 arm: omap4: create pmu device via hwmod
4e0259e arm: omap4: hwmod: introduce emu hwmod

Still no interrupts firing. I am using your .config file.

My HW:
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x1
CPU part	: 0xc09
CPU revision	: 2

Hardware	: OMAP4 Panda board
Revision	: 0020

There must be something I am missing here.



On Thu, Jan 19, 2012 at 6:07 PM, stephane eranian
<eranian@googlemail.com> wrote:
> Just did a fresh clone of Linus' tree:
>
> $ git log --oneline | fgrep 'allow platform specific'
> e0516a6 arm: pmu: allow platform specific irq enable/disable handling
>
> $ git log --oneline | fgrep 'cross trigger'
> 14eec97 arm: introduce cross trigger interface helpers
>
> Unless you were referring to a different pair of patches.
>
>
> On Thu, Jan 19, 2012 at 2:51 PM, Ming Lei <ming.lei@canonical.com> wr=
ote:
>> Hi,
>>
>> On Thu, Jan 19, 2012 at 9:32 PM, stephane eranian
>> <eranian@googlemail.com> wrote:
>>> On Thu, Jan 19, 2012 at 2:26 PM, Ming Lei <ming.lei@canonical.com> =
wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jan 19, 2012 at 9:14 PM, Ming Lei <ming.lei@canonical.com>=
 wrote:
>>>>> On Thu, Jan 19, 2012 at 8:51 PM, stephane eranian
>>>>> <eranian@googlemail.com> wrote:
>>>>>> On Thu, Jan 19, 2012 at 1:45 PM, Ming Lei <ming.lei@canonical.co=
m> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, Jan 19, 2012 at 7:34 PM, stephane eranian
>>>>>>> <eranian@googlemail.com> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Ok some update on this.
>>>>>>>> With your .config file + 3.2.0 (Linus) + patch 3, 4, 5, 6, I g=
et a kernel that
>>>>>>>
>>>>>>> You forget patch 1 and patch 2?
>>>>>>>
>>>>>> They are already in 3.2.0. Unless I am mistaken.
>>>>>
>>>>> Sorry, I just found that they have been merged to 3.2.
>>>>
>>>> After a double check, the two patches are not merged to 3.2, but h=
ave
>>>> been merged to the latest linus tree and can be seen in 3.3-rc1.
>>>>
>>>> Also the commit 3c50729b(ARM: OMAP4: PM: Initialise all the clockd=
omains
>>>> to supported states) has been merged to linus tree too.
>>>>
>>>> So if you just tested the latest linus tree simply, you need to ap=
ply
>>>> the patch[1]
>>>> (I have mentioned the problem in the thread.)
>>>>
>>>
>>> Changing LMO, u-boot.bin did not help. Even with perf top I get no
>>> interrupts.
>>>
>>> My Linus tree is at commit fa1952b:
>>>
>>> [6] 11891e1 arm: omap4: pmu: support runtime pm
>>> [5] 25fab8a arm: omap4: support pmu
>>> [4] fddef77 arm: omap4: create pmu device via hwmod
>>>
>>> fa1952b ARM: OMAP4: hwmod data: Add support for the debug modules
>>
>> Sorry, there is no commit fa1952b in linus[1] tree at all, so you ar=
e
>> not testing
>> linus tree...
>>
>> If you'd like to follow my instructions, I can help you further.
>>
>>> ccb19d2 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/n=
et
>>> c3b5003 tg3: Fix single-vector MSI-X code
>>>
>>> I think [1] had conflicts when applying it to the tree.
>>
>> It is only one line(one character) change, you can do it manually.
>>
>>>
>>>> thanks,
>>>> --
>>>> Ming Lei
>>>>
>>>> [1],
>>>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
>>>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
>>>> index 9299ac2..41d2260 100644
>>>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>>>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>>>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D=
 {
>>>> =C2=A0 =C2=A0 =C2=A0 .prcm_partition =C2=A0 =3D OMAP4430_PRM_PARTI=
TION,
>>>> =C2=A0 =C2=A0 =C2=A0 .cm_inst =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 OMAP4430_PRM_EMU_CM_INST,
>>>> =C2=A0 =C2=A0 =C2=A0 .clkdm_offs =C2=A0 =C2=A0 =C2=A0 =3D OMAP4430=
_PRM_EMU_CM_EMU_CDOFFS,
>>>> - =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D CLKDM_CAN_HWSUP,
>>>> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D CLKDM_CAN_SWSUP,
>>>> =C2=A0};
>>>>
>>
>> [1], http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;=
a=3Dsummary
>>
>> thanks,
>> --
>> Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
