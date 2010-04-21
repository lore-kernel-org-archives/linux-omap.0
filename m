From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re: [PATCH] Serial: Avoid enabling clocks when clock node is null.
Date: Wed, 21 Apr 2010 11:28:38 +0530
Message-ID: <00b701cae117$b1e5df50$LocalHost@wipblrx0100947A>
References: <40436.192.168.10.89.1271750521.squirrel@dbdmail.itg.ti.com> <87mxwxbt2i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab0DUF65 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 01:58:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Venkatraman S <svenkatr@ti.com>, Sergio Aguirre <saaguirre@ti.com>

Sorry, please drop this patch.

Since this patch is already posted and now part of LO master.

https://patchwork.kernel.org/patch/82738/

But still we are missing the following patches:

https://patchwork.kernel.org/patch/84748/
https://patchwork.kernel.org/patch/84749/
https://patchwork.kernel.org/patch/84755/
https://patchwork.kernel.org/patch/84750/

without which uart4 clock get fails for 3630 and we get a error log as:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/serial.c:727 
omap_serial_init_port+0x5c/0x3d4()
[    0.000000] (null): can't init uart3, no clocks available
[    0.000000] Modules linked in:
[    0.000000] [<c0044440>] (unwind_backtrace+0x0/0xec) from [<c0072724>] 
(warn_slowpath_common+0x48/0x60)
[    0.000000] [<c0072724>] (warn_slowpath_common+0x48/0x60) from 
[<c0072774>] (warn_slowpath_fmt+0x24/0x30)
[    0.000000] [<c0072774>] (warn_slowpath_fmt+0x24/0x30) from [<c000f4b0>] 
(omap_serial_init_port+0x5c/0x3d4)
[    0.000000] [<c000f4b0>] (omap_serial_init_port+0x5c/0x3d4) from 
[<c000f850>] (omap_serial_init+0x28/0x38)
[    0.000000] [<c000f850>] (omap_serial_init+0x28/0x38) from [<c00137f8>] 
(omap_sdp_init+0x14/0x58)
[    0.000000] [<c00137f8>] (omap_sdp_init+0x14/0x58) from [<c000b464>] 
(customize_machine+0x18/0x24)
[    0.000000] [<c000b464>] (customize_machine+0x18/0x24) from [<c003e34c>] 
(do_one_initcall+0x5c/0x1b8)
[    0.000000] [<c003e34c>] (do_one_initcall+0x5c/0x1b8) from [<c0008578>] 
(kernel_init+0x90/0x144)
[    0.000000] [<c0008578>] (kernel_init+0x90/0x144) from [<c003f970>] 
(kernel_thread_exit+0x0/0x8)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---


I tested these patches it applies cleanly on LO master and works fine with 
3630SDP.

You can add:

Tested-by: Govindraj R govindraj.raja@ti.com

Regards,
Govindraj.R

----- Original Message ----- 
From: "Kevin Hilman" <khilman@deeprootsystems.com>
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: <linux-omap@vger.kernel.org>; "Tony Lindgren" <tony@atomide.com>; 
"Venkatraman S" <svenkatr@ti.com>
Sent: Wednesday, April 21, 2010 5:00 AM
Subject: Re: [PATCH] Serial: Avoid enabling clocks when clock node is null.


> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch ensures that if a particular uart clock node
>> was not acquired then do not proceed with enabling clock
>> and device registration for that uart.
>>
>> Without this patch if uart_ick/fck value was null
>> then it throw oops as below and boot will halt.
>>
>> <1>Unable to handle kernel NULL pointer dereference at virtual address 
>> 0000001c
>> <1>pgd = c0004000
>> <1>[0000001c] *pgd=00000000
>> <0>Internal error: Oops: 5 [#1]
>> <0>last sysfs file:
>> <d>Modules linked in:
>> CPU: 0    Not tainted  (2.6.34-rc3-00006-g7da06f1-dirty #15)
>> PC is at omap_serial_init_port+0x64/0x3a0
>> LR is at 0x8
>> pc : [<c000f51c>]    lr : [<00000008>]    psr: 60000013
>> sp : dfc2bf80  ip : 00000000  fp : 00000000
>> r10: 000007c8  r9 : c05c65f8  r8 : 00000000
>> r7 : c05c6dc0  r6 : c000b44c  r5 : 00000000  r4 : 00000004
>> r3 : 00000007  r2 : c05c6538  r1 : fb020000  r0 : c05c6dc0
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> Control: 10c5387f  Table: 80004019  DAC: 00000017
>> <0>Process swapper (pid: 1, stack limit = 0xdfc2a2f0)
>> <0>Stack: (0xdfc2bf80 to 0xdfc2c000)
>> <0>bf80: 00000003 fb020000 00000004 00000000 c000b44c 00000000 00000000 
>> 00000000
>> <0>bfa0: 00000000 c000f880 c002e288 c00135e0 c002e288 c00137f4 c002e288 
>> c000b464
>> <0>bfc0: c002e288 c003e34c 00000031 00000000 00000000 00000192 00000000 
>> c002e288
>> <0>bfe0: 00000000 00000000 00000000 c0008578 00000000 c003f970 ffffffff 
>> ffffffff
>> [<c000f51c>] (omap_serial_init_port+0x64/0x3a0) from [<c000f880>] 
>> (omap_serial_init+0x28/0x3c)
>> [<c000f880>] (omap_serial_init+0x28/0x3c) from [<c00135e0>] 
>> (zoom_peripherals_init+0x44/0x6c)
>> [<c00135e0>] (zoom_peripherals_init+0x44/0x6c) from [<c00137f4>] 
>> (omap_sdp_init+0x14/0x54)
>> [<c00137f4>] (omap_sdp_init+0x14/0x54) from [<c000b464>] 
>> (customize_machine+0x18/0x24)
>> [<c000b464>] (customize_machine+0x18/0x24) from [<c003e34c>] 
>> (do_one_initcall+0x5c/0x1b8)
>> [<c003e34c>] (do_one_initcall+0x5c/0x1b8) from [<c0008578>] 
>> (kernel_init+0x90/0x144)
>> [<c0008578>] (kernel_init+0x90/0x144) from [<c003f970>] 
>> (kernel_thread_exit+0x0/0x8)
>> <0>Code: eb00ef8f e597c06c e3a0e008 e3a03007 (e5dc201c)
>> <4>---[ end trace 1b75b31a2719ed1c ]---
>> <0>Kernel panic - not syncing: Attempted to kill init!
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Reported-by: Venkatraman S <svenkatr@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> Should be queued for -fixes.
>
> Kevin
> 

