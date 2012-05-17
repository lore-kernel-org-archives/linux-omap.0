From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX gic control register change
Date: Thu, 17 May 2012 12:16:31 +0530
Message-ID: <CAMQu2gxKmeEnZr8PHZjuC_PUUzjbn7gDkG5NDKM6h2kuS+aJVQ@mail.gmail.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
 <1336989796-26594-4-git-send-email-t-kristo@ti.com> <87zk99ce5q.fsf@ti.com>
 <4FB3707B.2080200@ti.com> <4FB39C5A.5080404@ti.com> <87mx586pci.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:42327 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758215Ab2EQGqy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 02:46:54 -0400
Received: by qcsk26 with SMTP id k26so1122434qcs.12
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 23:46:52 -0700 (PDT)
In-Reply-To: <87mx586pci.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, May 16, 2012 at 10:21 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> Kevin,
>>
>> On Wednesday 16 May 2012 02:46 PM, Santosh Shilimkar wrote:
>>> On Wednesday 16 May 2012 03:14 AM, Kevin Hilman wrote:
>>>> Santosh,
>>>>
>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>
>>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>
>>>>> GIC distributor control register has changed between CortexA9 r1p=
X and
>>>>> r2pX. The Control Register secure banked version is now composed =
of 2
>>>>> bits:
>>>>> =A0 =A0 =A0bit 0 =3D=3D Secure Enable
>>>>> =A0 =A0 =A0bit 1 =3D=3D Non-Secure Enable
>>>>> The Non-Secure banked register has not changed.
>>>>
>>>> For those without the r1pX TRM handy, please include what this loo=
k like
>>>> before (presumably 1 bit?) =A0The changelog and in-code comments s=
hould
>>>> both be enhanced.
>>>>
>>> You are right. There was only one bit previously which was used for
>>> secure/non-secure mode. So ROM over-writes the non-secure bit
>>> accidentally.
>>>
>>>>> Since the ROM Code is based on the r1pX GIC, the CPU1 GIC restora=
tion
>>>>> will cause a problem to CPU0 Non-Secure SW.
>>>>
>>>> Please describe the problem, so we can better understand the speci=
fics
>>>> of the workaround.
>>>>
>> Below is the updated changelog.
>
> Much better, thanks. =A0But it still took me several reads to fully
> understand. =A0Maybe it's because the cold I have is stuffing up my h=
ead,
> so it takes me awhile to understand... =A0Anyways, some minor comment=
s to
> help clarify...
>
> Sorry to be so picky about changelogs, but this is a really nasty bug=
,
> and the workaround has some rather important side effects, so I want =
the
> description of the bug and the workaround to be well described.
>
>> --------------
>> ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic contro=
l
>> register change
>>
>> With MPUSS programmed to OSWR(Open Switch retention), GIC context is
>> lost. On the CPU wakeup paths, ROM code gets executed which will set=
up
>> GIC secure configurations and restore the GIC context if it was save=
d
>> based on SAR_BACKUP_STATUS.
>>
>> The ROM Code GIC distributor restoration is split in two parts:
>> CPU specific register done by each CPU and common register done by
>> only one CPU. If the GIC Distributor Control Register =3D 1, the
>> second CPU will not do the common GIC restoration.
>
> s/second CPU/second CPU to wake up/
>
ok
>> GIC distributor control register has changed between CortexA9 r1pX a=
nd
>> r2pX. The Control Register secure banked version is now composed of =
2
>> bits vs only one bit before r1px:
>
> before r1pX?
I mean r1px, r0px etc.

>
>> =A0 =A0 =A0bit 0 =3D=3D Secure Enable
>> =A0 =A0 =A0bit 1 =3D=3D Non-Secure Enable
>
> And what did this look like for r1pX? =A0 =A0Presumably bit0 was non-=
secure
> enable?
>
Yes. Same bit is used. It's banked bit which has secure and non-secure =
view.

>> Hence the value of Control register will be 3 and not 1 as the r1pX
>> based ROM code expects.
>
> Why will it be 3?
>
> Will it be 3 on GP devices?
>
Yes. Because you have 2 bits. Since both bits will be set [ Bit 1 will
be set by ROM code]
and bit 0 will be set by Linux.

>> So he CPU1 on it's wakeup ROM code path, will
>
> s/it's/its/
>
ok
>> go to the GIC initialization procedure and will so reset the full GI=
C
>> and NS GIC distributor Enable bit will get cleared.
>
> This is where it's confusing.
>
Hmm.

> On r2pX, NS enable bit is bit 1. =A0It's not mentioned here, but I'm
> assuming that it's bit 0 on r1pX, right? (I can't seem to find an r1p=
X
> TRM)
>
Yes. As I mentioned earlier, will make that more clear.

> Since ROM code is r1pX-based, I would assume that it would continue t=
o
> clear bit 0, which is only now the secure enable bit?
>
> Or, is it the case that ROM code clears all the bits? =A0That should =
be described.
>
ROM code reads the register value and compares it with value =3D=3D 1
" If the GIC Distributor Control Register =3D 1, the
second CPU will not do the common GIC restoration"
On r2Px, the value becomes 3 and entire ROM code logic goofs up
and take wrong code path.

>> Since the GIC distributor gets disabled in a live system, CPU1 will
>> hang because the interrupts stop firing.
>> =A0 =A0 =A01) Before doing the CPU1 wakeup, CPU0 must disable
>> =A0 =A0 =A0 =A0 the GIC distributor and wait for it to be enabled.
>
> what does 'disable GIC distributor' mean. =A0secure? non-secure? both=
?
>
HLOS is a non-secure view so it can disable only non-secure bit.

>> =A0 =A0 =A02) CPU1 must re-enable the GIC distributor on
>> =A0 =A0 =A0 =A0 it's wakeup path.
>
> Describe why this works. =A0e.g. because it cause ROM code to skip it=
s
> broken restore path.
>
ROM code logic find the control register value 1 because bit 1 is
cleared by non-secure SW during the check.

>> With this procedure, the GIC configuration done between the
>> CPU0 wakeup and CPU1 wakeup will not be lost but during this
>> short windows, the CPU0 will not receive interrupts.
>>
>> The BUG is applicable to only OMAP4460(r2pX) devices.
>> OMAP4470(r2Px), ROM code is fixed for this BUG.
>
> OMAP4470 (also r2pX) is not affected by this bug because ROM code has
> been fixed.
>
Ok

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
