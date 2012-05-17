From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic control register change
Date: Thu, 17 May 2012 10:15:57 -0700
Message-ID: <87txzeybhu.fsf@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	<1336989796-26594-4-git-send-email-t-kristo@ti.com>
	<87zk99ce5q.fsf@ti.com> <4FB3707B.2080200@ti.com>
	<4FB39C5A.5080404@ti.com> <87mx586pci.fsf@ti.com>
	<CAMQu2gxKmeEnZr8PHZjuC_PUUzjbn7gDkG5NDKM6h2kuS+aJVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:40273 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753257Ab2EQRQA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 13:16:00 -0400
Received: by dakp5 with SMTP id p5so2591991dak.28
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 10:15:59 -0700 (PDT)
In-Reply-To: <CAMQu2gxKmeEnZr8PHZjuC_PUUzjbn7gDkG5NDKM6h2kuS+aJVQ@mail.gmail.com>
	(Santosh Shilimkar's message of "Thu, 17 May 2012 12:16:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Wed, May 16, 2012 at 10:21 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> Kevin,
>>>
>>> On Wednesday 16 May 2012 02:46 PM, Santosh Shilimkar wrote:
>>>> On Wednesday 16 May 2012 03:14 AM, Kevin Hilman wrote:
>>>>> Santosh,
>>>>>
>>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>>
>>>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>>
>>>>>> GIC distributor control register has changed between CortexA9 r1=
pX and
>>>>>> r2pX. The Control Register secure banked version is now composed=
 of 2
>>>>>> bits:
>>>>>> =C2=A0 =C2=A0 =C2=A0bit 0 =3D=3D Secure Enable
>>>>>> =C2=A0 =C2=A0 =C2=A0bit 1 =3D=3D Non-Secure Enable
>>>>>> The Non-Secure banked register has not changed.
>>>>>
>>>>> For those without the r1pX TRM handy, please include what this lo=
ok like
>>>>> before (presumably 1 bit?) =C2=A0The changelog and in-code commen=
ts should
>>>>> both be enhanced.
>>>>>
>>>> You are right. There was only one bit previously which was used fo=
r
>>>> secure/non-secure mode. So ROM over-writes the non-secure bit
>>>> accidentally.
>>>>
>>>>>> Since the ROM Code is based on the r1pX GIC, the CPU1 GIC restor=
ation
>>>>>> will cause a problem to CPU0 Non-Secure SW.
>>>>>
>>>>> Please describe the problem, so we can better understand the spec=
ifics
>>>>> of the workaround.
>>>>>
>>> Below is the updated changelog.
>>
>> Much better, thanks. =C2=A0But it still took me several reads to ful=
ly
>> understand. =C2=A0Maybe it's because the cold I have is stuffing up =
my head,
>> so it takes me awhile to understand... =C2=A0Anyways, some minor com=
ments to
>> help clarify...
>>
>> Sorry to be so picky about changelogs, but this is a really nasty bu=
g,
>> and the workaround has some rather important side effects, so I want=
 the
>> description of the bug and the workaround to be well described.
>>
>>> --------------
>>> ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic contr=
ol
>>> register change
>>>
>>> With MPUSS programmed to OSWR(Open Switch retention), GIC context i=
s
>>> lost. On the CPU wakeup paths, ROM code gets executed which will se=
tup
>>> GIC secure configurations and restore the GIC context if it was sav=
ed
>>> based on SAR_BACKUP_STATUS.
>>>
>>> The ROM Code GIC distributor restoration is split in two parts:
>>> CPU specific register done by each CPU and common register done by
>>> only one CPU. If the GIC Distributor Control Register =3D 1, the
>>> second CPU will not do the common GIC restoration.
>>
>> s/second CPU/second CPU to wake up/
>>
> ok
>>> GIC distributor control register has changed between CortexA9 r1pX =
and
>>> r2pX. The Control Register secure banked version is now composed of=
 2
>>> bits vs only one bit before r1px:
>>
>> before r1pX?
> I mean r1px, r0px etc.
>>
>>> =C2=A0 =C2=A0 =C2=A0bit 0 =3D=3D Secure Enable
>>> =C2=A0 =C2=A0 =C2=A0bit 1 =3D=3D Non-Secure Enable
>>
>> And what did this look like for r1pX? =C2=A0 =C2=A0Presumably bit0 w=
as non-secure
>> enable?
>>
> Yes. Same bit is used. It's banked bit which has secure and non-secur=
e view.
>
>>> Hence the value of Control register will be 3 and not 1 as the r1pX
>>> based ROM code expects.
>>
>> Why will it be 3?
>>
>> Will it be 3 on GP devices?
>>
> Yes. Because you have 2 bits. Since both bits will be set [ Bit 1 wil=
l
> be set by ROM code]
> and bit 0 will be set by Linux.

Why will the secure enable bit be set on GP devices?

>>> So he CPU1 on it's wakeup ROM code path, will
>>
>> s/it's/its/
>>
> ok
>>> go to the GIC initialization procedure and will so reset the full G=
IC
>>> and NS GIC distributor Enable bit will get cleared.
>>
>> This is where it's confusing.
>>
> Hmm.
>
>> On r2pX, NS enable bit is bit 1. =C2=A0It's not mentioned here, but =
I'm
>> assuming that it's bit 0 on r1pX, right? (I can't seem to find an r1=
pX
>> TRM)
>>
> Yes. As I mentioned earlier, will make that more clear.
>
>> Since ROM code is r1pX-based, I would assume that it would continue =
to
>> clear bit 0, which is only now the secure enable bit?
>>
>> Or, is it the case that ROM code clears all the bits? =C2=A0That sho=
uld be described.
>>
> ROM code reads the register value and compares it with value =3D=3D 1
> " If the GIC Distributor Control Register =3D 1, the
> second CPU will not do the common GIC restoration"
> On r2Px, the value becomes 3 and entire ROM code logic goofs up
> and take wrong code path.

That part is clear. =20

What's not at all clear is what the ROM code does *after* this.  Does i=
t
clear both bits?  or just bit 0?  Since it's r1pX based, I would expect
that it doesn't touch anything other than bit 0.

>>> Since the GIC distributor gets disabled in a live system, CPU1 will
>>> hang because the interrupts stop firing.
>>> =C2=A0 =C2=A0 =C2=A01) Before doing the CPU1 wakeup, CPU0 must disa=
ble
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 the GIC distributor and wait for it to =
be enabled.
>>
>> what does 'disable GIC distributor' mean. =C2=A0secure? non-secure? =
both?
>>
> HLOS is a non-secure view so it can disable only non-secure bit.

The changelog is not talking about the HLOS, it's talking about the ROM
code, which presumably can set/clear both bits.

>>> =C2=A0 =C2=A0 =C2=A02) CPU1 must re-enable the GIC distributor on
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 it's wakeup path.
>>
>> Describe why this works. =C2=A0e.g. because it cause ROM code to ski=
p its
>> broken restore path.
>>
> ROM code logic find the control register value 1 because bit 1 is
> cleared by non-secure SW during the check.

and because it finds the control regster value to be 1...

Santosh, I do understand what is happening here.  But I play dumb so
that it will be described in great detail in the changelog so that when
I forget (and you forget) we can go back to this and get a quick
understanding of both the bug and the workaround.

Since you are very deeply familiar with this bug, it's understandably
hard to write this changelog since most things probably seem obvious to
you.  A suggestion would be to have a few colleagues that are not
familiar with this bug read the changelog and try and describe it back
to you.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
