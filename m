From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework (part 2)
Date: Mon, 27 Jun 2011 17:30:46 -0700
Message-ID: <87mxh23ih5.fsf@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50101 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755450Ab1F1Aaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 20:30:52 -0400
Received: by mail-pz0-f51.google.com with SMTP id 26so3483196pzk.38
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 17:30:50 -0700 (PDT)
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 27 Jun 2011 18:33:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

Hi Benoit,

Benoit Cousson <b-cousson@ti.com> writes:

> Here is the second part of the modulemode series. 
> The goal here is to do the cleanup on the clock nodes and PRCM macros
> that are not needed anymore by the hwmod data.
> Some macros are still needed because of clock data. It should be removed
> once the clock data will be cleaned.
>
> Moreover, in order to get rid of static clkdev, omap_device is trying to
> create dynamically an "fck" alias if a main_clk is defined in hwmod data.
>
> As usual, because of drivers non-adapted to pm_runtime, some temp hacks
> are needed for both MMC and timer1.
> If the drivers are fixes before these series, these temp patches could be
> dropped.
>
> The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
> are definitively needed.

Yes, more OMAP2/3 testing is needed.

I just posted a couple patches in response to this series for some
easy-to-fix boot problems for OMAP3, but it's still not booting for me
on OMAP3 (haven't tried OMAP2.)  I didn't debug this any further, but
wanted to report the problems. 

NOTE: I'm testing your for_3.0.1/6_hwmod_modulemode branch merged with
my PM branch.

With those couple patches I posted and '#define DEBUG' in omap_hwmod.c,
it seems to hang doing some SR hwmod activity on 3430/n900 and
3530/Overo:

[...]
[    5.950836] omap_hwmod: i2c1: enabling                                       
[    5.954803] omap_hwmod: i2c1: enabling clocks                                
[    5.959777] omap_hwmod: i2c1: idling                                         
[    5.963531] omap_hwmod: i2c1: disabling clocks                               
[    5.968353] omap_hwmod: i2c1: enabling                                       
[    5.972290] omap_hwmod: i2c1: enabling clocks                                
[    5.977081] omap_hwmod: i2c1: idling                                         
[    5.980865] omap_hwmod: i2c1: disabling clocks                               
[    5.987579] omap_hwmod: omap_hwmod_for_each_by_class: looking for modules of class smartreflex                                                               
[    5.996765] omap_hwmod: omap_hwmod_for_each_by_class: sr1_hwmod: calling callback fn                                                                         
[    6.006500] omap_hwmod: omap_hwmod_for_each_by_class: sr2_hwmod: calling callback fn                                                                         

but on 3630/Zoom3, it hang in GPIO triggering (although both are hanging
right after some I2C activity):

[...]
[    5.707672] omap_hwmod: i2c1: enabling
[    5.711425] omap_hwmod: i2c1: enabling clocks
[    5.716003] omap_hwmod: i2c1: idling
[    5.719573] omap_hwmod: i2c1: disabling clocks
[    5.724090] omap_hwmod: i2c1: enabling
[    5.727844] omap_hwmod: i2c1: enabling clocks
[    5.732604] omap_hwmod: i2c1: idling
[    5.736206] omap_hwmod: i2c1: disabling clocks
[    5.740783] twl_rtc twl_rtc: setting system clock to 2000-03-09 00:38:08 UTC (952562288)
[    5.751129] IP-Config: Failed to open eth0
[    5.755249] IP-Config: No network devices available.
[    5.762634] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb054040
[    5.770324] Internal error: : 1028 [#1] SMP
[    5.774505] Modules linked in:
[    5.777557] CPU: 0    Not tainted  (3.0.0-rc4-pm+initramfs+debug+cmdline-14171-gbcb3984-dirty #10)
[    5.786560] PC is at _set_gpio_triggering+0x38/0x198
[    5.791534] LR is at _set_gpio_triggering+0x2c/0x198
[    5.796508] pc : [<c047dda8>]    lr : [<c047dd9c>]    psr: 80000093
[    5.796508] sp : c7825cd0  ip : c09249dc  fp : c7242000
[    5.807983] r10: 00000066  r9 : 00000002  r8 : c787ba28
[    5.813232] r7 : 00000040  r6 : 00000001  r5 : fb054000  r4 : c787ba28
[    5.819763] r3 : c0870708  r2 : 00000001  r1 : 00000006  r0 : 00000034
[    5.826293] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    5.833679] Control: 10c5387d  Table: 87238019  DAC: 00000017
[    5.839447] Process swapper (pid: 1, stack limit = 0xc78242f8)
[    5.845275] Stack: (0xc7825cd0 to 0xc7826000)
[    5.849639] 5cc0:                                     00000060 00000001 c07fe5c0 c787ba5c
[    5.857818] 5ce0: 60000093 c047e780 00000001 c07fe5c0 c047e6d8 00000000 c0853c24 00000106
[    5.866027] 5d00: 00000001 c02df938 00000001 c724fc20 c07fe5c0 00000106 00000000 c07fe60c
[    5.874206] 5d20: 60000013 c02dfd00 000080d0 c03372e0 60000093 00000006 c7237ba0 c7237ba0
[    5.882385] 5d40: c04b7ea8 00000000 00000106 c07fe5c0 c724fc20 c02dfe14 c78233c0 00000081
[    5.890594] 5d60: 00000000 c7237ba0 c0db96a8 00000000 c7237bac c0db97a8 00000080 c04b72e8
[    5.898773] 5d80: c0763fcc c7237ba0 20000013 c0db96a8 00000002 20000013 00000002 c7242120
[    5.906951] 5da0: 00000000 c04b76a4 c7980000 c0db96a8 00000000 c7242000 c7242120 c04b2d18
[    5.915161] 5dc0: 00000001 c7980000 c7242000 c79800b0 c7848e60 c7824000 c08556b0 c04b3c30
[    5.923339] 5de0: 00000000 00500001 c7848e60 00000001 c7824000 c049c24c c084c858 c74eddb0
[    5.931518] 5e00: 00000001 00000000 c0db854c 00000000 c0db8520 00000000 c74eddb0 00000000
[    5.939727] 5e20: 00000000 c7848e60 c033dd58 c033de48 00000000 00000000 00000000 c7848e60
[    5.947906] 5e40: c74ec6c0 c74eddb0 00000000 00000000 c7814940 c0338680 00000000 c781c820
[    5.956085] 5e60: 00000000 c7848e60 c7825f38 00000000 00000000 00000000 00000000 c03395c8
[    5.964263] 5e80: c781c820 00000002 00000000 c7825f38 00000002 00000000 00000026 c03474dc
[    5.972473] 5ea0: c79f8005 00000000 00000000 c7814940 c74ec800 c74eddb0 c03458f8 c7825f38
[    5.980651] 5ec0: c7825fb8 00000000 c7825efc c7824000 00000000 00000000 00000000 c03478c4
[    5.988830] 5ee0: c7825f04 00000000 00000000 00000002 00000000 00000000 00000000 c7814940
[    5.997039] 5f00: c74ec6c0 00000000 c781eeb0 c7825fb8 00000001 c79f8000 ffffff9c ffffff9c
[    6.005218] 5f20: 00000000 00000000 00000000 c0347c10 00000041 c03537fc c7814940 c74ec6c0
[    6.013397] 5f40: 05b6719b 00000007 c79f8005 00000000 c7401940 c74eddb0 00000101 00000004
[    6.021606] 5f60: 00000000 00000000 00000000 c781eea0 c781ee68 00000000 c781eea0 00000002
[    6.029785] 5f80: 00000000 c781ee60 c781ee68 00000003 00000000 00000000 c025afe0 c79f8000
[    6.037963] 5fa0: 00000002 00000000 00000001 c03396ac 00000000 3539b9a0 00000002 00000000
[    6.046173] 5fc0: 00000026 00000100 c00351ec c00351ec c00351ec c025afe0 00000013 00000000
[    6.054351] 5fe0: 00000000 c0008b68 00000004 00000000 c0008ac8 c025afe0 ffbfffff ffffffff
[    6.062561] [<c047dda8>] (_set_gpio_triggering+0x38/0x198) from [<c047e780>] (gpio_irq_type+0xa8/0x144)
[    6.071960] [<c047e780>] (gpio_irq_type+0xa8/0x144) from [<c02df938>] (__irq_set_trigger+0x5c/0xfc)
[    6.081024] [<c02df938>] (__irq_set_trigger+0x5c/0xfc) from [<c02dfd00>] (__setup_irq+0x328/0x36c)
[    6.090026] [<c02dfd00>] (__setup_irq+0x328/0x36c) from [<c02dfe14>] (request_threaded_irq+0xd0/0x12c)
[    6.099334] [<c02dfe14>] (request_threaded_irq+0xd0/0x12c) from [<c04b72e8>] (serial_link_irq_chain+0x12c/0x250)
[    6.109527] [<c04b72e8>] (serial_link_irq_chain+0x12c/0x250) from [<c04b76a4>] (serial8250_startup+0x298/0x700)
[    6.119659] [<c04b76a4>] (serial8250_startup+0x298/0x700) from [<c04b2d18>] (uart_startup+0x5c/0x1ac)
[    6.128875] [<c04b2d18>] (uart_startup+0x5c/0x1ac) from [<c04b3c30>] (uart_open+0xf8/0x174)
[    6.137268] [<c04b3c30>] (uart_open+0xf8/0x174) from [<c049c24c>] (tty_open+0x150/0x3d8)
[    6.145355] [<c049c24c>] (tty_open+0x150/0x3d8) from [<c033de48>] (chrdev_open+0xf0/0x1e4)
[    6.153656] [<c033de48>] (chrdev_open+0xf0/0x1e4) from [<c0338680>] (__dentry_open+0x168/0x2ec)
[    6.162384] [<c0338680>] (__dentry_open+0x168/0x2ec) from [<c03395c8>] (nameidata_to_filp+0x60/0x68)
[    6.171539] [<c03395c8>] (nameidata_to_filp+0x60/0x68) from [<c03474dc>] (do_last.clone.15+0x2c8/0x574)
[    6.180938] [<c03474dc>] (do_last.clone.15+0x2c8/0x574) from [<c03478c4>] (path_openat+0xb8/0x3d8)
[    6.189910] [<c03478c4>] (path_openat+0xb8/0x3d8) from [<c0347c10>] (do_filp_open+0x2c/0x80)
[    6.198364] [<c0347c10>] (do_filp_open+0x2c/0x80) from [<c03396ac>] (do_sys_open+0xdc/0x178)
[    6.206817] [<c03396ac>] (do_sys_open+0xdc/0x178) from [<c0008b68>] (kernel_init+0xa0/0x134)
[    6.215270] [<c0008b68>] (kernel_init+0xa0/0x134) from [<c025afe0>] (kernel_thread_exit+0x0/0x8)
[    6.224090] Code: ebf7a61c e6ef0070 e3500044 0a00003c (e5953040) 
[    6.230194] ------------[ cut here ]------------
[    6.234832] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0x108/0x164()
[    6.245086] In-band Error seen by MPU  at address 0
[    6.249969] Modules linked in:
[    6.253051] [<c0261218>] (unwind_backtrace+0x0/0xf0) from [<c02978f8>] (warn_slowpath_common+0x4c/0x64)
[    6.262481] [<c02978f8>] (warn_slowpath_common+0x4c/0x64) from [<c02979a4>] (warn_slowpath_fmt+0x30/0x40)
[    6.272064] [<c02979a4>] (warn_slowpath_fmt+0x30/0x40) from [<c0277b28>] (omap3_l3_app_irq+0x108/0x164)
[    6.281463] [<c0277b28>] (omap3_l3_app_irq+0x108/0x164) from [<c02de900>] (handle_irq_event_percpu+0x5c/0x22c)
[    6.291503] [<c02de900>] (handle_irq_event_percpu+0x5c/0x22c) from [<c02deb0c>] (handle_irq_event+0x3c/0x5c)
[    6.301330] [<c02deb0c>] (handle_irq_event+0x3c/0x5c) from [<c02e0948>] (handle_level_irq+0xac/0x130)
[    6.310577] [<c02e0948>] (handle_level_irq+0xac/0x130) from [<c02de218>] (generic_handle_irq+0x30/0x48)
[    6.319976] [<c02de218>] (generic_handle_irq+0x30/0x48) from [<c024f04c>] (asm_do_IRQ+0x4c/0xac)
[    6.328796] [<c024f04c>] (asm_do_IRQ+0x4c/0xac) from [<c064c9dc>] (__irq_svc+0x3c/0x120)
[    6.336883] Exception stack(0xc7825b80 to 0xc7825bc8)
[    6.341949] 5b80: c064c6e0 00000001 00000000 c7824000 c080a238 c7825c88 00000001 00001028
[    6.350128] 5ba0: c080a4b4 00000193 00000066 c7242000 00000000 c7825bc8 c064c6e0 c064c6e4
[    6.358337] 5bc0: 60000113 ffffffff
[    6.361816] [<c064c9dc>] (__irq_svc+0x3c/0x120) from [<c064c6e4>] (_raw_spin_unlock_irq+0x28/0x2c)
[    6.370788] [<c064c6e4>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c025e100>] (die+0x8c/0xfc)
[    6.379180] [<c025e100>] (die+0x8c/0xfc) from [<c024f418>] (do_DataAbort+0x8c/0x9c)
[    6.386840] [<c024f418>] (do_DataAbort+0x8c/0x9c) from [<c064c974>] (__dabt_svc+0x54/0x80)
[    6.395111] Exception stack(0xc7825c88 to 0xc7825cd0)
[    6.400177] 5c80:                   00000034 00000006 00000001 c0870708 c787ba28 fb054000
[    6.408355] 5ca0: 00000001 00000040 c787ba28 00000002 00000066 c7242000 c09249dc c7825cd0
[    6.416534] 5cc0: c047dd9c c047dda8 80000093 ffffffff
[    6.421600] [<c064c974>] (__dabt_svc+0x54/0x80) from [<c047dda8>] (_set_gpio_triggering+0x38/0x198)
[    6.430664] [<c047dda8>] (_set_gpio_triggering+0x38/0x198) from [<c047e780>] (gpio_irq_type+0xa8/0x144)
[    6.440093] [<c047e780>] (gpio_irq_type+0xa8/0x144) from [<c02df938>] (__irq_set_trigger+0x5c/0xfc)
[    6.449157] [<c02df938>] (__irq_set_trigger+0x5c/0xfc) from [<c02dfd00>] (__setup_irq+0x328/0x36c)
[    6.458129] [<c02dfd00>] (__setup_irq+0x328/0x36c) from [<c02dfe14>] (request_threaded_irq+0xd0/0x12c)
[    6.467468] [<c02dfe14>] (request_threaded_irq+0xd0/0x12c) from [<c04b72e8>] (serial_link_irq_chain+0x12c/0x250)
[    6.477661] [<c04b72e8>] (serial_link_irq_chain+0x12c/0x250) from [<c04b76a4>] (serial8250_startup+0x298/0x700)
[    6.487762] [<c04b76a4>] (serial8250_startup+0x298/0x700) from [<c04b2d18>] (uart_startup+0x5c/0x1ac)
[    6.496978] [<c04b2d18>] (uart_startup+0x5c/0x1ac) from [<c04b3c30>] (uart_open+0xf8/0x174)
[    6.505371] [<c04b3c30>] (uart_open+0xf8/0x174) from [<c049c24c>] (tty_open+0x150/0x3d8)
[    6.513458] [<c049c24c>] (tty_open+0x150/0x3d8) from [<c033de48>] (chrdev_open+0xf0/0x1e4)
[    6.521759] [<c033de48>] (chrdev_open+0xf0/0x1e4) from [<c0338680>] (__dentry_open+0x168/0x2ec)
[    6.530456] [<c0338680>] (__dentry_open+0x168/0x2ec) from [<c03395c8>] (nameidata_to_filp+0x60/0x68)
[    6.539611] [<c03395c8>] (nameidata_to_filp+0x60/0x68) from [<c03474dc>] (do_last.clone.15+0x2c8/0x574)
[    6.549041] [<c03474dc>] (do_last.clone.15+0x2c8/0x574) from [<c03478c4>] (path_openat+0xb8/0x3d8)
[    6.558013] [<c03478c4>] (path_openat+0xb8/0x3d8) from [<c0347c10>] (do_filp_open+0x2c/0x80)
[    6.566467] [<c0347c10>] (do_filp_open+0x2c/0x80) from [<c03396ac>] (do_sys_open+0xdc/0x178)
[    6.574920] [<c03396ac>] (do_sys_open+0xdc/0x178) from [<c0008b68>] (kernel_init+0xa0/0x134)
[    6.583374] [<c0008b68>] (kernel_init+0xa0/0x134) from [<c025afe0>] (kernel_thread_exit+0x0/0x8)
[    6.592163] ---[ end trace a7607918ffc5bc16 ]---
[    6.596893] ---[ end trace a7607918ffc5bc17 ]---
[    6.601593] Kernel panic - not syncing: Attempted to kill init!


Kevin
