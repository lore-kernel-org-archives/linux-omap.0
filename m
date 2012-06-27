From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: DM3730 without PMIC oops on idle
Date: Wed, 27 Jun 2012 14:53:46 +0200
Message-ID: <CAGGh5h0fXMKQ-gX958BwH+RTsYgOROdmqMYXuCQq3XKBMKLR3Q@mail.gmail.com>
References: <CAGGh5h2PEpcZc-BRVb9UJD0VKLFBAktQ0r08T-0XAovZ1W7MZw@mail.gmail.com>
	<87ehp1tq8w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f42.google.com ([209.85.213.42]:41554 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2F0Mxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:53:47 -0400
Received: by yhfq11 with SMTP id q11so1009770yhf.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 05:53:47 -0700 (PDT)
In-Reply-To: <87ehp1tq8w.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin, thank you for your help.

2012/6/27 Kevin Hilman <khilman@ti.com>:
> jean-philippe francois <jp.francois@cynove.com> writes:
>
>> Hi,
>>
>> My board does not have any Power Management IC.
>> Without the following patch, the bood ends with an oops.
>> How can I further debug this, ie trace through the assembly
>> in arch/arm/mach-omap2/sleep34xx.S ?
>
> The assembly code that is faulting has nothing to do with interaction
> with the PMIC.
>
> Some more comments below ...
>
>> --
>> Patch needed to boot to userspace :
>>
>> Index: linux-3.4.3/arch/arm/mach-omap2/pm34xx.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-3.4.3.orig/arch/arm/mach-omap2/pm34xx.c =A0 =A0 2012-06-17
>> 20:21:44.000000000 +0200
>> +++ linux-3.4.3/arch/arm/mach-omap2/pm34xx.c =A02012-06-22 16:26:38.=
000000000 +0200
>> @@ -403,7 +403,7 @@
>> =A0 =A0 =A0 trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> =A0 =A0 =A0 trace_cpu_idle(1, smp_processor_id());
>>
>> - =A0 =A0 omap_sram_idle();
>> + =A0 =A0 // =A0 =A0 =A0omap_sram_idle();
>
> FYI... you can get the same effect without patching the kernel by add=
ing
> 'nohlt' to the kernel command line. =A0That avoids entering the idle =
loop
> alltogether.
>

Good to know :)

>> clock: disabling unused clocks to save power
>> Unable to handle kernel NULL pointer dereference at virtual address =
00000000
>> pgd =3D c0004000
>> [00000000] *pgd=3D00000000
>> Internal error: Oops: 80000005 [#1] PREEMPT ARM
>> Modules linked in:
>> CPU: 0 =A0 =A0Tainted: G =A0 =A0 =A0 =A0W =A0 =A0 (3.4.3 #2)
>> PC is at 0x0
>> LR is at omap34xx_do_sram_idle+0x8/0x10
>
> This is a branch to 0x0, probably in omap34xx_cpu_suspend (in
> sleep34xx.S) which was just called by omap34xx_do_sram_idle.
>
> My first guess would be that the omap3_do_wfi_sram address is zero. =A0=
Can
> you dump the value in omap_push_sram_idle()? =A0If that looks good, d=
o you
> have a debugger setup so you can single step into omap34xx_cpu_suspen=
d()
> to find out where this is failing?
>
Thank you for pointing me in the right direction.
My board code was not calling omap_sdrc_init(...),
which in turns calls omap_sram_init, where all
the sram pushing takes place.

Now I safely boot to userspace, but have random crashes
when waking up from idle, where random refers to the oops
log, not the occurence. I suspect memory corruption problem,
which could be due to ddr going into self refresh, right ?

Currently I call omap_sdrc_init with NULL arguments, but a lot of
boards do the same thing. How are the omap_sdrc_init args related to
self refreh ? In other words, if ddr parameters are correctly set in x-=
loader,
do I also need omap_sdrc_params in linux for idle to work ?

Regards,
Jean-Philippe Fran=E7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
