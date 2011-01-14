From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Fri, 14 Jan 2011 17:13:01 +0100
Message-ID: <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56384 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab1ANQNC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 11:13:02 -0500
Received: by qwa26 with SMTP id 26so2871920qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 08:13:01 -0800 (PST)
In-Reply-To: <20110114155806.GA22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 4:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 04:21:10PM +0100, jean.pihet@newoldbits.com w=
rote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The new fncpy API is better suited for copying some
>> code to SRAM at runtime. This patch changes the ad-hoc
>> code to the more generic fncpy API.
>>
>> Tested OK on OMAP3 in low power modes (RET/OFF)
>> with !CONFIG_THUMB2_KERNEL
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/plat-omap/sram.c | =A0 =A07 +++----
>> =A01 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> index e26e504..e2982b0 100644
>> --- a/arch/arm/plat-omap/sram.c
>> +++ b/arch/arm/plat-omap/sram.c
>> @@ -23,7 +23,7 @@
>>
>> =A0#include <asm/tlb.h>
>> =A0#include <asm/cacheflush.h>
>> -
>> +#include <asm/fncpy.h>
>> =A0#include <asm/mach/map.h>
>>
>> =A0#include <plat/sram.h>
>> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned lon=
g size)
>>
>> =A0 =A0 =A0 omap_sram_ceil -=3D size;
>> =A0 =A0 =A0 omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(voi=
d *));
>> - =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
>> - =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil,
>> - =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(omap_sram_ceil + size));
>> +
>> + =A0 =A0 fncpy((void *)omap_sram_ceil, start, size);
>>
>> =A0 =A0 =A0 return (void *)omap_sram_ceil;
>
> That's actually wrong usage, as you won't get the T bit set if the or=
iginal
> function had it.
Oops ok got it.

>
> The right solution to this is to change omap_sram_push() to become ju=
st an
> allocator, and then use fncpy() outside of that.
>
> So:
>
> extern int my_func_size;
> extern void my_func(int blah);
> void (*sram_my_func)(int);
>
> =A0 =A0 =A0 =A0void *sram =3D omap_sram_push(my_func_size);
> =A0 =A0 =A0 =A0if (sram)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sram_my_func =3D fncpy(sram, my_func, =
my_func_size);
Is the name 'omap_sram_push' wrong then?
What about the following?
@@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long s=
ize)

       omap_sram_ceil -=3D size;
       omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(void *));
 -     memcpy((void *)omap_sram_ceil, start, size);
 -     flush_icache_range((unsigned long)omap_sram_ceil,
 -             (unsigned long)(omap_sram_ceil + size));

 -     return (void *)omap_sram_ceil;
 +    return fncpy((void *)omap_sram_ceil, start, size);

> Two benefits: 1. you get the thumb mode bit propagated (which is the
> point of fncpy), and 2. you get the security of type safety between
> my_func and the sram function pointer.
>
> If you cast things to a void pointer and ignore the return value of f=
ncpy
> then you lose the whole point of this API _and_ any form of type safe=
ty.
>

Thanks for reviewing the patch.

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
