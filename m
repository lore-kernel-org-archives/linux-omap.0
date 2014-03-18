From: Tero Kristo <t-kristo@ti.com>
Subject: Re: pandaboard boot crash with linux-next
Date: Tue, 18 Mar 2014 11:47:09 +0200
Message-ID: <5328161D.5020901@ti.com>
References: <53270218.9050109@ti.com> <53280489.4010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54052 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbaCRJrM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 05:47:12 -0400
In-Reply-To: <53280489.4010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On 03/18/2014 10:32 AM, Peter Ujfalusi wrote:
> On 03/17/2014 04:09 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> I noticed that my omap4 panda does not boot with today's linux-next
>> (8808b950581f71e3ee4cf8e6cae479f4c7106405). I didn't have much time to study
>> it, but I didn't find any posts about the issue with a quick look. Below is
>> the crash.
>
> I did not taken crash log but the same linux-next fails to boot on
> am335x-evmsk as well.

Looks like someone broke gptimer or alternatively some of the DT support 
routines. a call to of_add_property() is causing the crash.

-Tero

>
>>
>>   Tomi
>>
>> [    0.000000] ti_dt_clocks_register: failed to lookup clock node div_ts_ck
>> [    0.000000] ti_dt_clocks_register: failed to lookup clock node bandgap_ts_fclk
>> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000004c
>> [    0.000000] pgd = c0004000
>> [    0.000000] [0000004c] *pgd=00000000
>> [    0.000000] Internal error: Oops: 5 [#1] SMP ARM
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.0-rc6-next-20140317-09382-g8808b950581f #104
>> [    0.000000] task: c088ddf8 ti: c0882000 task.ti: c0882000
>> [    0.000000] PC is at kernfs_find_ns+0x14/0x13c
>> [    0.000000] LR is at kernfs_find_and_get_ns+0x38/0x54
>> [    0.000000] pc : [<c019607c>]    lr : [<c019628c>]    psr: 600001d3
>> [    0.000000] sp : c0883e00  ip : c0883e30  fp : c0883e2c
>> [    0.000000] r10: c0891114  r9 : ebfa11c0  r8 : ebfcd464
>> [    0.000000] r7 : 00000000  r6 : 00000000  r5 : c07c1814  r4 : c08e9ad8
>> [    0.000000] r3 : c08f568c  r2 : 00000000  r1 : c07c1814  r0 : 00000000
>> [    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
>> [    0.000000] Control: 10c5387d  Table: 8000404a  DAC: 00000015
>> [    0.000000] Process swapper/0 (pid: 0, stack limit = 0xc0882248)
>> [    0.000000] Stack: (0xc0883e00 to 0xc0884000)
>> [    0.000000] 3e00: 00000000 c08e9ad8 c07c1814 c08e9ad8 c07c1814 00000000 00000000 ebfcd464
>> [    0.000000] 3e20: c0883e4c c0883e30 c019628c c0196074 c07c1814 00000000 c07c1814 ebfcd490
>> [    0.000000] 3e40: c0883e6c c0883e50 c04c6180 c0196260 c0891140 c07c1814 ebfcd490 00000001
>> [    0.000000] 3e60: c0883e9c c0883e70 c04c7308 c04c6160 c008a208 c008a130 c0883e9c 00000000
>> [    0.000000] 3e80: c07c1814 c0891140 ebfcd464 a00001d3 c0883ec4 c0883ea0 c04c7c9c c04c72cc
>> [    0.000000] 3ea0: c0882000 ebfcd464 c074dcc8 c086bf64 00000001 c074de24 c0883ee4 c0883ec8
>> [    0.000000] 3ec0: c0824b70 c04c7c14 c0891114 c0938af8 00000000 c074dcc8 c0883f54 c0883ee8
>> [    0.000000] 3ee0: c0824c58 c0824b18 00000000 c0e8bf6c c0882000 ffffffff c0883f14 c0883f08
>> [    0.000000] 3f00: c05bc6b4 c05bc44c c0883f34 c0883f18 c04cca04 c05bc6b0 00000000 00000000
>> [    0.000000] 3f20: eb016b80 c0882000 c0883f4c c0883f38 c0938af8 c08910c0 c074dcc8 c074de24
>> [    0.000000] 3f40: c086ad60 c088a880 c0883f7c c0883f58 c0824f5c c0824c20 00000001 c0883f68
>> [    0.000000] 3f60: 00000001 c09380c0 c0882000 ffffffff c0883f8c c0883f80 c0825250 c0824f1c
>> [    0.000000] 3f80: c0883f9c c0883f90 c0825400 c0825238 c0883fac c0883fa0 c081d67c c08253fc
>> [    0.000000] 3fa0: c0883ff4 c0883fb0 c0819a30 c081d664 ffffffff ffffffff c08195d0 00000000
>> [    0.000000] 3fc0: 00000000 c086ad60 00000000 10c5387d c088a92c c086ad5c c088f684 8000406a
>> [    0.000000] 3fe0: 412fc09a 00000000 00000000 c0883ff8 80008074 c0819840 00000000 00000000
>> [    0.000000] Backtrace:
>> [    0.000000] [<c0196068>] (kernfs_find_ns) from [<c019628c>] (kernfs_find_and_get_ns+0x38/0x54)
>> [    0.000000]  r8:ebfcd464 r7:00000000 r6:00000000 r5:c07c1814 r4:c08e9ad8
>> [    0.000000] [<c0196254>] (kernfs_find_and_get_ns) from [<c04c6180>] (safe_name+0x2c/0x98)
>> [    0.000000]  r7:ebfcd490 r6:c07c1814 r5:00000000 r4:c07c1814
>> [    0.000000] [<c04c6154>] (safe_name) from [<c04c7308>] (__of_add_property_sysfs+0x48/0xc4)
>> [    0.000000]  r7:00000001 r6:ebfcd490 r5:c07c1814 r4:c0891140
>> [    0.000000] [<c04c72c0>] (__of_add_property_sysfs) from [<c04c7c9c>] (of_add_property+0x94/0xa0)
>> [    0.000000]  r8:a00001d3 r7:ebfcd464 r6:c0891140 r5:c07c1814 r4:00000000
>> [    0.000000] [<c04c7c08>] (of_add_property) from [<c0824b70>] (omap_get_timer_dt+0x64/0x108)
>> [    0.000000]  r8:c074de24 r7:00000001 r6:c086bf64 r5:c074dcc8 r4:ebfcd464 r3:c0882000
>> [    0.000000] [<c0824b0c>] (omap_get_timer_dt) from [<c0824c58>] (omap_dm_timer_init_one+0x44/0x2fc)
>> [    0.000000]  r6:c074dcc8 r5:00000000 r4:c0938af8 r3:c0891114
>> [    0.000000] [<c0824c14>] (omap_dm_timer_init_one) from [<c0824f5c>] (omap2_gp_clockevent_init+0x4c/0xd0)
>> [    0.000000]  r10:c088a880 r8:c086ad60 r7:c074de24 r6:c074dcc8 r5:c08910c0 r4:c0938af8
>> [    0.000000] [<c0824f10>] (omap2_gp_clockevent_init) from [<c0825250>] (omap4_sync32k_timer_init+0x24/0x60)
>> [    0.000000]  r7:ffffffff r6:c0882000 r5:c09380c0 r4:00000001
>> [    0.000000] [<c082522c>] (omap4_sync32k_timer_init) from [<c0825400>] (omap4_local_timer_init+0x10/0x68)
>> [    0.000000] [<c08253f0>] (omap4_local_timer_init) from [<c081d67c>] (time_init+0x24/0x38)
>> [    0.000000] [<c081d658>] (time_init) from [<c0819a30>] (start_kernel+0x1fc/0x390)
>> [    0.000000] [<c0819834>] (start_kernel) from [<80008074>] (0x80008074)
>> [    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c088f684 r6:c086ad5c r5:c088a92c
>> [    0.000000]  r4:10c5387d
>> [    0.000000] Code: e92dd9f0 e24cb004 e24dd00c e59f3104 (e1d084bc)
>> [    0.000000] ---[ end trace 3406ff24bd97382e ]---
>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>>
>
>

