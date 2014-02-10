From: Kevin Hilman <khilman@linaro.org>
Subject: Re: next boot: 36 pass, 3 fail (next-20140210)
Date: Mon, 10 Feb 2014 08:33:21 -0800
Message-ID: <CAGa+x84du+1Xcs=is+ehjvM3CGp9yT6jmBrgaeYx=-B0dXT3bA@mail.gmail.com>
References: <52f8f712.626d440a.6fab.5ae1@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59926 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaBJQdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 11:33:22 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so11006110qcy.12
        for <linux-omap@vger.kernel.org>; Mon, 10 Feb 2014 08:33:21 -0800 (PST)
In-Reply-To: <52f8f712.626d440a.6fab.5ae1@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

+linux-omap list

On Mon, Feb 10, 2014 at 7:58 AM, Kevin's boot bot <khilman@linaro.org> wrote:
> Automated DT boot report for various ARM defconfigs.
>
>
> Tree/Branch: next
> Git describe: next-20140210
> Failed boot tests (console logs at the end)
> ===========================================
>              omap3-beagle-xm:     FAIL:    multi_v7_defconfig
>                   omap3-tobi:     FAIL:    multi_v7_defconfig
>               omap4-panda-es:     FAIL:    multi_v7_defconfig

These are all new OMAP failures, and appear to be an EHCI panic during
boot.  Note that omap2plus_defconfig boots fine on all these boards,
this failure is only for multi_v7_defconfig.

Not sure if anyone else has seen this yet.

Kevin

[...]

> Console logs for failures
> =========================
>
> multi_v7_defconfig
> ------------------
>
>         omap3-beagle-xm: FAIL: last 80 lines of boot log:
>         -------------------------------------------------
>
> [    1.710632] 9e20: 00000000 de214810 de68c800 c0927e58 de217680 c03e0c68 c07654b4 de68cb7c
> [    1.719207] 9e40: 00000000 0000005d 000000df de214810 c0927e84 00000000 c0927e84 c0861b20
> [    1.727783] 9e60: 000000df de0c8030 00000000 c030676c c0306754 de214810 c098e4cc c0304fc8
> [    1.736358] 9e80: 00000000 de214810 c0927e84 de214844 00000000 c03051b4 00000000 c0927e84
> [    1.744934] 9ea0: c0305128 c03035e0 de00c85c de2181b4 c0927e84 de67fb80 c091d3c0 c0304790
> [    1.753479] 9ec0: c0788444 de0c9edc c0927e84 c0927e84 00000006 c0952f00 c0952f00 c03057b8
> [    1.762054] 9ee0: c0306198 c08a58dc 00000006 c0008bbc de009480 c0730330 de0f4880 c05a8de8
> [    1.770629] 9f00: 00000000 c0952f00 c082750c c012e9a4 00000000 c08ec6d8 60000153 00000001
> [    1.779205] 9f20: dfeff153 c05b85f8 000000df c005d83c c07f19b0 00000006 dfeff1a1 00000006
> [    1.787750] 9f40: c08ec6c8 c08a58dc 00000006 c0952f00 c0952f00 c082750c 000000df c0887f34
> [    1.796325] 9f60: c0887f28 c0827c48 00000006 00000006 c082750c 45870402 00008e00 05601080
> [    1.804901] 9f80: 08008c40 00000000 c0597d44 00000000 00000000 00000000 00000000 00000000
> [    1.813476] 9fa0: 00000000 c0597d4c 00000000 c000e5b8 00000000 00000000 00000000 00000000
> [    1.822021] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.830596] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 0d094204 00041010
> [    1.839172] [<c03dd368>] (ehci_setup) from [<c03e0f3c>] (ehci_platform_reset+0x8c/0xc0)
> [    1.847564] [<c03e0f3c>] (ehci_platform_reset) from [<c03c77c0>] (usb_add_hcd+0x1b0/0x714)
> [    1.856231] [<c03c77c0>] (usb_add_hcd) from [<c03e0c68>] (ehci_platform_probe+0x168/0x3b0)
> [    1.864898] [<c03e0c68>] (ehci_platform_probe) from [<c030676c>] (platform_drv_probe+0x18/0x48)
> [    1.874023] [<c030676c>] (platform_drv_probe) from [<c0304fc8>] (driver_probe_device+0x124/0x240)
> [    1.883331] [<c0304fc8>] (driver_probe_device) from [<c03051b4>] (__driver_attach+0x8c/0x90)
> [    1.892181] [<c03051b4>] (__driver_attach) from [<c03035e0>] (bus_for_each_dev+0x60/0x94)
> [    1.900756] [<c03035e0>] (bus_for_each_dev) from [<c0304790>] (bus_add_driver+0x148/0x1f0)
> [    1.909393] [<c0304790>] (bus_add_driver) from [<c03057b8>] (driver_register+0x78/0xf8)
> [    1.917785] [<c03057b8>] (driver_register) from [<c0008bbc>] (do_one_initcall+0xf8/0x144)
> [    1.926361] [<c0008bbc>] (do_one_initcall) from [<c0827c48>] (kernel_init_freeable+0x13c/0x1dc)
> [    1.935485] [<c0827c48>] (kernel_init_freeable) from [<c0597d4c>] (kernel_init+0x8/0xf0)
> [    1.943969] [<c0597d4c>] (kernel_init) from [<c000e5b8>] (ret_from_fork+0x14/0x3c)
> [    1.951904] Code: e1a04000 e24dd008 e2806e13 e59031cc (e5932000)
> [    1.958312] ---[ end trace 1b1cb8cc8ee0b223 ]---
> [    1.963195] In-band Error seen by MPU  at address 0
> [    1.968292] ------------[ cut here ]------------
> [    1.973144] WARNING: CPU: 0 PID: 1 at /home/build/work/batch/drivers/bus/omap_l3_smx.c:162 omap3_l3_app_irq+0xe4/0x118()
> [    1.984527] Modules linked in:
> [    1.987731] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D      3.14.0-rc1-next-20140210 #1
> [    1.996582] [<c001588c>] (unwind_backtrace) from [<c001143c>] (show_stack+0x10/0x14)
> [    2.004699] [<c001143c>] (show_stack) from [<c059d8d0>] (dump_stack+0x84/0x94)
> [    2.012298] [<c059d8d0>] (dump_stack) from [<c0044630>] (warn_slowpath_common+0x6c/0x88)
> [    2.020782] [<c0044630>] (warn_slowpath_common) from [<c00446e8>] (warn_slowpath_null+0x1c/0x24)
> [    2.029998] [<c00446e8>] (warn_slowpath_null) from [<c021a8d0>] (omap3_l3_app_irq+0xe4/0x118)
> [    2.038940] [<c021a8d0>] (omap3_l3_app_irq) from [<c0081d64>] (handle_irq_event_percpu+0x54/0x180)
> [    2.048309] [<c0081d64>] (handle_irq_event_percpu) from [<c0081ed0>] (handle_irq_event+0x40/0x60)
> [    2.057617] [<c0081ed0>] (handle_irq_event) from [<c008476c>] (handle_level_irq+0x94/0x108)
> [    2.066375] [<c008476c>] (handle_level_irq) from [<c008152c>] (generic_handle_irq+0x2c/0x3c)
> [    2.075225] [<c008152c>] (generic_handle_irq) from [<c000edfc>] (handle_IRQ+0x40/0x90)
> [    2.083496] [<c000edfc>] (handle_IRQ) from [<c0008648>] (omap3_intc_handle_irq+0x68/0x74)
> [    2.092071] [<c0008648>] (omap3_intc_handle_irq) from [<c0011fc0>] (__irq_svc+0x40/0x50)
> [    2.100555] Exception stack(0xde0c9be8 to 0xde0c9c30)
> [    2.105834] 9be0:                   c08ec998 de0c9c40 00000000 0000c998 0000000b de0c9d90
> [    2.114410] 9c00: de0c8000 0000000b de0c8030 00000000 de0c2000 de0c2000 00000000 de0c9c30
> [    2.122985] 9c20: c0045854 c0045e08 60000113 ffffffff
> [    2.128265] [<c0011fc0>] (__irq_svc) from [<c0045e08>] (do_exit+0x8a8/0x8d4)
> [    2.135650] [<c0045e08>] (do_exit) from [<c0011840>] (die+0x400/0x418)
> [    2.142517] [<c0011840>] (die) from [<c0008430>] (do_DataAbort+0x94/0x98)
> [    2.149627] [<c0008430>] (do_DataAbort) from [<c0011f58>] (__dabt_svc+0x38/0x60)
> [    2.157379] Exception stack(0xde0c9d90 to 0xde0c9dd8)
> [    2.162658] 9d80:                                     de68c800 00000000 fa064800 fa064800
> [    2.171234] 9da0: de68c800 c0927e58 de68c930 0000005d 00000080 c09275e0 00000001 00000000
> [    2.179809] 9dc0: 00000000 de0c9dd8 c03e0f3c c03dd368 60000113 ffffffff
> [    2.186737] [<c0011f58>] (__dabt_svc) from [<c03dd368>] (ehci_setup+0x14/0x424)
> [    2.194396] [<c03dd368>] (ehci_setup) from [<c03e0f3c>] (ehci_platform_reset+0x8c/0xc0)
> [    2.202789] [<c03e0f3c>] (ehci_platform_reset) from [<c03c77c0>] (usb_add_hcd+0x1b0/0x714)
> [    2.211456] [<c03c77c0>] (usb_add_hcd) from [<c03e0c68>] (ehci_platform_probe+0x168/0x3b0)
> [    2.220123] [<c03e0c68>] (ehci_platform_probe) from [<c030676c>] (platform_drv_probe+0x18/0x48)
> [    2.229217] [<c030676c>] (platform_drv_probe) from [<c0304fc8>] (driver_probe_device+0x124/0x240)
> [    2.238525] [<c0304fc8>] (driver_probe_device) from [<c03051b4>] (__driver_attach+0x8c/0x90)
> [    2.247375] [<c03051b4>] (__driver_attach) from [<c03035e0>] (bus_for_each_dev+0x60/0x94)
> [    2.255950] [<c03035e0>] (bus_for_each_dev) from [<c0304790>] (bus_add_driver+0x148/0x1f0)
> [    2.264587] [<c0304790>] (bus_add_driver) from [<c03057b8>] (driver_register+0x78/0xf8)
> [    2.272979] [<c03057b8>] (driver_register) from [<c0008bbc>] (do_one_initcall+0xf8/0x144)
> [    2.281555] [<c0008bbc>] (do_one_initcall) from [<c0827c48>] (kernel_init_freeable+0x13c/0x1dc)
> [    2.290679] [<c0827c48>] (kernel_init_freeable) from [<c0597d4c>] (kernel_init+0x8/0xf0)
> [    2.299163] [<c0597d4c>] (kernel_init) from [<c000e5b8>] (ret_from_fork+0x14/0x3c)
> [    2.307067] ---[ end trace 1b1cb8cc8ee0b224 ]---
> [    2.312011] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    2.312011]
> ~$off
> # PYBOOT: Exception: kernel: ERROR: failed to boot: Kernel panic
> # PYBOOT: Time: 40.38 seconds.
> # PYBOOT: Result: FAIL
>
>
>         omap3-tobi: FAIL: last 80 lines of boot log:
>         --------------------------------------------
>
> [    2.021392] 9e20: 00000000 de20c810 de68b000 c0927e58 de20e6c0 c03e0c68 c07654b4 de68b37c
> [    2.029998] 9e40: 00000000 0000005d 000000df de20c810 c0927e84 00000000 c0927e84 c0861b20
> [    2.038574] 9e60: 000000df de0c8030 00000000 c030676c c0306754 de20c810 c098e4cc c0304fc8
> [    2.047180] 9e80: 00000000 de20c810 c0927e84 de20c844 00000000 c03051b4 00000000 c0927e84
> [    2.055786] 9ea0: c0305128 c03035e0 de00c85c de20f5b4 c0927e84 de67c380 c091d3c0 c0304790
> [    2.064392] 9ec0: c0788444 de0c9edc c0927e84 c0927e84 00000006 c0952f00 c0952f00 c03057b8
> [    2.072967] 9ee0: c0306198 c08a58dc 00000006 c0008bbc de009480 c0730330 de0f2e80 c05a8de8
> [    2.081573] 9f00: 00000000 c0952f00 c082750c c012e9a4 00000000 c08ec6d8 60000153 00000001
> [    2.090179] 9f20: dfeff199 c05b85f8 000000df c005d83c c07f19b0 00000006 dfeff1e7 00000006
> [    2.098754] 9f40: c08ec6c8 c08a58dc 00000006 c0952f00 c0952f00 c082750c 000000df c0887f34
> [    2.107360] 9f60: c0887f28 c0827c48 00000006 00000006 c082750c 22104000 00000000 120a4080
> [    2.115966] 9f80: 20004080 00000000 c0597d44 00000000 00000000 00000000 00000000 00000000
> [    2.124542] 9fa0: 00000000 c0597d4c 00000000 c000e5b8 00000000 00000000 00000000 00000000
> [    2.133148] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.141754] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 04503418 04900002
> [    2.150360] [<c03dd368>] (ehci_setup) from [<c03e0f3c>] (ehci_platform_reset+0x8c/0xc0)
> [    2.158782] [<c03e0f3c>] (ehci_platform_reset) from [<c03c77c0>] (usb_add_hcd+0x1b0/0x714)
> [    2.167480] [<c03c77c0>] (usb_add_hcd) from [<c03e0c68>] (ehci_platform_probe+0x168/0x3b0)
> [    2.176177] [<c03e0c68>] (ehci_platform_probe) from [<c030676c>] (platform_drv_probe+0x18/0x48)
> [    2.185333] [<c030676c>] (platform_drv_probe) from [<c0304fc8>] (driver_probe_device+0x124/0x240)
> [    2.194671] [<c0304fc8>] (driver_probe_device) from [<c03051b4>] (__driver_attach+0x8c/0x90)
> [    2.203521] [<c03051b4>] (__driver_attach) from [<c03035e0>] (bus_for_each_dev+0x60/0x94)
> [    2.212127] [<c03035e0>] (bus_for_each_dev) from [<c0304790>] (bus_add_driver+0x148/0x1f0)
> [    2.220825] [<c0304790>] (bus_add_driver) from [<c03057b8>] (driver_register+0x78/0xf8)
> [    2.229248] [<c03057b8>] (driver_register) from [<c0008bbc>] (do_one_initcall+0xf8/0x144)
> [    2.237854] [<c0008bbc>] (do_one_initcall) from [<c0827c48>] (kernel_init_freeable+0x13c/0x1dc)
> [    2.247009] [<c0827c48>] (kernel_init_freeable) from [<c0597d4c>] (kernel_init+0x8/0xf0)
> [    2.255523] [<c0597d4c>] (kernel_init) from [<c000e5b8>] (ret_from_fork+0x14/0x3c)
> [    2.263488] Code: e1a04000 e24dd008 e2806e13 e59031cc (e5932000)
> [    2.269897] ---[ end trace 6b818411fe0fe3f8 ]---
> [    2.274780] In-band Error seen by MPU  at address 0
> [    2.279907] ------------[ cut here ]------------
> [    2.284759] WARNING: CPU: 0 PID: 1 at /home/build/work/batch/drivers/bus/omap_l3_smx.c:162 omap3_l3_app_irq+0xe4/0x118()
> [    2.296203] Modules linked in:
> [    2.299407] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D W    3.14.0-rc1-next-20140210 #1
> [    2.308288] [<c001588c>] (unwind_backtrace) from [<c001143c>] (show_stack+0x10/0x14)
> [    2.316436] [<c001143c>] (show_stack) from [<c059d8d0>] (dump_stack+0x84/0x94)
> [    2.324066] [<c059d8d0>] (dump_stack) from [<c0044630>] (warn_slowpath_common+0x6c/0x88)
> [    2.332580] [<c0044630>] (warn_slowpath_common) from [<c00446e8>] (warn_slowpath_null+0x1c/0x24)
> [    2.341796] [<c00446e8>] (warn_slowpath_null) from [<c021a8d0>] (omap3_l3_app_irq+0xe4/0x118)
> [    2.350799] [<c021a8d0>] (omap3_l3_app_irq) from [<c0081d64>] (handle_irq_event_percpu+0x54/0x180)
> [    2.360198] [<c0081d64>] (handle_irq_event_percpu) from [<c0081ed0>] (handle_irq_event+0x40/0x60)
> [    2.369537] [<c0081ed0>] (handle_irq_event) from [<c008476c>] (handle_level_irq+0x94/0x108)
> [    2.378326] [<c008476c>] (handle_level_irq) from [<c008152c>] (generic_handle_irq+0x2c/0x3c)
> [    2.387207] [<c008152c>] (generic_handle_irq) from [<c000edfc>] (handle_IRQ+0x40/0x90)
> [    2.395538] [<c000edfc>] (handle_IRQ) from [<c0008
