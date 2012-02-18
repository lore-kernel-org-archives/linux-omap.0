From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Sat, 18 Feb 2012 10:08:09 +0530
Message-ID: <CAMQu2gw7uJGnA3sa33GCnyU=aWcK1xCW1HEoML9zZctjy+11gQ@mail.gmail.com>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com>
 <0401fed02a58f7bc48cc274050adbac7@localhost> <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
 <4F3E34A3.4000307@arm.com> <4F3E47F2.2090400@ti.com> <87fwe9b8hp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49623 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741Ab2BREia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 23:38:30 -0500
Received: by mail-qw0-f45.google.com with SMTP id g40so1509688qab.4
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 20:38:29 -0800 (PST)
In-Reply-To: <87fwe9b8hp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Feb 18, 2012 at 12:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> On Friday 17 February 2012 04:36 PM, Marc Zyngier wrote:
>>> On 17/02/12 10:40, Shilimkar, Santosh wrote:
>>>> On Fri, Feb 17, 2012 at 3:17 PM, Marc Zyngier <marc.zyngier@arm.co=
m> wrote:
>>>>>
>>>>> Hi Santosh,
>>>>>
>>>>> On Fri, 17 Feb 2012 13:18:37 +0530, Santosh Shilimkar
>>>>> <santosh.shilimkar@ti.com> wrote:
>>>>>>
>>>>
>>
>> [..]
>>
>>>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>>>> index 4285daa..265a18a 100644
>>>> --- a/arch/arm/kernel/smp_twd.c
>>>> +++ b/arch/arm/kernel/smp_twd.c
>>>> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb =3D=
 {
>>>>
>>>> =A0static int twd_cpufreq_init(void)
>>>> =A0{
>>>> - =A0 if (!IS_ERR(twd_clk))
>>>> + =A0 if ((!twd_evt) && (!__this_cpu_ptr(twd_evt)) && (!IS_ERR(twd=
_clk)))
>>>
>>> Erm... Shouldn't that rather be:
>>> =A0 =A0 =A0if (twd_evt && *__this_cpu_ptr(twd_evt) && !IS_ERR(twd_c=
lk))
>>>
>> My bad. You are right. Updated patch below.
>> Tested on OMAP3430 SDP with CPUFREQ enabled.
>>
>> Regards
>> Santosh
>>
>> From f58c515a9d1a2c729c05a726d5176843381952ae Mon Sep 17 00:00:00 20=
01
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Fri, 17 Feb 2012 11:11:28 +0530
>> Subject: [PATCH] ARM: smp_twd: Don't register CPUFREQ notifiers if l=
ocal
>> timers are not initialised.
>>
>> Current ARM local timer code registers CPUFREQ notifiers even in cas=
e
>> the twd_timer_setup() isn't called. That seems to be wrong and
>> would eventually lead to kernel crash on the CPU frequency transitio=
ns
>> on the SOCs where the local timer doesn't exist or broken because of
>> hardware BUG. Fix it by testing twd_evt and *__this_cpu_ptr(twd_evt)=
=2E
>>
>> The issue was observed with v3.3-rc3 and building an OMAP2+ kernel
>> on OMAP3 SOC which doesn't have TWD.
>>
>> Below is the dump for reference :
>>
>> =A0Unable to handle kernel paging request at virtual address 007e900
>> =A0pgd =3D cdc20000
>> =A0[007e9000] *pgd=3D00000000
>> =A0Internal error: Oops: 5 [#1] SMP
>> =A0Modules linked in:
>> =A0CPU: 0 =A0 =A0Not tainted =A0(3.3.0-rc3-pm+debug+initramfs #9)
>> =A0PC is at twd_update_frequency+0x34/0x48
>> =A0LR is at twd_update_frequency+0x10/0x48
>> =A0pc : [<c001382c>] =A0 =A0lr : [<c0013808>] =A0 =A0psr: 60000093
>> =A0sp : ce311dd8 =A0ip : 00000000 =A0fp : 00000000
>> =A0r10: 00000000 =A0r9 : 00000001 =A0r8 : ce310000
>> =A0r7 : c0440458 =A0r6 : c00137f8 =A0r5 : 00000000 =A0r4 : c0947a74
>> =A0r3 : 00000000 =A0r2 : 007e9000 =A0r1 : 00000000 =A0r0 : 00000000
>> =A0Flags: nZCv =A0IRQs off =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0S=
egment usr
>> =A0Control: 10c5387d =A0Table: 8dc20019 =A0DAC: 00000015
>> =A0Process sh (pid: 599, stack limit =3D 0xce3102f8)
>> =A0Stack: (0xce311dd8 to 0xce312000)
>> =A01dc0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6000c
>> =A01de0: 00000001 00000002 00000000 00000000 00000000 00000000 00000
>> =A01e00: ffffffff c093d8f0 00000000 ce311ebc 00000001 00000001 ce310
>> =A01e20: c001386c c0437c4c c0e95b60 c0e95ba8 00000001 c0e95bf8 ffff4
>> =A01e40: 00000000 00000000 c005ef74 ce310000 c0435cf0 ce311ebc 00000
>> =A01e60: ce352b40 0007a120 c08d5108 c08ba040 c08ba040 c005f030 00000
>> =A01e80: c08bc554 c032fe2c 0007a120 c08d4b64 ce352b40 c08d8618 ffff8
>> =A01ea0: c08ba040 c033364c ce311ecc c0433b50 00000002 ffffffea c0330
>> =A01ec0: 0007a120 0007a120 22222201 00000000 22222222 00000000 ce357
>> =A01ee0: ce3d6000 cdc2aed8 ce352ba0 c0470164 00000002 c032f47c 00034
>> =A01f00: c0331cac ce352b40 00000007 c032f6d0 ce352bbc 0003d090 c0930
>> =A01f20: c093d8bc c03306a4 00000007 ce311f80 00000007 cdc2aec0 ce358
>> =A01f40: ce8d20c0 00000007 b6fe5000 ce311f80 00000007 ce310000 0000c
>> =A01f60: c000de74 ce987400 ce8d20c0 b6fe5000 00000000 00000000 0000c
>> =A01f80: 00000000 00000000 001fbac8 00000000 00000007 001fbac8 00004
>> =A01fa0: c000df04 c000dd60 00000007 001fbac8 00000001 b6fe5000 00000
>> =A01fc0: 00000007 001fbac8 00000007 00000004 b6fe5000 00000000 00202
>> =A01fe0: 00000000 beb565f8 00101ffc 00008e8c 60000010 00000001 00000
>> =A0[<c001382c>] (twd_update_frequency+0x34/0x48) from [<c008ac4c>] )
>> =A0[<c008ac4c>] (smp_call_function_single+0x17c/0x1c8) from [<c0013)
>> =A0[<c0013890>] (twd_cpufreq_transition+0x24/0x30) from [<c0437c4c>)
>> =A0[<c0437c4c>] (notifier_call_chain+0x44/0x84) from [<c005efe4>] ()
>> =A0[<c005efe4>] (__srcu_notifier_call_chain+0x70/0xa4) from [<c005f)
>> =A0[<c005f030>] (srcu_notifier_call_chain+0x18/0x20) from [<c032fe2)
>> =A0[<c032fe2c>] (cpufreq_notify_transition+0xc8/0x1b0) from [<c0333)
>> =A0[<c033364c>] (omap_target+0x1b4/0x28c) from [<c032f47c>] (__cpuf)
>> =A0[<c032f47c>] (__cpufreq_driver_target+0x50/0x64) from [<c0331d24)
>> =A0[<c0331d24>] (cpufreq_set+0x78/0x98) from [<c032f6d0>] (store_sc)
>> =A0[<c032f6d0>] (store_scaling_setspeed+0x5c/0x74) from [<c03306a4>)
>> =A0[<c03306a4>] (store+0x58/0x74) from [<c014d868>] (sysfs_write_fi)
>> =A0[<c014d868>] (sysfs_write_file+0x80/0xb4) from [<c00f2c2c>] (vfs)
>> =A0[<c00f2c2c>] (vfs_write+0xa8/0x138) from [<c00f2e9c>] (sys_write)
>> =A0[<c00f2e9c>] (sys_write+0x40/0x6c) from [<c000dd60>] (ret_fast_s)
>> =A0Code: e594300c e792210c e1a01000 e5840004 (e7930002)
>> =A0---[ end trace 5da3b5167c1ecdda ]---
>>
>> Reported-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> CAn you please add to Russell's patch system. =A0This needs to be fix=
ed
> for v3.3-rc.
>
Done .
7328/1 in patch system.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
