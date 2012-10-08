From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP
 mode
Date: Mon, 08 Oct 2012 12:33:03 +0100
Message-ID: <5072B9EF.1020005@arm.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com> <1347036934-8519-3-git-send-email-marc.zyngier@arm.com> <20121005200822.GQ3874@atomide.com> <6d3553bfe8a2d1ac88cab852100616a7@localhost> <20121006160031.GC3874@atomide.com> <20121008110109.GE2302@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050409000609010401030803"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52638 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab2JHLdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 07:33:11 -0400
In-Reply-To: <20121008110109.GE2302@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>

This is a multi-part message in MIME format.
--------------050409000609010401030803
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

On 08/10/12 12:01, Dave Martin wrote:
> On Sat, Oct 06, 2012 at 09:00:32AM -0700, Tony Lindgren wrote:
>> * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
>>>
>>> If so, that indicates some side effect of the safe_svcmode_maskall macr=
o,
>>> and I suspect the "movs pc, lr" bit.
>>>
>>> Can you try the attached patch? It basically falls back to the previous
>>> behaviour if not entered in HYP mode.
>> ...
>>
>>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/as=
sembler.h
>>> index 658a15d..b21b97f 100644
>>> --- a/arch/arm/include/asm/assembler.h
>>> +++ b/arch/arm/include/asm/assembler.h
>>> @@ -254,16 +254,17 @@
>>>  =09mov=09lr , \reg
>>>  =09and=09lr , lr , #MODE_MASK
>>>  =09cmp=09lr , #HYP_MODE
>>> -=09orr=09\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
>>> +=09orr=09\reg , \reg , #PSR_I_BIT | PSR_F_BIT
>>>  =09bic=09\reg , \reg , #MODE_MASK
>>>  =09orr=09\reg , \reg , #SVC_MODE
>>>  THUMB(=09orr=09\reg , \reg , #PSR_T_BIT=09)
>>> -=09msr=09spsr_cxsf, \reg
>>> -=09adr=09lr, BSYM(2f)
>>>  =09bne=091f
>>> +=09orr=09\reg, \reg, #PSR_A_BIT
>>> +=09adr=09lr, BSYM(2f)
>>> +=09msr=09spsr_cxsf, \reg
>>>  =09__MSR_ELR_HYP(14)
>>>  =09__ERET
>>> -1:=09movs=09pc, lr
>>> +1:=09msr=09cpsr_c, \reg
>>>  2:
>>>  .endm
>>> =20
>>
>> The minimal version of this that still boots on my n800 is just
>> the last change of the above patch:
>>
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -263,7 +263,7 @@ THUMB(=09orr=09\reg , \reg , #PSR_T_BIT=09)
>>  =09bne=091f
>>  =09__MSR_ELR_HYP(14)
>>  =09__ERET
>> -1:=09movs=09pc, lr
>> +1:=09msr=09cpsr_c, \reg
>>  2:
>>  .endm
>> =20
>=20
> In an attempt to narrow this down...
>=20
> Can you follow this (i.e., _after_ a known successful switch to SVC mode)
>=20
> (a)
> =09mrs=09\reg, cpsr
> =09msr=09spsr_cxsf, \reg
> =09adr=09\reg, 3f
> =09movs=09pc, lr
> 3:
>=20
> and (b)
>=20
> =09mrs=09\reg, cpsr
> =09orr=09\reg, \reg, #CPSR_A_BIT
> =09msr=09cpsr_cxsf, \reg
>=20
> and (c)
>=20
> =09mrs=09\reg, cpsr
> =09orr=09\reg, \reg, #CPSR_A_BIT
> =09msr=09spsr_cxsf, \reg
> =09adr=09\reg, 3f
> =09movs=09pc, lr
> 3:
>=20
>=20
>=20
>=20
> If only (a) works, this would suggest that the attempt to set the A bit
> is causing the problem.
>=20
> If only (b) works, this suggests that the A bit is OK but that some
> invalid hardware state, or something else we don't understand, is causing
> exception returns to fail in general.
>=20
> If (a) and (b) work but (c) fails, this suggests that specifically
> trying to set the A bit via an exception return is problematic.
>=20
> If all of them work then this suggests some invalid hardware state or
> something else we don't understand, but which is cleared by the initial
> msr cpsr_c which clobbers the processor mode.

Playing with an Integrator-CP with a 1136 tile, the only way I could
cause the thing to fail was to boot the thing in SYSTEM mode.

Tony, can you possibly also try the attached patch?

Thanks,

=09M.
--=20
Jazz is not dead. It just smells funny...
--------------050409000609010401030803
Content-Type: text/x-diff; name=sysmode.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="sysmode.patch"

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assemb=
ler.h
index 683a1e6..7714ec7 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -253,6 +253,8 @@
 =09mrs=09\reg , cpsr
 =09mov=09lr , \reg
 =09and=09lr , lr , #MODE_MASK
+=09cmp=09lr , #SYSTEM_MODE=09/* Yet another braindead platform? */
+=09beq=09omgsys
 =09cmp=09lr , #HYP_MODE
 =09orr=09\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
 =09bic=09\reg , \reg , #MODE_MASK
@@ -264,6 +266,7 @@ THUMB(=09orr=09\reg , \reg , #PSR_T_BIT=09)
 =09__MSR_ELR_HYP(14)
 =09__ERET
 1:=09movs=09pc, lr
+omgsys: msr=09cpsr_c, \reg
 2:
 .endm
=20
--------------050409000609010401030803--

