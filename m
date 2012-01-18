From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 18 Jan 2012 13:33:23 +0100
Message-ID: <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com> <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com> <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43161 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753875Ab2ARMdp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 07:33:45 -0500
Received: by mail-qy0-f178.google.com with SMTP id e16so1643910qcs.9
        for <linux-omap@vger.kernel.org>; Wed, 18 Jan 2012 04:33:44 -0800 (PST)
In-Reply-To: <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: eranian@gmail.com, Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Jan 18, 2012 at 1:24 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> On Wed, Jan 18, 2012 at 7:39 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Wed, Jan 18, 2012 at 10:33 AM, Ming Lei <ming.lei@canonical.com> =
wrote:
>>> Hi Will and stephane,
>>>
>>> On Wed, Jan 18, 2012 at 12:18 PM, Ming Lei <ming.lei@canonical.com>=
 wrote:
>>>> Hi stephane & Will,
>>>>
>>>> On Tue, Jan 10, 2012 at 8:46 AM, stephane eranian
>>>> <eranian@googlemail.com> wrote:
>>>>> See the dmesg from my 3.2 kernel:
>>>>>
>>>>>
>>>>> [ =A0 =A00.000000] Booting Linux on physical CPU 0[ =A0 =A00.0000=
00]
>>>
>>> But if you test omap4 perf against -next kernel, pmu won't work bec=
ause
>>> the commit[1] may put 'emu_sys_clkdm' =A0clock domain into HW_AUTO =
mode,
>>> so writing pmu register may not take effect.
>>>
>>> I have found =A0the similar problem on cam clock domain before[2].
>>> CD_EMU is very simliar with CD_CAM in the point below:
>>>
>>> =A0 =A0 =A0 =A0CD_EMU has no static or module wake-up dependency wi=
th any other clock
>>> =A0 =A0 =A0 =A0domain of the device.[3]
>>>
>>> So the patch[4] can make omap4 pmu work on -next tree.
>>>
>>> Shilimkar, care to comment on the patch[4]?
>>>
>>> thanks,
>>> --
>>> Ming Lei
>>>
>>> [1], commit 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
>>> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Date: =A0 Wed Jan 5 22:03:17 2011 +0530
>>>
>>> =A0 ARM: OMAP4: PM: Initialise all the clockdomains to supported st=
ates
>>>
>>> =A0 Initialise hardware supervised mode for all clockdomains if it'=
s
>>> =A0 supported. Initiate sleep transition for other clockdomains,
>>> =A0 if they are not being used.
>>>
>>> [2], http://www.spinics.net/lists/linux-omap/msg61911.html
>>>
>>> [3], 3.6.12.3 of OMAP4 TRM
>>>
>>> [4],
>>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
>>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
>>> index 9299ac2..41d2260 100644
>>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D=
 {
>>> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
>>> =A0 =A0 =A0 =A0.cm_inst =A0 =A0 =A0 =A0 =A0=3D OMAP4430_PRM_EMU_CM_=
INST,
>>> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_PRM_EMU_CM_EMU_=
CDOFFS,
>>> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP,
>>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_SWSUP,
>>> =A0};
>> NAK.
>>
>> You don't need this patch. What you saw on CAMERA was indeed
>> a known bug but emulation domain has no such issues.
>>
>> So the accesses to emulation register should continue to work
>> with the clock-domain being kept under hardware supervision.
>
> But why can this patch make omap4 pmu work? =A0Without the patch,
> there are no CTI interrupts generated for pmu irq.
>
Interesting. For me debugger works which also relies on Emulation domai=
n.

Need to see why CTI is behaving like this.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
