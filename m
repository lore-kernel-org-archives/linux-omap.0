From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Tue, 20 Sep 2016 09:36:27 +0300
Message-ID: <1688038.txo7nUYeUv@avalon>
References: <20160912153947.k4gnggur6usyujii@atomide.com> <2377851.ZR7UYeyr7h@avalon> <20160919224149.3msqxiv24ofwjz4c@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160919224149.3msqxiv24ofwjz4c-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 19 Sep 2016 15:41:50 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160919 13:35]:
> > On Sunday 18 Sep 2016 08:19:02 Tony Lindgren wrote:
> >>> [    5.711303] [<c0872788>] (_raw_spin_unlock_irqrestore) from
> >>> [<c069b260>]
> >>> (musb_gadget_queue+0x128/0x4ac)
> >>> [    5.711303] [<c069b260>] (musb_gadget_queue) from [<c06a9ae4>]
> >>> (usb_ep_queue+0x38/0x1d4)
> >>> [    5.729766] [<c06a9ae4>] (usb_ep_queue) from [<c06aba40>]
> >>> (rx_submit+0xc8/0x19c)
> >>> [    5.737548] [<c06aba40>] (rx_submit) from [<c06abb90>]
> >>> (rx_fill+0x7c/0xa0) [    5.737548] [<c06abb90>] (rx_fill) from
> >>> [<c06abbdc>] (eth_start+0x28/0x48) [    5.751983] [<c06abbdc>]
> >>> (eth_start) from [<c06abe7c>] (eth_open+0x6c/0x7c) [    5.751983]
> >>> [<c06abe7c>] (eth_open) from [<c0778c2c>]
> >>> (__dev_open+0x9c/0x104)
> >> 
> >> This could be something else though. Care to email me your .config,
> >> maybe this is related to legacy g_ether being built in?
> > 
> > Sure, please find it attached. The legacy g_ether is indeed built-in,
> > that's what I use to boot over nfsroot.
> 
> OK, I think g_ether may have issues in general..
> 
> I mostly test with configfs based gadgets and shell script as then I can
> test load/configure/connect/disconnect/unconfigure/unload easily :)

g_ether is very convenient when using nfsroot, as it allows booting the system 
without an initramfs.

> >> Anyways, please also give the following patch a try.
> > 
> > I've tested the patch and if fixes the original problem. Warm reboots are
> > still broken though.
> 
> No luck here with your .config a try with my pandaboard es against v4.8-rc7
> plus the patch I posted on Sunday. It reboots with no errors for me with
> NFSroot. Do you do something other than just reboot?

No, I perform the following steps:

- Connect the panda board to the USB through USB (which powers the board on)
- Let the board boot over NFS
- Log in as root, run 'reboot'

The second boot produces the warning.

[    5.189025] ------------[ cut here ]------------
[    5.193450] WARNING: CPU: 0 PID: 1 at 
/home/laurent/src/kernel/omap4/linux-2.6/drivers/bus/omap_l3_noc.c:147 
l3_interrupt_handler+0x220/0x348
[    5.198059] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read): 
Data Access in User mode during Functional access
[    5.218933] Modules linked in:
[    5.218933] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc2-00816-
g0caf606bb84a #20
[    5.222167] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    5.233612] [<c01101b0>] (unwind_backtrace) from [<c010c10c>] 
(show_stack+0x10/0x14)
[    5.233612] [<c010c10c>] (show_stack) from [<c048ca40>] 
(dump_stack+0xa8/0xe0)
[    5.233612] [<c048ca40>] (dump_stack) from [<c0137910>] (__warn+0xd8/0x104)
[    5.253662] [<c0137910>] (__warn) from [<c01379e4>] 
(warn_slowpath_fmt+0x38/0x48)
[    5.253662] [<c01379e4>] (warn_slowpath_fmt) from [<c04befd0>] 
(l3_interrupt_handler+0x220/0x348)
[    5.277191] [<c04befd0>] (l3_interrupt_handler) from [<c019ec7c>] 
(__handle_irq_event_percpu+0x98/0x3ec)
[    5.277191] [<c019ec7c>] (__handle_irq_event_percpu) from [<c019efec>] 
(handle_irq_event_percpu+0x1c/0x58)
[    5.293426] [<c019efec>] (handle_irq_event_percpu) from [<c019f060>] 
(handle_irq_event+0x38/0x5c)
[    5.306610] [<c019f060>] (handle_irq_event) from [<c01a24e0>] 
(handle_fasteoi_irq+0xcc/0x1a4)
[    5.306610] [<c01a24e0>] (handle_fasteoi_irq) from [<c019e490>] 
(generic_handle_irq+0x18/0x28)
[    5.315582] [<c019e490>] (generic_handle_irq) from [<c019e5a4>] 
(__handle_domain_irq+0x64/0xdc)
[    5.315582] [<c019e5a4>] (__handle_domain_irq) from [<c010152c>] 
(gic_handle_irq+0x48/0x9c)
[    5.315582] [<c010152c>] (gic_handle_irq) from [<c086f930>] 
(__irq_svc+0x70/0x98)
[    5.350402] Exception stack(0xee8b7d18 to 0xee8b7d60)
[    5.350402] 7d00:                                                       
00000001 ee8b5328
[    5.364288] 7d20: 00000000 ee8b4d80 60000153 eee54010 eee54010 60000153 
00000002 c1603ae4
[    5.364288] 7d40: c0d029cc 0000016b c0f19314 ee8b7d68 c019268c c086f5c0 
20000153 ffffffff
[    5.381469] [<c086f930>] (__irq_svc) from [<c086f5c0>] 
(_raw_spin_unlock_irqrestore+0x34/0x44)
[    5.381469] [<c086f5c0>] (_raw_spin_unlock_irqrestore) from [<c06980d8>] 
(musb_gadget_queue+0x128/0x4ac)
[    5.390533] [<c06980d8>] (musb_gadget_queue) from [<c06a6920>] 
(usb_ep_queue+0x38/0x1d4)
[    5.408996] [<c06a6920>] (usb_ep_queue) from [<c06a887c>] 
(rx_submit+0xc8/0x19c)
[    5.408996] [<c06a887c>] (rx_submit) from [<c06a89cc>] (rx_fill+0x7c/0xa0)
[    5.408996] [<c06a89cc>] (rx_fill) from [<c06a8a18>] (eth_start+0x28/0x48)
[    5.431213] [<c06a8a18>] (eth_start) from [<c06a8cb8>] (eth_open+0x6c/0x7c)
[    5.431213] [<c06a8cb8>] (eth_open) from [<c0775a68>] 
(__dev_open+0x9c/0x104)
[    5.446044] [<c0775a68>] (__dev_open) from [<c0775cdc>] 
(__dev_change_flags+0x88/0x150)
[    5.446044] [<c0775cdc>] (__dev_change_flags) from [<c0775dc4>] 
(dev_change_flags+0x18/0x48)
[    5.454467] [<c0775dc4>] (dev_change_flags) from [<c0c515c4>] 
(ip_auto_config+0x194/0x1148)
[    5.454467] [<c0c515c4>] (ip_auto_config) from [<c0101870>] 
(do_one_initcall+0x3c/0x174)
[    5.480621] [<c0101870>] (do_one_initcall) from [<c0c00eb0>] 
(kernel_init_freeable+0x204/0x2e0)
[    5.480621] [<c0c00eb0>] (kernel_init_freeable) from [<c0868720>] 
(kernel_init+0x8/0x118)
[    5.480621] [<c0868720>] (kernel_init) from [<c0108430>] 
(ret_from_fork+0x14/0x24)
[    5.506347] ---[ end trace 9a597c69856245a5 ]---

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
