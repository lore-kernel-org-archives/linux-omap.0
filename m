From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Thu, 11 Aug 2011 17:33:49 +0530
Message-ID: <4E43C525.3040006@ti.com>
References: <1307356643.23002.413.camel@cumari> <20110606104417.GP18731@legolas.emea.dhcp.ti.com> <20110606110218.GS18731@legolas.emea.dhcp.ti.com> <1307358348.23002.419.camel@cumari> <1312889168.2407.148.camel@cumari> <CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com> <CAP05o4JTxotUg2s6Cb2ttYNkvvSiyS5OQ-Ecfiea=QfhKWJ+SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59208 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754536Ab1HKMD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 08:03:58 -0400
In-Reply-To: <CAP05o4JTxotUg2s6Cb2ttYNkvvSiyS5OQ-Ecfiea=QfhKWJ+SA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Luciano Coelho <coelho@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, balbi@ti.com, sameo@linux.intel.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Kevin Hilman <khilman@ti.com>

On 8/11/2011 1:51 PM, Munegowda, Keshava wrote:
> On Thu, Aug 11, 2011 at 1:37 PM, Ohad Ben-Cohen<ohad@wizery.com>  wrote:
>> + Paul, Benoit, Rajendra
>>
>> On Tue, Aug 9, 2011 at 2:26 PM, Luciano Coelho<coelho@ti.com>  wrote:
>>> I'm again getting a very similar oops with 3.1-rc1 on my pandaboard:
>>>
>>> [    2.054351] usbcore: registered new interface driver cdc_ncm
>>> [    2.061431] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>> [    2.068664] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>>> [    2.076110] Internal error: : 1406 [#1] SMP
>>> [    2.080505] Modules linked in:
>>> [    2.083709] CPU: 0    Not tainted  (3.1.0-rc1-wl+ #283)
>>> [    2.089233] PC is at omap_usbhs_enable+0x148/0x590
>>> [    2.094299] LR is at trace_hardirqs_off+0x14/0x18
>> ...
>>> [    2.310150] [<c02a8640>] (omap_usbhs_enable+0x148/0x590) from [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568)
>>> [    2.320526] [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568) from [<c0298cfc>] (platform_drv_probe+0x24/0x28)
>>> [    2.330780] [<c0298cfc>] (platform_drv_probe+0x24/0x28) from [<c0297650>] (driver_probe_device+0x158/0x27c)
>>> [    2.341033] [<c0297650>] (driver_probe_device+0x158/0x27c) from [<c02977ec>] (__driver_attach+0x78/0x9c)
>>> [    2.351043] [<c02977ec>] (__driver_attach+0x78/0x9c) from [<c0296c00>] (bus_for_each_dev+0x5c/0x8c)
>>> [    2.360565] [<c0296c00>] (bus_for_each_dev+0x5c/0x8c) from [<c0297334>] (driver_attach+0x28/0x30)
>>> [    2.369903] [<c0297334>] (driver_attach+0x28/0x30) from [<c02963ec>] (bus_add_driver+0xd8/0x260)
>>> [    2.379180] [<c02963ec>] (bus_add_driver+0xd8/0x260) from [<c0297f00>] (driver_register+0xb8/0x144)
>>> [    2.388702] [<c0297f00>] (driver_register+0xb8/0x144) from [<c02991e0>] (platform_driver_register+0x54/0x68)
>>> [    2.399047] [<c02991e0>] (platform_driver_register+0x54/0x68) from [<c069904c>] (ehci_hcd_init+0xa8/0xfc)
>>> [    2.409149] [<c069904c>] (ehci_hcd_init+0xa8/0xfc) from [<c0008854>] (do_one_initcall+0xa8/0x17c)
>>> [    2.418487] [<c0008854>] (do_one_initcall+0xa8/0x17c) from [<c06792d4>] (kernel_init+0x88/0x134)
>>> [    2.427764] [<c06792d4>] (kernel_init+0x88/0x134) from [<c0014ba0>] (kernel_thread_exit+0x0/0x8)
>>
>> I get this too.
>>
>>> Any clues?
>>
>> Reverting 665d001338b494d6d62810aa99b4c0fa1a0884b9 "OMAP2+: hwmod:
>> Follow the recommended PRCM module enable sequence" fixes this for me.
>>
>> More specifically, this hunk alone seems to do the trick:
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44x
>> index 2af0e3f..12d22a8 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3379,7 +3379,6 @@ int __init omap4xxx_clk_init(void)
>>         }
>>
>>         clk_init(&omap2_clk_functions);
>> -       omap2_clk_disable_clkdm_control();
>>
>>         for (c = omap44xx_clks; c<  omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
>>                                                                           c++)
>>
>> I'm not suggesting this is anyway near a real fix, but hopefully it
>> will help pin-point the problem (clock44xx_data.c changes ?).
>
>
>
>
> Even I am seeing same and bit similar crash  in omap4 sdp

All of these are symptoms of your driver accessing registers
while the module is not fully enabled. This is because clock
framework on OMAP4, neither puts the respective clockdomains
in right state before enabling the clocks, nor does it wait
on IDLEST bits to make sure the module is completely accessible.
All of this is moved into higher level hwmod/omap_device frameworks,
and hence a runtime PM conversion of your driver should fix all these
issues.

>
> [   36.922027] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   36.931243] CUSTOM SRESP error with SOURCE:L4CFG
> [   36.936096] Modules linked in: ehci_hcd(+)
> [   36.940399] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   36.950256] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   36.960327] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   36.970550] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   36.981445] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   36.991760] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   37.001617] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   37.011627] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   37.020843] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   37.029327] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   37.038085] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   37.046661] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   37.055328] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   37.064178] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   37.069488] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   37.078063] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   37.086639] 9fa0: 20000013 ffffffff
> [   37.090301] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   37.098999] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   37.107574] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   37.116333] ---[ end trace 52da08271889a1a6 ]---
> [   37.121215] ------------[ cut here ]------------
> [   37.126068] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   37.135284] CUSTOM SRESP error with SOURCE:L4CFG
> [   37.140136] Modules linked in: ehci_hcd(+)
> [   37.144439] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   37.154296] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   37.164337] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   37.174530] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   37.185394] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   37.195709] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   37.205535] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   37.215576] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   37.224822] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   37.233306] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   37.242034] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   37.250610] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   37.259246] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   37.268096] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   37.273406] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   37.281982] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   37.290557] 9fa0: 20000013 ffffffff
> [   37.294219] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   37.302856] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   37.311431] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   37.320220] ---[ end trace 52da08271889a1a7 ]---
> [   37.325042] ------------[ cut here ]------------
> [   37.329895] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   37.339080] CUSTOM SRESP error with SOURCE:L4CFG
> [   37.343933] Modules linked in: ehci_hcd(+)
> [   37.348236] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   37.358093] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   37.368194] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   37.378417] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   37.389312] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   37.399627] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   37.409484] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   37.419555] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   37.428771] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   37.437286] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   37.446075] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   37.454650] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   37.463348] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   37.472229] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   37.477539] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   37.486145] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   37.494720] 9fa0: 20000013 ffffffff
> [   37.498413] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   37.507080] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   37.515686] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   37.524444] ---[ end trace 52da08271889a1a8 ]---
> [   37.529296] ------------[ cut here ]------------
> [   37.534149] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   37.543365] CUSTOM SRESP error with SOURCE:L4CFG
> [   37.548217] Modules linked in: ehci_hcd(+)
> [   37.552551] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   37.562408] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   37.572479] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   37.582733] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   37.593597] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   37.603942] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   37.613800] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   37.623870] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   37.633117] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   37.641632] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   37.650390] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   37.658996] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   37.667694] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   37.676544] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   37.681854] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   37.690460] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   37.699035] 9fa0: 20000013 ffffffff
> [   37.702697] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   37.711395] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   37.720001] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   37.728759] ---[ end trace 52da08271889a1a9 ]---
> [   37.733642] ------------[ cut here ]------------
> [   37.738464] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   37.747711] CUSTOM SRESP error with SOURCE:L4CFG
> [   37.752563] Modules linked in: ehci_hcd(+)
> [   37.756866] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   37.766723] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   37.776794] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   37.787048] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   37.797912] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   37.808258] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   37.818145] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   37.828216] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   37.837463] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   37.845977] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   37.854766] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   37.863342] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   37.872039] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   37.880920] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   37.886230] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   37.894836] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   37.903411] 9fa0: 20000013 ffffffff
> [   37.907104] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   37.915802] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   37.924377] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   37.933166] ---[ end trace 52da08271889a1aa ]---
> [   37.938049] ------------[ cut here ]------------
> [   37.942901] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   37.952117] CUSTOM SRESP error with SOURCE:L4CFG
> [   37.956970] Modules linked in: ehci_hcd(+)
> [   37.961303] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   37.971191] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   37.981262] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   37.991516] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   38.002410] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   38.012725] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   38.022613] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   38.032684] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   38.041931] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   38.050445] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   38.059234] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   38.067810] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   38.076507] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   38.085388] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   38.090698] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   38.099304] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   38.107910] 9fa0: 20000013 ffffffff
> [   38.111572] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   38.120239] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   38.128845] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   38.137603] ---[ end trace 52da08271889a1ab ]---
> [   38.142486] ------------[ cut here ]------------
> [   38.147338] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   38.156555] CUSTOM SRESP error with SOURCE:L4CFG
> [   38.161376] Modules linked in: ehci_hcd(+)
> [   38.165710] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   38.175598] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   38.185638] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   38.195861] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   38.206756] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   38.217102] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   38.226989] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   38.237030] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   38.246276] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   38.254760] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   38.263519] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   38.272125] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   38.280822] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   38.289672] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   38.294952] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   38.303558] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   38.312133] 9fa0: 20000013 ffffffff
> [   38.315795] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   38.324462] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   38.333038] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   38.341796] ---[ end trace 52da08271889a1ac ]---
> [   38.346679] ------------[ cut here ]------------
> [   38.351531] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   38.360748] CUSTOM SRESP error with SOURCE:L4CFG
> [   38.365570] Modules linked in: ehci_hcd(+)
> [   38.369873] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   38.379760] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   38.389831] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   38.400085] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   38.410949] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   38.421295] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   38.431182] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   38.441223] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   38.450439] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   38.458953] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   38.467742] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   38.476348] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   38.485046] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   38.493896] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   38.499206] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   38.507751] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   38.516326] 9fa0: 20000013 ffffffff
> [   38.519989] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   38.528686] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   38.537261] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   38.546051] ---[ end trace 52da08271889a1ad ]---
> [   38.550903] ------------[ cut here ]------------
> [   38.555755] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   38.565002] CUSTOM SRESP error with SOURCE:L4CFG
> [   38.569854] Modules linked in: ehci_hcd(+)
> [   38.574157] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   38.584045] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   38.594116] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   38.604370] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   38.615234] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   38.625579] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   38.635467] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   38.645538] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   38.654785] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   38.663269] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   38.672058] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   38.680664] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   38.689331] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   38.698211] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   38.703521] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   38.712127] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   38.720733] 9fa0: 20000013 ffffffff
> [   38.724426] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   38.733123] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   38.741729] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   38.750488] ---[ end trace 52da08271889a1ae ]---
> [   38.755340] ------------[ cut here ]------------
> [   38.760192] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   38.769439] CUSTOM SRESP error with SOURCE:L4CFG
> [   38.774261] Modules linked in: ehci_hcd(+)
> [   38.778594] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   38.788482] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   38.798553] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   38.808776] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   38.819671] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   38.830017] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   38.839904] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   38.849945] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   38.859161] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   38.867675] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   38.876434] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   38.885009] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   38.893707] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   38.902526] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   38.907836] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   38.916412] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   38.924987] 9fa0: 20000013 ffffffff
> [   38.928649] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   38.937347] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   38.945953] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   38.954711] ---[ end trace 52da08271889a1af ]---
> [   38.959564] ------------[ cut here ]------------
> [   38.964416] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   38.973632] CUSTOM SRESP error with SOURCE:L4CFG
> [   38.978454] Modules linked in: ehci_hcd(+)
> [   38.982757] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   38.992645] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   39.002716] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   39.012969] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   39.023864] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   39.034179] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   39.044067] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   39.054107] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   39.063323] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   39.071838] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   39.080627] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   39.089233] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   39.097930] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   39.106781] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   39.112121] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   39.120727] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   39.129333] 9fa0: 20000013 ffffffff
> [   39.132995] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   39.141662] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
> [   39.150268] [<c001544c>] (cpu_idle+0xc0/0x104) from [<c05bb82c>]
> (start_kernel+0x270/0x 300)
> [   39.159057] ---[ end trace 52da08271889a1b0 ]---
> [   39.163909] ------------[ cut here ]------------
> [   39.168792] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
> l3_interrupt_handler+0x14 4/0x170()
> [   39.178009] CUSTOM SRESP error with SOURCE:L4CFG
> [   39.182861] Modules linked in: ehci_hcd(+)
> [   39.187194] [<c001ae84>] (unwind_backtrace+0x0/0xf8) from
> [<c004ee10>] (warn_slowpath_c ommon+0x4c/0x64)
> [   39.197052] [<c004ee10>] (warn_slowpath_common+0x4c/0x64) from
> [<c004eebc>] (warn_slowp ath_fmt+0x30/0x40)
> [   39.207122] [<c004eebc>] (warn_slowpath_fmt+0x30/0x40) from
> [<c0030318>] (l3_interrupt_ handler+0x144/0x170)
> [   39.217346] [<c0030318>] (l3_interrupt_handler+0x144/0x170) from
> [<c0097aac>] (handle_i rq_event_percpu+0x74/0x208)
> [   39.228240] [<c0097aac>] (handle_irq_event_percpu+0x74/0x208) from
> [<c0097c7c>] (handle _irq_event+0x3c/0x5c)
> [   39.238586] [<c0097c7c>] (handle_irq_event+0x3c/0x5c) from
> [<c009a288>] (handle_fasteoi _irq+0x98/0x110)
> [   39.248474] [<c009a288>] (handle_fasteoi_irq+0x98/0x110) from
> [<c0097624>] (generic_han dle_irq+0x38/0x48)
> [   39.258544] [<c0097624>] (generic_handle_irq+0x38/0x48) from
> [<c0014c88>] (handle_IRQ+0 x4c/0xac)
> [   39.267791] [<c0014c88>] (handle_IRQ+0x4c/0xac) from [<c041b89c>]
> (__irq_svc+0x3c/0x100 )
> [   39.276306] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0055d70>]
> (__do_softirq+0x64/0x 21c)
> [   39.285095] [<c0055d70>] (__do_softirq+0x64/0x21c) from
> [<c0056124>] (irq_exit+0x90/0xa c)
> [   39.293701] [<c0056124>] (irq_exit+0x90/0xac) from [<c0008474>]
> (do_local_timer+0x58/0x 74)
> [   39.302398] [<c0008474>] (do_local_timer+0x58/0x74) from
> [<c041b89c>] (__irq_svc+0x3c/0 x100)
> [   39.311248] Exception stack(0xc0609f60 to 0xc0609fa8)
> [   39.316589] 9f60: 00000001 00000001 c06209c8 00000000 c0608000
> c068be24 c061d96c 000000 00
> [   39.325195] 9f80: c0622184 411fc092 c0622338 00000000 c0605770
> c0609fa8 c008569c c0014e 00
> [   39.333801] 9fa0: 20000013 ffffffff
> [   39.337463] [<c041b89c>] (__irq_svc+0x3c/0x100) from [<c0014e00>]
> (default_idle+0x30/0x 38)
> [   39.346160] [<c0014e00>] (default_idle+0x30/0x38) from [<c001544c>]
> (cpu_idle+0xc0/0x10 4)
>
>
> it's crashing l3 cache; its occurrence is very random and rare in omap4 sdp.

