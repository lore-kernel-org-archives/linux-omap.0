From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Gadget regression with u_ether in Linux next
Date: Fri, 16 Sep 2016 15:03:56 -0700
Message-ID: <20160916220355.w6whbd75eqegrz3q@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit c9ffc78745f8 ("usb: gadget: NCM: Protect dev->port_usb
using dev->lock") causes hangs for me with Linux next.

Reverting c9ffc78745f8 makes the issues go away, some more info below.

Regards,

Tony

8< --------------------
With gadgets configured and after connecting the cable:

configfs-gadget gadget: high-speed config #1: c
configfs-gadget gadget: init ecm
configfs-gadget gadget: notify connect false
configfs-gadget gadget: reset acm ttyGS0
configfs-gadget gadget: activate acm ttyGS0
gserial_connect: start ttyGS0
configfs-gadget gadget: acm ttyGS0 serial state 0003
configfs-gadget gadget: notify speed 425984000
configfs-gadget gadget: activate ecm
usb0: qlen 10
configfs-gadget gadget: ecm_open
usb0: eth_start
configfs-gadget gadget: packet filter 0c
configfs-gadget gadget: ecm req21.43 v000c i0000 l0
configfs-gadget gadget: acm ttyGS0 req21.20 v0000 i0002 l7
IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
configfs-gadget gadget: packet filter 0e
configfs-gadget gadget: ecm req21.43 v000e i0000 l0
configfs-gadget gadget: notify connect true
configfs-gadget gadget: notify speed 425984000
BUG: spinlock lockup suspected on CPU#0, swapper/0/0
 lock: 0xdd4f7e00, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc6-next-20160915+ #608
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c01102c0>] (unwind_backtrace) from [<c010c41c>] (show_stack+0x10/0x14)
[<c010c41c>] (show_stack) from [<c048d01c>] (dump_stack+0xb0/0xe4)
[<c048d01c>] (dump_stack) from [<c0196b4c>] (do_raw_spin_lock+0x114/0x1b8)
[<c0196b4c>] (do_raw_spin_lock) from [<c07cc650>] (_raw_spin_lock_irqsave+0x40/0x4c)
[<c07cc650>] (_raw_spin_lock_irqsave) from [<bf046ff0>] (rx_submit+0x14/0x1a0 [u_ether])
[<bf046ff0>] (rx_submit [u_ether]) from [<bf01325c>] (usb_gadget_giveback_request+0x64/0)
[<bf01325c>] (usb_gadget_giveback_request [udc_core]) from [<bf1b85b8>] (musb_g_giveback)
[<bf1b85b8>] (musb_g_giveback [musb_hdrc]) from [<bf1af160>] (musb_interrupt+0x174/0x30c)
[<bf1af160>] (musb_interrupt [musb_hdrc]) from [<bf1dc664>] (omap2430_musb_interrupt+0x8)
[<bf1dc664>] (omap2430_musb_interrupt [omap2430]) from [<c01a0950>] (__handle_irq_event_)
[<c01a0950>] (__handle_irq_event_percpu) from [<c01a0cf0>] (handle_irq_event_percpu+0x1c)
[<c01a0cf0>] (handle_irq_event_percpu) from [<c01a0d64>] (handle_irq_event+0x38/0x5c)
[<c01a0d64>] (handle_irq_event) from [<c01a405c>] (handle_level_irq+0xb8/0x144)
[<c01a405c>] (handle_level_irq) from [<c019fc84>] (generic_handle_irq+0x20/0x34)
[<c019fc84>] (generic_handle_irq) from [<c01a01c8>] (__handle_domain_irq+0x64/0xdc)
[<c01a01c8>] (__handle_domain_irq) from [<c07cce70>] (__irq_svc+0x70/0x98)
[<c07cce70>] (__irq_svc) from [<c0618150>] (cpuidle_enter_state+0xb8/0x3c4)
[<c0618150>] (cpuidle_enter_state) from [<c01869cc>] (cpu_startup_entry+0x130/0x220)
[<c01869cc>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
