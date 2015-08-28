From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap-device: remove omap_device_late_init
 call completely
Date: Fri, 28 Aug 2015 14:54:23 +0530
Message-ID: <55E028C7.3060509@ti.com>
References: <1440611890-4935-1-git-send-email-grygorii.strashko@ti.com>
 <20150826181006.GT4215@atomide.com> <55DF12E7.10802@ti.com>
 <20150827163856.GX4215@atomide.com> <55DF4398.7020201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55DF4398.7020201@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Thursday 27 August 2015 10:36 PM, Grygorii Strashko wrote:
> On 08/27/2015 07:38 PM, Tony Lindgren wrote:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [150827 06:42]:
>>> Hi Tony,
>>>
>>> On 08/26/2015 09:10 PM, Tony Lindgren wrote:
>>>> * Grygorii Strashko <grygorii.strashko@ti.com> [150826 11:01]:
>>>>> Now Kernel fails to boot 50% of times (form build to build) with
>>>>> RT-patchset applied due to the following race - on late boot
>>>>> stages deferred_probe_work_func races with omap_device_late_ini
>>>>>
>>>>> late_initcall
>>>>>     - deferred_probe_initcal() tries to re-probe all pending driver's probe.
>>>>>       [In general, It's NOT expected to probe any other built-in drivers after
>>>>>       deferred_probe_initcal() is finished, because most of
>>>>>       late_initcall_sync/late_initcall functions expected that all driver
>>>>>       or probed or deferred already.]
>>>>>
>>>>> - later on, some driver is probing in this case It's could cpsw.c
>>>>>      (but could be any other drivers)
>>>>>      cpsw_init
>>>>>      - platform_driver_register
>>>>>        - really_probe
>>>>>           - driver_bound
>>>>>             - driver_deferred_probe_trigger
>>>>>      and boot proceed.
>>>>>      So, at this moment we have  deferred_probe_work_func scheduled.
>>>>>
>>>>> late_initcall_sync
>>>>>      - omap_device_late_init
>>>>>        - omap_device_idle
>>>>>
>>>>> CPU1					CPU2
>>>>>      - deferred_probe_work_func
>>>>>        - really_probe
>>>>>          - omap_hsmmc_probe
>>>>> 	- pm_runtime_get_sync
>>>>> 					late_initcall_sync
>>>>> 					- omap_device_late_init
>>>>> 						if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
>>>>> 							if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
>>>>> 								- omap_device_idle [ops - IP is disabled, ]
>>>>> 	- [fail]
>>>>> 	- pm_runtime_put_sync
>>>>>              - omap_hsmmc_runtime_suspend [ooops!]
>>>>
>>>> OK idling of unclaimed devices should not happen for deferred probe,
>>>> it should only happen when there's no driver and no probing happening.
>>>>
>>>>> Lets remove just remove omap_device_late_init completely as suggested
>>>>> by Tero Kristo:
>>>>>
>>>>> "How about remove omap_device_late_init call completely. I don't think
>>>>> it does anything useful at the moment; none of the omap devices get
>>>>> enabled outside runtime_pm, so there should be no need to explicitly
>>>>> disable the devices."
>>>>
>>>> I think this is still needed from PM point of view as otherwise we
>>>> don't idle any devices that don't have a driver available. Or am I
>>>> missing something?
>>>>
>>>> To me it seems the bug is relying on the BUS_NOTIFY_BOUND_DRIVER is
>>>> not set in the deferred probe case.
>>>>
>>>
>>>
>>> What do you think about below alternative?
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
>>> index 4cb8fd9..72ebc4c 100644
>>> --- a/arch/arm/mach-omap2/omap_device.c
>>> +++ b/arch/arm/mach-omap2/omap_device.c
>>> @@ -901,7 +901,8 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
>>>                   if (od->hwmods[i]->flags & HWMOD_INIT_NO_IDLE)
>>>                           return 0;
>>>
>>> -       if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
>>> +       if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER &&
>>> +           od->_driver_status != BUS_NOTIFY_BIND_DRIVER) {
>>>                   if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
>>>                           dev_warn(dev, "%s: enabled but no driver.  Idling\n",
>>>                                    __func__);
>>
>> Seems better to me if it really fixes the issue.
>>
>
> My dra7-evm failed to boot on "2b186e5 Add linux-next specific files for 20150827"
> and this change restores boot.
>
> Will wait for confirmation from Keerthy.

I confirm that with this patch the boot crash is fixed.

Tested-by: Keerthy <j-keerthy@ti.com>


Without this patch i see this crash during boot:

[    2.423724] omap_hsmmc 4809c000.mmc: omap_device_late_idle: enabled 
but no driver.  Idling
[    2.432959] ldousb: disabling
[    2.461630] Unhandled fault: imprecise external abort (0x1406) at 
0x00000000
[    2.461638] ------------[ cut here ]------------
[    2.461654] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 
l3_interrupt_handler+0x220/0x348()
[    2.461660] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET 
L4_PER1_P3 (Read): Data Access in User mode during Functional access
[    2.461665] Modules linked in:
[    2.461672] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.2.0-rc8-00084-gf1f35f0 #85
[    2.461675] Hardware name: Generic DRA74X (Flattened Device Tree)
[    2.461690] [<c0016614>] (unwind_backtrace) from [<c0012b10>] 
(show_stack+0x10/0x14)
[    2.461699] [<c0012b10>] (show_stack) from [<c05e9568>] 
(dump_stack+0x80/0x9c)
[    2.461709] [<c05e9568>] (dump_stack) from [<c003fb98>] 
(warn_slowpath_common+0x7c/0xb8)
[    2.461717] [<c003fb98>] (warn_slowpath_common) from [<c003fc68>] 
(warn_slowpath_fmt+0x30/0x40)
[    2.461726] [<c003fc68>] (warn_slowpath_fmt) from [<c037b0c0>] 
(l3_interrupt_handler+0x220/0x348)
[    2.461739] [<c037b0c0>] (l3_interrupt_handler) from [<c0099238>] 
(handle_irq_event_percpu+0x64/0x204)
[    2.461748] [<c0099238>] (handle_irq_event_percpu) from [<c0099418>] 
(handle_irq_event+0x40/0x64)
[    2.461758] [<c0099418>] (handle_irq_event) from [<c009c324>] 
(handle_fasteoi_irq+0xcc/0x1a8)
[    2.461768] [<c009c324>] (handle_fasteoi_irq) from [<c0098ae8>] 
(generic_handle_irq+0x20/0x30)
[    2.461776] [<c0098ae8>] (generic_handle_irq) from [<c0098bfc>] 
(__handle_domain_irq+0x64/0xdc)
[    2.461784] [<c0098bfc>] (__handle_domain_irq) from [<c00094c4>] 
(gic_handle_irq+0x20/0x60)
[    2.461795] [<c00094c4>] (gic_handle_irq) from [<c05f03e4>] 
(__irq_svc+0x44/0x5c)
[    2.461799] Exception stack(0xc08b7f58 to 0xc08b7fa0)
[    2.461803] 7f40: 
    00000001 00000001
[    2.461809] 7f60: 00000000 c08bc0b8 00000000 c096c8c8 c08b89c8 
00000000 00000000 c08b8a28
[    2.461815] 7f80: c08b3ab8 c08b8a30 00000000 c08b7fa0 c008e9fc 
c0010140 20000013 ffffffff
[    2.461828] [<c05f03e4>] (__irq_svc) from [<c0010140>] 
(arch_cpu_idle+0x20/0x3c)
[    2.461838] [<c0010140>] (arch_cpu_idle) from [<c0082080>] 
(cpu_startup_entry+0x240/0x374)
[    2.461850] [<c0082080>] (cpu_startup_entry) from [<c084ac48>] 
(start_kernel+0x38c/0x404)
[    2.461859] [<c084ac48>] (start_kernel) from [<8000807c>] (0x8000807c)
[    2.461862] ---[ end trace 14dd5a34ef3f5143 ]---
[    2.685888] pgd = c0004000
[    2.688718] [00000000] *pgd=00000000
[    2.692465] Internal error: : 1406 [#1] SMP ARM
[    2.697213] Modules linked in:
[    2.700413] CPU: 1 PID: 40 Comm: kworker/u4:2 Tainted: G        W 
    4.2.0-rc8-00084-gf1f35f0 #85
[    2.709990] Hardware name: Generic DRA74X (Flattened Device Tree)
[    2.716374] Workqueue: deferwq deferred_probe_work_func
[    2.721851] task: c2032400 ti: c2158000 task.ti: c2158000
[    2.727505] PC is at omap_hsmmc_runtime_suspend+0x18/0xc4
[    2.733167] LR is at pm_generic_runtime_suspend+0x2c/0x38
[    2.738822] pc : [<c04bfc24>]    lr : [<c03e8444>]    psr: a0000013
[    2.738822] sp : c2159d40  ip : c0ac5658  fp : de224410
[    2.750853] r10: 0000000c  r9 : 00000000  r8 : c08b8100
[    2.756321] r7 : 00000008  r6 : de224410  r5 : de2244a0  r4 : c21c5cc0
[    2.763163] r3 : fa09c100  r2 : 00000000  r1 : c2032968  r0 : de224410
[    2.770001] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[    2.777652] Control: 10c5387d  Table: 8000406a  DAC: 00000015
[    2.783666] Process kworker/u4:2 (pid: 40, stack limit = 0xc2158218)
[    2.790316] Stack: (0xc2159d40 to 0xc215a000)
[    2.794880] 9d40: c04bfc0c de224410 de2244a0 c0029ee8 00000008 
c03e8444 c2032400 c0029ef4
[    2.803444] 9d60: de224410 c03e9b48 de224410 00000000 00000000 
c03e9b9c 00000000 c0029ee8
[    2.812009] 9d80: 00000000 c03e9fcc 00000004 c08b8100 0000013a 
c21c5cc0 60000093 c05eff54
[    2.820568] 9da0: 00000000 de224410 00000000 de224410 00000004 
de2244a0 60000013 fffffdfb
[    2.829135] 9dc0: 0000013a c21c5cc0 fa09c100 c03ea74c 00000081 
c21c5800 fffffdfb de224400
[    2.837702] 9de0: de224410 c04c1a6c 00000000 c21c1a80 c21c5cc0 
c20ea810 c07b7d90 00000400
[    2.846271] 9e00: 00000000 c21c3d50 c096c378 ffffffed de224410 
fffffdfb c094cdb8 0000000d
[    2.854843] 9e20: c096c378 de0a6800 00000000 c03e3650 c03e3608 
c1167258 de224410 00000000
[    2.863407] 9e40: c094cdb8 c03e1fe0 00000000 c2159e78 c03e2280 
00000001 c096c378 c03e069c
[    2.871974] 9e60: de100cd4 c20ebc94 de224410 de224444 c0939290 
c03e1da4 de224410 00000001
[    2.880531] 9e80: c0939ee8 de224410 de224410 c0939290 c2159ed0 
c03e1540 de224410 c09391d4
[    2.889094] 9ea0: c0939190 c03e1928 c093920c c20491c0 de0a4c00 
c0057b70 00000001 00000000
[    2.897658] 9ec0: c0057adc de0a4c00 00000001 00000001 c093920c 
c0ac5658 00000000 c07b0110
[    2.906220] 9ee0: 00000003 c20491c0 de0a4c30 c096bbb3 c20491d8 
00000088 de0a4c00 de0a4c00
[    2.914792] 9f00: 00000003 c0057ff4 c2032400 00000000 de2b63c0 
c20491c0 c0057ea0 00000000
[    2.923363] 9f20: 00000000 00000000 00000000 c005dcf8 00000000 
00000000 00000001 c20491c0
[    2.931927] 9f40: 00000000 00000000 dead4ead ffffffff ffffffff 
c0972e38 00000000 00000000
[    2.940499] 9f60: c076df74 c2159f64 c2159f64 00000000 00000000 
dead4ead ffffffff ffffffff
[    2.949060] 9f80: c0972e38 00000000 00000000 c076df74 c2159f90 
c2159f90 c2159fac de2b63c0
[    2.957623] 9fa0: c005dc24 00000000 00000000 c000f6b8 00000000 
00000000 00000000 00000000
[    2.966186] 9fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.974749] 9fe0: 00000000 00000000 00000000 00000000 00000013 
00000000 e7fddef0 e7fddef0
[    2.983325] [<c04bfc24>] (omap_hsmmc_runtime_suspend) from 
[<c03e8444>] (pm_generic_runtime_suspend+0x2c/0x38)
[    2.993809] [<c03e8444>] (pm_generic_runtime_suspend) from 
[<c0029ef4>] (_od_runtime_suspend+0xc/0x20)
[    3.003566] [<c0029ef4>] (_od_runtime_suspend) from [<c03e9b48>] 
(__rpm_callback+0x2c/0x60)
[    3.012322] [<c03e9b48>] (__rpm_callback) from [<c03e9b9c>] 
(rpm_callback+0x20/0x80)
[    3.020435] [<c03e9b9c>] (rpm_callback) from [<c03e9fcc>] 
(rpm_suspend+0xf4/0x510)
[    3.028365] [<c03e9fcc>] (rpm_suspend) from [<c03ea74c>] 
(__pm_runtime_idle+0x60/0x84)
[    3.036662] [<c03ea74c>] (__pm_runtime_idle) from [<c04c1a6c>] 
(omap_hsmmc_probe+0x61c/0xa24)
[    3.045585] [<c04c1a6c>] (omap_hsmmc_probe) from [<c03e3650>] 
(platform_drv_probe+0x48/0xa4)
[    3.054427] [<c03e3650>] (platform_drv_probe) from [<c03e1fe0>] 
(driver_probe_device+0x1c4/0x26c)
[    3.063724] [<c03e1fe0>] (driver_probe_device) from [<c03e069c>] 
(bus_for_each_drv+0x44/0x8c)
[    3.072653] [<c03e069c>] (bus_for_each_drv) from [<c03e1da4>] 
(__device_attach+0x8c/0xdc)
[    3.081219] [<c03e1da4>] (__device_attach) from [<c03e1540>] 
(bus_probe_device+0x88/0x90)
[    3.089787] [<c03e1540>] (bus_probe_device) from [<c03e1928>] 
(deferred_probe_work_func+0x60/0x90)
[    3.099182] [<c03e1928>] (deferred_probe_work_func) from [<c0057b70>] 
(process_one_work+0x1b4/0x4b0)
[    3.108756] [<c0057b70>] (process_one_work) from [<c0057ff4>] 
(worker_thread+0x154/0x474)
[    3.117326] [<c0057ff4>] (worker_thread) from [<c005dcf8>] 
(kthread+0xd4/0xf0)
[    3.124889] [<c005dcf8>] (kthread) from [<c000f6b8>] 
(ret_from_fork+0x14/0x3c)
[    3.132448] Code: e5904084 e594302c e593202c e5842064 (e5932128)
[    3.138838] ---[ end trace 14dd5a34ef3f5144 ]---
[    3.143776] Unable to handle kernel paging request at virtual address 
ffffffd0
[    3.151344] pgd = c0004000
[    3.154175] [ffffffd0] *pgd=9fef6821, *pte=00000000, *ppte=00000000
[    3.160760] Internal error: Oops: 17 [#2] SMP ARM
[    3.165684] Modules linked in:
[    3.168887] CPU: 1 PID: 40 Comm: kworker/u4:2 Tainted: G      D W 
    4.2.0-rc8-00084-gf1f35f0 #85
[    3.178453] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.184841] task: c2032400 ti: c2158000 task.ti: c2158000
[    3.190499] PC is at kthread_data+0x4/0xc
[    3.194699] LR is at wq_worker_sleeping+0xc/0xd4
[    3.199527] pc : [<c005e3e4>]    lr : [<c0058f9c>]    psr: 00000193
[    3.199527] sp : c2159b40  ip : 00000000  fp : c2159b94
[    3.211557] r10: 00000001  r9 : df9f0580  r8 : c08b4580
[    3.217028] r7 : c08b95c4  r6 : c20327bc  r5 : df9f0590  r4 : 00000001
[    3.223861] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : c2032400
[    3.230701] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[    3.238258] Control: 10c5387d  Table: 8000406a  DAC: 00000015
[    3.244278] Process kworker/u4:2 (pid: 40, stack limit = 0xc2158218)
[    3.250928] Stack: (0xc2159b40 to 0xc215a000)
[    3.255493] 9b40: c2032400 c05eaa74 c00428f8 c01039fc c08fa360 
00000001 dcfd31c4 c05eaf28
[    3.264059] 9b60: de2bc488 c00428f8 df9f0cc0 c2032fdc 60000113 
c215985c c2032400 c08f4658
[    3.272622] 9b80: c2032738 c2159bb0 00000001 c04bfc26 c2159b9c 
c05eaf28 00000001 c00429b0
[    3.281194] 9ba0: 00000000 00000001 c00984b8 c2159bcc c2159bb0 
c2159bb0 c2159cf8 c0971244
[    3.289767] 9bc0: c2159cf8 c08bdc28 60000193 0000000b c04bfc28 
c04bfc26 00000001 c0012efc
[    3.298326] 9be0: c2158218 0000000b 00000001 00000000 00000000 
00000008 65000000 34303935
[    3.306895] 9c00: 20343830 34393565 63323033 39356520 32303233 
35652063 30323438 28203436
[    3.315464] 9c20: 33393565 38323132 c0002029 c2159c4c c1132f9c 
00001406 00000007 00000000
[    3.324033] 9c40: c08be50c c2159cf8 00000000 0000000c de224410 
c0009344 00000000 000005a8
[    3.332601] 9c60: 00000007 00000000 00030003 00000000 c2032988 
00000588 c1132f9c c2032400
[    3.341172] 9c80: c20329a8 00000000 c1132f9c c2032400 c092ec54 
00000134 c0aa0688 c008c370
[    3.349741] 9ca0: c092ec54 0000013b 00000004 c008c370 3c220134 
22c11684 00000004 c0ab4dc8
[    3.358305] 9cc0: c20329a8 00000000 c1132f9c 000005a8 c092ec54 
00000110 c0fab7f4 c008c370
[    3.366877] 9ce0: c04bfc24 a0000013 ffffffff c2159d2c c08b8100 
c05f0364 de224410 c2032968
[    3.375448] 9d00: 00000000 fa09c100 c21c5cc0 de2244a0 de224410 
00000008 c08b8100 00000000
[    3.384011] 9d20: 0000000c de224410 c0ac5658 c2159d40 c03e8444 
c04bfc24 a0000013 ffffffff
[    3.392579] 9d40: c04bfc0c de224410 de2244a0 c0029ee8 00000008 
c03e8444 c2032400 c0029ef4
[    3.401144] 9d60: de224410 c03e9b48 de224410 00000000 00000000 
c03e9b9c 00000000 c0029ee8
[    3.409712] 9d80: 00000000 c03e9fcc 00000004 c08b8100 0000013a 
c21c5cc0 60000093 c05eff54
[    3.418280] 9da0: 00000000 de224410 00000000 de224410 00000004 
de2244a0 60000013 fffffdfb
[    3.426850] 9dc0: 0000013a c21c5cc0 fa09c100 c03ea74c 00000081 
c21c5800 fffffdfb de224400
[    3.435422] 9de0: de224410 c04c1a6c 00000000 c21c1a80 c21c5cc0 
c20ea810 c07b7d90 00000400
[    3.443983] 9e00: 00000000 c21c3d50 c096c378 ffffffed de224410 
fffffdfb c094cdb8 0000000d
[    3.452546] 9e20: c096c378 de0a6800 00000000 c03e3650 c03e3608 
c1167258 de224410 00000000
[    3.461114] 9e40: c094cdb8 c03e1fe0 00000000 c2159e78 c03e2280 
00000001 c096c378 c03e069c
[    3.469686] 9e60: de100cd4 c20ebc94 de224410 de224444 c0939290 
c03e1da4 de224410 00000001
[    3.478248] 9e80: c0939ee8 de224410 de224410 c0939290 c2159ed0 
c03e1540 de224410 c09391d4
[    3.486812] 9ea0: c0939190 c03e1928 c093920c c20491c0 de0a4c00 
c0057b70 00000001 00000000
[    3.495379] 9ec0: c0057adc de0a4c00 00000001 00000001 c093920c 
c0ac5658 00000000 c07b0110
[    3.503945] 9ee0: 00000003 c20491c0 de0a4c30 c096bbb3 c20491d8 
00000088 de0a4c00 de0a4c00
[    3.512515] 9f00: 00000003 c0057ff4 c2032400 00000000 de2b63c0 
c20491c0 c0057ea0 00000000
[    3.521079] 9f20: 00000000 00000000 00000000 c005dcf8 00000000 
00000000 00000001 c20491c0
[    3.529647] 9f40: 00000000 00000000 dead4ead ffffffff ffffffff 
c0972e38 00000000 00000000
[    3.538202] 9f60: c076df74 c2159f64 c2159f64 00000001 00010001 
dead4ead ffffffff ffffffff
[    3.546773] 9f80: c0972e38 00000000 00000000 c076df74 c2159f90 
c2159f90 c2159fac de2b63c0
[    3.555340] 9fa0: c005dc24 00000000 00000000 c000f6b8 00000000 
00000000 00000000 00000000
[    3.563906] 9fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    3.572473] 9fe0: 00000000 00000000 00000000 00000000 00000013 
00000000 e7fddef0 e7fddef0
[    3.581043] [<c005e3e4>] (kthread_data) from [<c0058f9c>] 
(wq_worker_sleeping+0xc/0xd4)
[    3.589429] [<c0058f9c>] (wq_worker_sleeping) from [<c05eaa74>] 
(__schedule+0x5b4/0x970)
[    3.597911] [<c05eaa74>] (__schedule) from [<c05eaf28>] 
(schedule+0x34/0x98)
[    3.605294] [<c05eaf28>] (schedule) from [<c00429b0>] 
(do_exit+0x60c/0x994)
[    3.612594] [<c00429b0>] (do_exit) from [<c0012efc>] (die+0x3e8/0x438)
[    3.619427] [<c0012efc>] (die) from [<c0009344>] (do_DataAbort+0xa4/0xb4)
[    3.626540] [<c0009344>] (do_DataAbort) from [<c05f0364>] 
(__dabt_svc+0x44/0x80)
[    3.634280] Exception stack(0xc2159cf8 to 0xc2159d40)

>
>
