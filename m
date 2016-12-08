From: Tony Lindgren <tony@atomide.com>
Subject: Cpufreq regression in next-20161207
Date: Wed, 7 Dec 2016 20:56:41 -0800
Message-ID: <20161208045640.GB4264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit ef3caabee969 ("PM / OPP: Don't assume platform doesn't
have regulators") caused a regression in Linux next-20161207 for at least
omap4 pandaboard. We now hit kernel BUG at drivers/cpufreq/cpufreq.c:1235.

Any ideas?

Regards,

Tony

8< ----------------------
kernel BUG at drivers/cpufreq/cpufreq.c:1235!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc8-next-20161207 #290
Hardware name: Generic OMAP4 (Flattened Device Tree)
task: ee868000 task.stack: ee86c000
PC is at cpufreq_online+0x5f0/0x648
LR is at __cpufreq_driver_target+0x248/0x4c4
pc : [<c0a57188>]    lr : [<c0a54a78>]    psr: a0000113
sp : ee86dd40  ip : 00000000  fp : c1317ea0
r10: 00000001  r9 : c156cd70  r8 : c140322c
r7 : ee8ae204  r6 : 00000000  r5 : 00000000  r4 : ee8ae200
r3 : 00000001  r2 : 00000001  r1 : 80000113  r0 : ffffffea
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8020404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xee86c220)
Stack: (0xee86dd40 to 0xee86e000)
dd40: 00000000 00000000 ee8ae2b4 ee8ae204 20000113 00000000 ee82bc00 00000000
dd60: ef7aa050 c150bb5c ef7aa050 c150be9c 00000000 00000000 00000000 c0a5729c
dd80: c150bbc0 c14f0014 c150bb5c ef7aa050 c150be9c c07ecce4 c156d484 ee806f58
dda0: ee9f0fb4 00000000 00000000 c150bee4 c156cd70 c0a561c8 00000000 c0a59110
ddc0: ee8bf040 eeeb9400 00000000 c0a595d4 eeeb9410 ffffffed c150be9c fffffdfb
dde0: c150be9c c07efe10 eeeb9410 c1569c5c 00000000 00000000 c150be9c c07ee464
de00: 00000000 ee86de38 c07ee5c0 00000001 c1569c38 00000000 00000000 c07ec9bc
de20: ee806e6c ee8bd238 eeeb9410 eeeb9444 c14eff88 c07ee15c eeeb9410 00000001
de40: eeeb9410 eeeb9418 eeeb9410 c14eff88 00000000 c07ed798 eeeb9418 c14efde8
de60: eeeb9410 c07ebb7c c1312ba8 c05a1560 eeeb9400 eeeb9400 00000000 eeeb9400
de80: c1312ba8 c12a7834 eeeb9410 00000138 00000007 c07efb8c eeeb9400 ee86dec8
dea0: c1312ba8 c12a7834 00000000 c07f0568 00000000 ef7c8984 c1312ba8 c12a7834
dec0: 00000000 c127f9c0 00000000 00000000 c106a354 ffffffff 00000000 00000000
dee0: 00000000 00000001 00000000 00000000 00000000 00000000 c127f928 c127f938
df00: ffffe000 c0301e9c 00000000 c047321c c0d0b0c0 ee845a00 00000000 c1434064
df20: c10d75ec c0d1d0c0 00000138 c035c13c c105c458 c10d5d8c 00000000 00000006
df40: 00000006 c0f83374 c143404c c151d000 c151d000 00000006 c151d000 c151d000
df60: c1312ba8 c12a7834 c12a783c c1200dc4 00000006 00000006 00000000 c12005ac
df80: 00000000 00000000 c0c08f10 00000000 00000000 00000000 00000000 00000000
dfa0: 00000000 c0c08f18 00000000 c0307d38 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 2eeaeab0 aae2378a
[<c0a57188>] (cpufreq_online) from [<c0a5729c>] (cpufreq_add_dev+0xbc/0xcc)
[<c0a5729c>] (cpufreq_add_dev) from [<c07ecce4>] (subsys_interface_register+0x90/0xcc)
[<c07ecce4>] (subsys_interface_register) from [<c0a561c8>] (cpufreq_register_driver+0x15c/0x1dc)
[<c0a561c8>] (cpufreq_register_driver) from [<c0a595d4>] (dt_cpufreq_probe+0x88/0x10c)
[<c0a595d4>] (dt_cpufreq_probe) from [<c07efe10>] (platform_drv_probe+0x50/0xb0)
[<c07efe10>] (platform_drv_probe) from [<c07ee464>] (driver_probe_device+0x228/0x2c8)
[<c07ee464>] (driver_probe_device) from [<c07ec9bc>] (bus_for_each_drv+0x60/0x94)
[<c07ec9bc>] (bus_for_each_drv) from [<c07ee15c>] (__device_attach+0xb0/0x114)
[<c07ee15c>] (__device_attach) from [<c07ed798>] (bus_probe_device+0x84/0x8c)
[<c07ed798>] (bus_probe_device) from [<c07ebb7c>] (device_add+0x420/0x5b0)
[<c07ebb7c>] (device_add) from [<c07efb8c>] (platform_device_add+0x10c/0x220)
[<c07efb8c>] (platform_device_add) from [<c07f0568>] (platform_device_register_full+0xf8/0x114)
[<c07f0568>] (platform_device_register_full) from [<c127f9c0>] (cpufreq_dt_platdev_init+0x88/0x98)
[<c127f9c0>] (cpufreq_dt_platdev_init) from [<c0301e9c>] (do_one_initcall+0x44/0x16c)
[<c0301e9c>] (do_one_initcall) from [<c1200dc4>] (kernel_init_freeable+0x15c/0x1ec)
[<c1200dc4>] (kernel_init_freeable) from [<c0c08f18>] (kernel_init+0x8/0x114)
[<c0c08f18>] (kernel_init) from [<c0307d38>] (ret_from_fork+0x14/0x3c)
Code: e34c0106 e22aa001 ebe5e699 eafffef1 (e7f001f2)
---[ end trace 78633199f00384ae ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.439239]
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         4.9.0-rc8-next-20161207 #290
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c03104a4>] (unwind_backtrace) from [<c030ba50>] (show_stack+0x10/0x14)
[<c030ba50>] (show_stack) from [<c05a035c>] (dump_stack+0x88/0x9c)
[<c05a035c>] (dump_stack) from [<c030ec08>] (handle_IPI+0x174/0x194)
[<c030ec08>] (handle_IPI) from [<c03017c0>] (gic_handle_irq+0x94/0x98)
[<c03017c0>] (gic_handle_irq) from [<c030c5cc>] (__irq_svc+0x6c/0x90)
Exception stack(0xc1401f40 to 0xc1401f88)
1f40: 00000001 00000000 00000000 c031bae0 c1400000 c1403094 c1403034 c1317ed0
1f60: c1401f98 00000000 00000000 00000000 2e497000 c1401f90 c0308764 c0308768
1f80: 60000113 ffffffff
[<c030c5cc>] (__irq_svc) from [<c0308768>] (arch_cpu_idle+0x38/0x3c)
[<c0308768>] (arch_cpu_idle) from [<c037b07c>] (do_idle+0x164/0x1f8)
[<c037b07c>] (do_idle) from [<c037b388>] (cpu_startup_entry+0x18/0x1c)
[<c037b388>] (cpu_startup_entry) from [<c1200c5c>] (start_kernel+0x380/0x38c)
[<c1200c5c>] (start_kernel) from [<8020807c>] (0x8020807c)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
