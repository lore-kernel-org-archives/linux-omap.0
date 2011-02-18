From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP fixups
Date: Fri, 18 Feb 2011 17:52:54 +0000
Message-ID: <AANLkTina+bHd=dJRjfASci=GU3fAWbk2OGb6pU8rx67D@mail.gmail.com>
References: <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
	<AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
	<20110210191125.GA12582@n2100.arm.linux.org.uk>
	<AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
	<20110211101345.GA23785@n2100.arm.linux.org.uk>
	<AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com>
	<20110211160500.GA31529@n2100.arm.linux.org.uk>
	<AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
	<20110211163247.GB31529@n2100.arm.linux.org.uk>
	<20110216163543.GA27480@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56229 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1BRRxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:53:21 -0500
Received: by wwa36 with SMTP id 36so4017616wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 09:53:20 -0800 (PST)
In-Reply-To: <20110216163543.GA27480@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Wed, Feb 16, 2011 at 4:35 PM, Dave Martin <dave.martin@linaro.org> w=
rote:
> Hi,
>
> On Fri, Feb 11, 2011 at 04:32:47PM +0000, Russell King - ARM Linux wr=
ote:
>
> [...]
>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux=
=2Elds.S
>> index 45b5651..343d29f 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -21,6 +21,12 @@
>> =A0#define ARM_CPU_KEEP(x)
>> =A0#endif
>>
>> +#if defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)
>> +#define ARM_EXIT_KEEP(x) =A0 =A0 x
>> +#else
>> +#define ARM_EXIT_KEEP(x)
>> +#endif
>> +
>> =A0OUTPUT_ARCH(arm)
>> =A0ENTRY(stext)
>>
>> @@ -43,6 +49,7 @@ SECTIONS
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _sinittext =3D .;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HEAD_TEXT
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_TEXT
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARM_EXIT_KEEP(EXIT_TEXT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _einittext =3D .;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARM_CPU_DISCARD(PROC_INFO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __arch_info_begin =3D .;
>> @@ -71,6 +78,7 @@ SECTIONS
>> =A0#ifndef CONFIG_XIP_KERNEL
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __init_begin =3D _stext;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_DATA
>> + =A0 =A0 =A0 =A0 =A0 =A0 ARM_EXIT_KEEP(EXIT_DATA)
>> =A0#endif
>> =A0 =A0 =A0 }
>>
>> @@ -166,6 +174,7 @@ SECTIONS
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 . =3D ALIGN(PAGE_SIZE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __init_begin =3D .;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_DATA
>> + =A0 =A0 =A0 =A0 =A0 =A0 ARM_EXIT_KEEP(EXIT_DATA)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 . =3D ALIGN(PAGE_SIZE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __init_end =3D .;
>> =A0#endif
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> This works for me in a case known to fail without the patch.
>
> Tested-by: Dave Martin <dave.martin@linaro.org>
>
> I still don't quite understand the intricacies of how vmlinux
> is laid out, but the patch looks sensible.
>
> Do you need anything more from me on this? =A0If not, I will
> throw away my patch and replace it with yours.

Are you still intending to merge your patch here?  I don't see it
anywhere yet, but I would like to get rid of my hack (which is rather
messy).

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
