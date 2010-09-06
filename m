From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
Date: Mon, 6 Sep 2010 18:17:12 +0800
Message-ID: <AANLkTik2FNBv-72C4L7PxBoMsTENSds-PvbAzxGd-h4y@mail.gmail.com>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43059 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0IFKRN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 06:17:13 -0400
Received: by vws3 with SMTP id 3so3175549vws.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Sep 2010 03:17:12 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>

Tony,

I tried your latest branch: devel-smp-on-unicore, kernel boots up but
got lots of WARN_ON fired:

---
------------[ cut here ]------------
[    1.149719] WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
[    1.149780] Modules linked in:
[    1.149841] [<c01b34c8>] (unwind_backtrace+0x0/0xe4) from
[<c01e939c>] (warn_slowpath_common+0x4c/0x64)
[    1.149902] [<c01e939c>] (warn_slowpath_common+0x4c/0x64) from
[<c01e93cc>] (warn_slowpath_null+0x18/0x1c)
[    1.149993] [<c01e93cc>] (warn_slowpath_null+0x18/0x1c) from
[<c0274730>] (pcpu_alloc+0x2fc/0x888)
[    1.150085] [<c0274730>] (pcpu_alloc+0x2fc/0x888) from [<c0279578>]
(sget+0x198/0x43c)
[    1.150146] [<c0279578>] (sget+0x198/0x43c) from [<c0279adc>]
(get_sb_ns+0x20/0x90)
[    1.150238] [<c0279adc>] (get_sb_ns+0x20/0x90) from [<c02791a4>]
(vfs_kern_mount+0x9c/0x18c)
[    1.150299] [<c02791a4>] (vfs_kern_mount+0x9c/0x18c) from
[<c0022280>] (init_mqueue_fs+0x68/0xc8)
[    1.150390] [<c0022280>] (init_mqueue_fs+0x68/0xc8) from
[<c01ac5d0>] (do_one_initcall+0xcc/0x1a4)
[    1.150451] [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4) from
[<c0008760>] (kernel_init+0x148/0x210)
[    1.150543] [<c0008760>] (kernel_init+0x148/0x210) from
[<c01adcf8>] (kernel_thread_exit+0x0/0x8)
[    1.150604] ---[ end trace 1b75b31a2719ed74 ]---
---

It looks like we still missed to set some flag for chuck.

-Bryan

On Fri, Sep 3, 2010 at 8:09 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Thursday, September 02, 2010 11:13 PM
>> To: Russell King - ARM Linux
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org=
;
>> Bryan Wu; Will Deacon
>> Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for ea=
rly
>> init testing
>>
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
>> > On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
>> >
>> > > --- a/arch/arm/include/asm/smp_plat.h
>> > > +++ b/arch/arm/include/asm/smp_plat.h
>> > > @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(vo=
id)
>> > > =A0#define UP(instr...) =A0 =A0 _str(instr)
>> > > =A0#endif
>> > >
>> > > +static inline int smp_on_up(void)
>> > > +{
>> > > +#ifdef CONFIG_SMP_ON_UP
>> > > + int smp_on_up;
>> > > +
>> > > + asm( =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> > > + =A0 =A0 =A0 =A0 SMP(mov %0, #0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > > + =A0 =A0 =A0 =A0 UP(mov =A0%0, #1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > > + =A0 =A0 =A0 =A0 : "=3Dr" (smp_on_up));
>> > > +
>> > > + return smp_on_up;
>> > > +#else
>> > > + return 0;
>> > > +#endif
>> >
>> > I think this is the wrong approach - rather than a function which =
tells
>> us
>> > just if we are a SMP kernel running on UP, why not something which
>> returns
>> > whether we're running on SMP and use that to eliminate some of the=
se
>> ifdefs?
>>
>> Sure. Will has something like this in his patches:
>>
>> static inline int cpu_is_part_of_mp_system(void)
>> {
>> =A0 =A0 =A0 u32 mpidr;
>> =A0 =A0 =A0 asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=3Dr" (mpidr=
));
>> =A0 =A0 =A0 return (mpidr >> 31) ? !(mpidr >> 30) : 0;
>> }
>
> I guess this register is only available on MP Core extensions.
>
> Regards,
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
