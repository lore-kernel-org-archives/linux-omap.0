From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: dwc3 gadget breaks on system suspend/resume
Date: Thu, 19 Jan 2017 13:46:02 +0200
Message-ID: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

We have system suspend resume working on dra7-evm in v4.10-rc but
dwc3 gadget breaks after system suspend resume.

Any hints how to fix it? Full backtrace below.

Another message that looks worry-some is
"[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to suspend device but active child"

If I unload gadget, then suspend/resume system then load gadget everything works fine.

cheers,
-roger

rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:01:01 2000
[   61.434863] PM: Syncing filesystems ... done.
[   61.439563] PM: Preparing system for sleep (mem)
[   61.445966] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   61.455285] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   61.464617] PM: Suspending system (mem)
[   61.468641] Suspending console(s) (use no_console_suspend to debug)
[   61.490595] PM: suspend of devices complete after 13.582 msecs
[   61.494404] PM: late suspend of devices complete after 3.799 msecs
[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to suspend device but active child
[   61.495348] omap-dwc3 488c0000.omap_dwc3_2: runtime PM trying to suspend device but active child
[   61.497601] omap-ocp2scp 4a080000.ocp2scp: runtime PM trying to suspend device but active child
[   61.497634] ahci 4a140000.sata: runtime PM trying to suspend device but active child
[   61.497660] omap-ocp2scp 4a090000.ocp2scp: runtime PM trying to suspend device but active child
[   61.498454] PM: noirq suspend of devices complete after 4.042 msecs
[   61.498458] Disabling non-boot CPUs ...
[   61.499492] CPU1: shutdown
[   61.554081] Successfully put all powerdomains to target state
[   61.554081] Suspended for 3.833 seconds
[   61.554094] Enabling non-boot CPUs ...
[   61.583410] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   61.583753] CPU1 is up
[   61.585775] PM: noirq resume of devices complete after 2.013 msecs
[   61.588224] PM: early resume of devices complete after 1.981 msecs
[   61.590256] net eth0: initializing cpsw version 1.15 (0)
[   61.696078] Generic PHY 48485000.mdio:02: attached PHY driver [Generic PHY] (mii_bus:phy_addr=48485000.mdio:02, irq=-1)
[   61.707591] PM: resume of devices complete after 119.358 msecs
[   61.816446] zero gadget: suspend
[   61.816450] zero gadget: zero_suspend
[   61.846681] PM: Finishing wakeup.
[   61.850156] Restarting tasks ... done.
root@rockdesk:~# [   61.925469] ata1: SATA link down (SStatus 0 SControl 300)
[   61.945352] zero gadget: reset config
[   61.949199] ------------[ cut here ]------------
[   61.954065] WARNING: CPU: 1 PID: 2127 at drivers/usb/dwc3/gadget.c:2384 dwc3_stop_active_transfer.constprop.4+0xc4/0xe4 [dwc3]
[   61.966015] Modules linked in: usb_f_ss_lb g_zero libcomposite xhci_plat_hcd xhci_hcd usbcore dwc3 udc_core snd_soc_tlv320aic3x snd_soc_simple_card snd_soc_davinci_mcasp evdev snd_soc_simple_card_utils m25p8e
[   62.013916] CPU: 1 PID: 2127 Comm: irq/457-dwc3 Tainted: G        W       4.10.0-rc4-00108-gfb1d8e0 #1084
[   62.023951] Hardware name: Generic DRA74X (Flattened Device Tree)
[   62.030357] [<c0110194>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[   62.038483] [<c010c300>] (show_stack) from [<c04a0758>] (dump_stack+0xac/0xe0)
[   62.046068] [<c04a0758>] (dump_stack) from [<c013706c>] (__warn+0xd8/0x104)
[   62.053376] [<c013706c>] (__warn) from [<c0137144>] (warn_slowpath_null+0x20/0x28)
[   62.061347] [<c0137144>] (warn_slowpath_null) from [<bf2b684c>] (dwc3_stop_active_transfer.constprop.4+0xc4/0xe4 [dwc3])
[   62.072800] [<bf2b684c>] (dwc3_stop_active_transfer.constprop.4 [dwc3]) from [<bf2b9b14>] (__dwc3_gadget_ep_disable+0x64/0x528 [dwc3])
[   62.085516] [<bf2b9b14>] (__dwc3_gadget_ep_disable [dwc3]) from [<bf2bb27c>] (dwc3_gadget_ep_disable+0x3c/0xc8 [dwc3])
[   62.096779] [<bf2bb27c>] (dwc3_gadget_ep_disable [dwc3]) from [<bf280428>] (usb_ep_disable+0x11c/0x18c [udc_core])
[   62.107665] [<bf280428>] (usb_ep_disable [udc_core]) from [<bf386774>] (disable_ep+0x18/0x54 [usb_f_ss_lb])
[   62.117907] [<bf386774>] (disable_ep [usb_f_ss_lb]) from [<bf3877b0>] (disable_endpoints+0x18/0x50 [usb_f_ss_lb])
[   62.128681] [<bf3877b0>] (disable_endpoints [usb_f_ss_lb]) from [<bf387814>] (disable_source_sink+0x2c/0x34 [usb_f_ss_lb])
[   62.140291] [<bf387814>] (disable_source_sink [usb_f_ss_lb]) from [<bf36ca9c>] (reset_config+0x48/0x7c [libcomposite])
[   62.151552] [<bf36ca9c>] (reset_config [libcomposite]) from [<bf36cafc>] (composite_disconnect+0x2c/0x54 [libcomposite])
[   62.162980] [<bf36cafc>] (composite_disconnect [libcomposite]) from [<bf2827dc>] (usb_gadget_udc_reset+0x10/0x34 [udc_core])
[   62.174778] [<bf2827dc>] (usb_gadget_udc_reset [udc_core]) from [<bf2b5d70>] (dwc3_gadget_reset_interrupt+0x64/0x698 [dwc3])
[   62.186580] [<bf2b5d70>] (dwc3_gadget_reset_interrupt [dwc3]) from [<bf2b852c>] (dwc3_thread_interrupt+0x618/0x1a3c [dwc3])
[   62.198284] [<bf2b852c>] (dwc3_thread_interrupt [dwc3]) from [<c01a7cd8>] (irq_thread_fn+0x1c/0x54)
[   62.207777] [<c01a7cd8>] (irq_thread_fn) from [<c01a7fac>] (irq_thread+0x120/0x1f0)
[   62.215817] [<c01a7fac>] (irq_thread) from [<c015ba08>] (kthread+0xf8/0x138)
[   62.223221] [<c015ba08>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)
[   62.230792] ---[ end trace bf9da8b9a4f9b671 ]---
[   63.759582] cpsw 48484000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
