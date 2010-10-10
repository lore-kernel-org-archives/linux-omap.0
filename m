From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] arm: mm: allow boards to fiddle with meminfo
Date: Sun, 10 Oct 2010 22:37:51 +0300
Message-ID: <AANLkTikoub1K3HOP=bs0moCk1vYD8gPEu7DCvrUnMATi@mail.gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-2-git-send-email-felipe.contreras@gmail.com>
	<20101010190308.GA15906@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58047 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab0JJThw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 15:37:52 -0400
Received: by bwz15 with SMTP id 15so1307442bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 12:37:51 -0700 (PDT)
In-Reply-To: <20101010190308.GA15906@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Sun, Oct 10, 2010 at 10:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 10, 2010 at 08:40:38PM +0300, Felipe Contreras wrote:
>> So that they can reserve some memory.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0arch/arm/include/asm/mach/arch.h | =C2=A0 =C2=A02 +-
>> =C2=A0arch/arm/mm/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A07 ++++---
>> =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm=
/mach/arch.h
>> index 8a0dd18..408e4d5 100644
>> --- a/arch/arm/include/asm/mach/arch.h
>> +++ b/arch/arm/include/asm/mach/arch.h
>> @@ -38,7 +38,7 @@ struct machine_desc {
>> =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(*fixup)(struct machine_desc *,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct tag *, char **,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct meminfo *);
>> - =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(*reserve)(void);/* reserve mem blocks =C2=A0*/
>> + =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(*reserve)(struct meminfo *);/* reserve mem blocks=
 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(*map_io)(void);/* IO mapping function =C2=A0=
*/
>> =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(*init_irq)(void);
>> =C2=A0 =C2=A0 =C2=A0 struct sys_timer =C2=A0 =C2=A0 =C2=A0 =C2=A0*ti=
mer; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* system tick timer =C2=A0 =C2=A0*/
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 7185b00..4b5c117 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -272,8 +272,6 @@ void __init arm_memblock_init(struct meminfo *mi=
, struct machine_desc *mdesc)
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> =C2=A0 =C2=A0 =C2=A0 memblock_init();
>> - =C2=A0 =C2=A0 for (i =3D 0; i < mi->nr_banks; i++)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_add(mi->bank[i]=
=2Estart, mi->bank[i].size);
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Register the kernel text, kernel data and in=
itrd with memblock. */
>> =C2=A0#ifdef CONFIG_XIP_KERNEL
>> @@ -295,7 +293,10 @@ void __init arm_memblock_init(struct meminfo *m=
i, struct machine_desc *mdesc)
>>
>> =C2=A0 =C2=A0 =C2=A0 /* reserve any platform specific memblock areas=
 */
>> =C2=A0 =C2=A0 =C2=A0 if (mdesc->reserve)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdesc->reserve();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdesc->reserve(mi);
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < mi->nr_banks; i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_add(mi->bank[i]=
=2Estart, mi->bank[i].size);
>
> It is not a good idea to change the ordering here, as we'll now be
> adding the memory blocks _after_ we've started to make reservations
> into memblock.
>
> At least the omapfb code wants there to be memory present in memblock
> when ->reserve is called.

True. I initially added a new callback called reserve_mem(), but I
thought it would be nicer to avoid adding a new function almost
identical to an existing one.

Anyway, what is your suggestion? Can you come up with something else?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
