From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4: support for manually updated display
Date: Mon, 22 Oct 2018 09:31:34 -0700
Message-ID: <20181022163134.GF43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
 <20181020003812.GE43338@atomide.com>
 <6ebd84ad-3428-c2f5-da8b-e5b1c54ea5e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ebd84ad-3428-c2f5-da8b-e5b1c54ea5e2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [181022 08:14]:
> On 20/10/18 03:38, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@kernel.org> [181019 15:58]:
> >> I uploaded my current status here. It's not based on the newest
> >> -next, but contains the interesting patches from Laurent. Also
> >> the last few patches are not yet cleaned up, sorry for the mess.
> > 
> > Way to go, thanks :) Here's a quick fix for issues with loading
> > and unloading modules, seems like this should be fixed somewhere
> > else though?

Sorry one oops was for rmmod, the other one was for modprobe.

> I didn't get that far on drm-next with pandaboard. When loading modules, dsi_probe crashes. It is missing runtime_get(). But after adding runtime_get call, it fails and I see:
> 
> [   44.671081] omap_hwmod: dss_dsi2: _wait_target_ready failed: -16
> [   44.677459] omapdss_dsi 58005000.encoder: use pm_runtime_put_sync_suspend() in driver?
> 
> Why is dsi2 busy (and what does it even mean)...

Hmm below segfault is what I see on pandaboard-es with
next-20181019 with no extra patches.

Regards,

Tony


[   24.842620] omapdss_dss 58000000.dss: 58000000.dss supply vdda_video not found, using dummy regulator
[   24.851959] omapdss_dss 58000000.dss: Linked as a consumer to regulator.0
[   24.859497] omapdss_dss 58000000.dss: Dropping the link to regulator.0
[   24.869628] omapdss_dss 58000000.dss: 58000000.dss supply vdda_video not found, using dummy regulator
[   24.877441] omapdss_dsi 58005000.encoder: Linked as a consumer to regulator.14
[   24.886932] omapdss_dss 58000000.dss: Linked as a consumer to regulator.0
[   24.886932] ------------[ cut here ]------------
[   24.886932] omapdss_dss 58000000.dss: Dropping the link to regulator.0
[   24.898498] WARNING: CPU: 0 PID: 508 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x2dc/0x36c
[   24.898498] 44000000.ocp:L3 Standard Error: MASTER MPU TARGET DSS (Read Link): At Address: 0x00005044 : Data Access in User mo
de during Functional access
[   24.898498] Modules linked in: omapdss(+) drm drm_panel_orientation_quirks omapdss_base cec cfbimgblt cfbfillrect cfbcopyarea
gpio_pca953x hid_generic usbhid smsc95xx smsc75xx usbnet usb_f_acm u_ether usb_f_mass_storage usb_f_serial u_serial xhci_plat_hcd
 xhci_hcd dwc3_omap dwc3 ohci_hcd ehci_hcd phy_omap_usb2 phy_generic libcomposite udc_core snd_soc_simple_card snd_soc_simple_car
d_utils snd_usb_audio snd_usbmidi_lib usbcore usb_common snd_soc_omap_mcbsp snd_soc_omap_dmic snd_soc_omap_twl4030 snd_soc_dmic s
nd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_sdma snd_soc_twl6040 snd_soc_twl4030 snd_soc_core snd_hwdep snd_pcm_dmaengine
snd_pcm snd_timer snd_rawmidi snd soundcore rtc_ds1307 rtc_palmas rtc_twl palmas_pwrbutton extcon_palmas cpufreq_dt ti_soc_therma
l thermal_sys hwmon clk_palmas lib80211 ccm
[   24.999755] CPU: 0 PID: 508 Comm: modprobe Not tainted 4.19.0-rc8-next-20181019 #976
[   25.007537] Hardware name: Generic OMAP4 (Flattened Device Tree)
[   25.007537] [<c01129a8>] (unwind_backtrace) from [<c010d040>] (show_stack+0x10/0x14)
[   25.021392] [<c010d040>] (show_stack) from [<c08e91ac>] (dump_stack+0xb0/0xe8)
[   25.022827] [<c08e91ac>] (dump_stack) from [<c013a3b4>] (__warn.part.3+0xa8/0xe8)
[   25.032867] [<c013a3b4>] (__warn.part.3) from [<c013a450>] (warn_slowpath_fmt+0x5c/0x88)
[   25.042724] [<c013a450>] (warn_slowpath_fmt) from [<c053ec54>] (l3_interrupt_handler+0x2dc/0x36c)
[   25.052764] [<c053ec54>] (l3_interrupt_handler) from [<c01b13b4>] (__handle_irq_event_percpu+0x44/0x358)
[   25.062774] [<c01b13b4>] (__handle_irq_event_percpu) from [<c01b16f0>] (handle_irq_event_percpu+0x28/0x80)
[   25.062866] [<c01b16f0>] (handle_irq_event_percpu) from [<c01b1780>] (handle_irq_event+0x38/0x5c)
[   25.081420] [<c01b1780>] (handle_irq_event) from [<c01b50f8>] (handle_fasteoi_irq+0xbc/0x174)
[   25.082885] [<c01b50f8>] (handle_fasteoi_irq) from [<c01b05e8>] (generic_handle_irq+0x20/0x34)
[   25.092773] [<c01b05e8>] (generic_handle_irq) from [<c01b0be0>] (__handle_domain_irq+0x64/0xe0)
[   25.102813] [<c01b0be0>] (__handle_domain_irq) from [<c053d0cc>] (gic_handle_irq+0x4c/0xa8)
[   25.115814] [<c053d0cc>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0x98)
[   25.122741] Exception stack(0xed993c60 to 0xed993ca8)
[   25.128417] 3c60: eebeb810 00000001 00000001 bf4795a8 eda79010 eda7b480 eebeb800 eebeb810
[   25.132751] 3c80: eda79484 bf47f160 0000002a bf477048 00000001 ed993cb0 c01a3cd4 bf46b850
[   25.144866] 3ca0: 20000013 ffffffff
[   25.144866] [<c01019f0>] (__irq_svc) from [<bf46b850>] (dsi_probe+0x428/0x60c [omapdss])
[   25.152770] [<bf46b850>] (dsi_probe [omapdss]) from [<c0604184>] (platform_drv_probe+0x48/0x98)
[   25.165557] [<c0604184>] (platform_drv_probe) from [<c0602134>] (really_probe+0x1dc/0x2d0)
[   25.172851] [<c0602134>] (really_probe) from [<c0602388>] (driver_probe_device+0x5c/0x164)
[   25.172851] [<c0602388>] (driver_probe_device) from [<c0602574>] (__driver_attach+0xe4/0xe8)
[   25.182800] [<c0602574>] (__driver_attach) from [<c0600418>] (bus_for_each_dev+0x70/0xb4)
[   25.192779] [<c0600418>] (bus_for_each_dev) from [<c06015a8>] (bus_add_driver+0x198/0x1fc)
[   25.192779] [<c06015a8>] (bus_add_driver) from [<c06032ec>] (driver_register+0x74/0x108)
[   25.215332] [<c06032ec>] (driver_register) from [<c060425c>] (__platform_register_drivers+0x54/0xd0)
[   25.222747] [<c060425c>] (__platform_register_drivers) from [<c0102fe4>] (do_one_initcall+0x80/0x31c)
[   25.233795] [<c0102fe4>] (do_one_initcall) from [<c01f0fc4>] (do_init_module+0x5c/0x1f8)
[   25.241943] [<c01f0fc4>] (do_init_module) from [<c01f2e0c>] (load_module+0x1360/0x16c0)
[   25.242767] [<c01f2e0c>] (load_module) from [<c01f33d4>] (sys_finit_module+0xbc/0xdc)
[   25.252838] [<c01f33d4>] (sys_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   25.262725] Exception stack(0xed993fa8 to 0xed993ff0)
[   25.267669] 3fa0:                   00040000 00000000 00000007 0045829e 00000000 0046bf30
[   25.272827] 3fc0: 00040000 00000000 00040000 0000017b b6f69610 00040000 00000000 0046bf30
[   25.282775] 3fe0: be92f984 be92f968 00450fc4 b6f022d8
[   25.292694] irq event stamp: 16738
[   25.292877] hardirqs last  enabled at (16737): [<c0909534>] _raw_spin_unlock_irqrestore+0x3c/0x44
[   25.305053] hardirqs last disabled at (16738): [<c01019e0>] __irq_svc+0x60/0x98
[   25.305053] softirqs last  enabled at (16702): [<c0102464>] __do_softirq+0x2c4/0x514
[   25.320190] softirqs last disabled at (16689): [<c0141ba8>] irq_exit+0xc0/0x1a0
[   25.322753] ---[ end trace a2d85a181bf0d3fb ]---
[   25.332336] Unhandled fault: imprecise external abort (0x1406) at 0xbf47f074
[   25.332855] pgd = (ptrval)
[   25.332855] [bf47f074] *pgd=ad997811, *pte=be51665f, *ppte=be51645f
[   25.342864] Internal error: : 1406 [#1] SMP ARM
[   25.352752] Modules linked in: omapdss(+) drm drm_panel_orientation_quirks omapdss_base cec cfbimgblt cfbfillrect cfbcopyarea
gpio_pca953x hid_generic usbhid smsc95xx smsc75xx usbnet usb_f_acm u_ether usb_f_mass_storage usb_f_serial u_serial xhci_plat_hcd
 xhci_hcd dwc3_omap dwc3 ohci_hcd ehci_hcd phy_omap_usb2 phy_generic libcomposite udc_core snd_soc_simple_card snd_soc_simple_car
d_utils snd_usb_audio snd_usbmidi_lib usbcore usb_common snd_soc_omap_mcbsp snd_soc_omap_dmic snd_soc_omap_twl4030 snd_soc_dmic s
nd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_sdma snd_soc_twl6040 snd_soc_twl4030 snd_soc_core snd_hwdep snd_pcm_dmaengine
snd_pcm snd_timer snd_rawmidi snd soundcore rtc_ds1307 rtc_palmas rtc_twl palmas_pwrbutton extcon_palmas cpufreq_dt ti_soc_therma
l thermal_sys hwmon clk_palmas lib80211 ccm
[   25.422729] CPU: 0 PID: 508 Comm: modprobe Tainted: G        W         4.19.0-rc8-next-20181019 #976
[   25.432800] Hardware name: Generic OMAP4 (Flattened Device Tree)
[   25.433746] PC is at dsi_probe+0x428/0x60c [omapdss]
[   25.444854] LR is at lockdep_hardirqs_on+0x108/0x1e0
[   25.444854] pc : [<bf46b850>]    lr : [<c01a3cd4>]    psr: 20000013
[   25.452728] sp : ed993cb0  ip : 00000001  fp : bf477048
[   25.460693] r10: 0000002a  r9 : bf47f160  r8 : eda79484
[   25.462768] r7 : eebeb810  r6 : eebeb800  r5 : eda7b480  r4 : eda79010
[   25.472717] r3 : bf4795a8  r2 : 00000001  r1 : 00000001  r0 : eebeb810
[   25.472717] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   25.482788] Control: 10c5387d  Table: ad99804a  DAC: 00000051
[   25.482788] Process modprobe (pid: 508, stack limit = 0x(ptrval))
[   25.498809] Stack: (0xed993cb0 to 0xed994000)
[   25.502838] 3ca0:                                     00000080 eeba6480 eda79010 bf47f160
[   25.502838] 3cc0: eebeb810 00000000 bf47f160 00000000 00000000 c0604184 eebeb810 c1600d20
[   25.512756] 3ce0: c1600d24 00000000 00000000 c0602134 eebeb810 bf47f160 eebeb844 c0e08948
[   25.522735] 3d00: c0604100 c060413c c0e9cd68 c0602388 c0e08948 c0604100 c060413c eebeb810
[   25.536071] 3d20: bf47f160 eebeb844 c0e08948 c0604100 c060413c c0602574 eeb9d150 bf47f160
[   25.542755] 3d40: c0602490 c0600418 ed983d80 eea26ea4 eeb9d150 acef1296 eea26ed4 bf47f160
[   25.542755] 3d60: ed983d80 c0e9cd68 00000000 c06015a8 bf47c2ac bf47f280 00000006 bf47f160
[   25.560729] 3d80: bf47f280 00000006 c0603c40 c06032ec 00000002 bf47f280 00000006 c060425c
[   25.562744] 3da0: bf477044 bf47703c 60000013 c0ec3c60 c0e08974 c0e08948 bf489000 00000000
[   25.572784] 3dc0: c0ec2de4 bf47f280 c0e08948 c0102fe4 c02730ec c01a3778 ffffe000 00000000
[   25.582733] 3de0: 60000013 c0e08974 ee8000c0 c019f1c4 c0e8835c c0ec2fe5 c0ec49f8 c01be6b8
[   25.592773] 3e00: ed99df00 c02c6e90 60000013 edb1f800 ffffe000 0000000c 60000013 acef1296
[   25.592773] 3e20: bf47f280 c0ec4318 ed99df00 bf47f3f0 bf47f28c 00000000 bf47f280 c01f0fc4
[   25.602752] 3e40: c0e8835c c0ec4318 c0ec2eee c0ec4318 c0e08974 c01f2e0c ffff8000 00007fff
[   25.612731] 3e60: bf47f280 c01f0204 bf47f3d4 0045829e bf480000 00000000 bf47f280 c0a05f28
[   25.622802] 3e80: ed993f2c c0bc972c c02e0001 00000000 c0c64ff4 c0c5659c 00000000 00000000
[   25.632751] 3ea0: 00000000 00000000 00000000 00000000 6e72656b 00006c65 00000000 00000000
[   25.642730] 3ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   25.642730] 3ee0: 00000000 00000000 00000000 acef1296 7fffffff c0e08948 00000000 00000007
[   25.659362] 3f00: 0045829e 7fffffff 00000000 0000017b 0046bf30 c01f33d4 7fffffff 00000000
[   25.666076] 3f20: 00000003 c019cfa4 ed993f4c f4552000 000e4214 00000000 f456cab7 f45712c0
[   25.672790] 3f40: f4552000 000e4214 f46358b4 f4635648 f460aa20 00021000 00025920 00000000
[   25.684020] 3f60: 00000000 00000000 00009c20 00000039 0000003a 0000001c 00000020 00000013
[   25.684020] 3f80: 00000000 acef1296 00000728 00040000 00000000 00040000 0000017b c01011c4
[   25.692840] 3fa0: ed992000 c0101000 00040000 00000000 00000007 0045829e 00000000 0046bf30
[   25.702758] 3fc0: 00040000 00000000 00040000 0000017b b6f69610 00040000 00000000 0046bf30
[   25.716888] 3fe0: be92f984 be92f968 00450fc4 b6f022d8 60000010 00000007 00000000 00000000
[   25.725189] [<bf46b850>] (dsi_probe [omapdss]) from [<c0604184>] (platform_drv_probe+0x48/0x98)
[   25.732757] [<c0604184>] (platform_drv_probe) from [<c0602134>] (really_probe+0x1dc/0x2d0)
[   25.742248] [<c0602134>] (really_probe) from [<c0602388>] (driver_probe_device+0x5c/0x164)
[   25.743286] [<c0602388>] (driver_probe_device) from [<c0602574>] (__driver_attach+0xe4/0xe8)
[   25.752716] [<c0602574>] (__driver_attach) from [<c0600418>] (bus_for_each_dev+0x70/0xb4)
[   25.762786] [<c0600418>] (bus_for_each_dev) from [<c06015a8>] (bus_add_driver+0x198/0x1fc)
[   25.772796] [<c06015a8>] (bus_add_driver) from [<c06032ec>] (driver_register+0x74/0x108)
[   25.782714] [<c06032ec>] (driver_register) from [<c060425c>] (__platform_register_drivers+0x54/0xd0)
[   25.792877] [<c060425c>] (__platform_register_drivers) from [<c0102fe4>] (do_one_initcall+0x80/0x31c)
[   25.792877] [<c0102fe4>] (do_one_initcall) from [<c01f0fc4>] (do_init_module+0x5c/0x1f8)
[   25.802825] [<c01f0fc4>] (do_init_module) from [<c01f2e0c>] (load_module+0x1360/0x16c0)
[   25.812744] [<c01f2e0c>] (load_module) from [<c01f33d4>] (sys_finit_module+0xbc/0xdc)
[   25.822784] [<c01f33d4>] (sys_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   25.832794] Exception stack(0xed993fa8 to 0xed993ff0)
[   25.834411] 3fa0:                   00040000 00000000 00000007 0045829e 00000000 0046bf30
[   25.842773] 3fc0: 00040000 00000000 00040000 0000017b b6f69610 00040000 00000000 0046bf30
[   25.852752] 3fe0: be92f984 be92f968 00450fc4 b6f022d8
[   25.855926] Code: 0affff98 eb471873 e5840024 eaffffa3 (e3a02008)
[   25.862731] ---[ end trace a2d85a181bf0d3fc ]---
Segmentation fault
